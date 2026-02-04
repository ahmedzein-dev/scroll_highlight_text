import 'package:flutter/material.dart';

import '../highlighted_text_scrollable.dart';
import '../styling/app_spacing.dart';

class TextScrollHighlight {
  static List<RegExpMatch> _lastMatches = const [];
  static int _currentMatchIndex = 0; // 0-based

  static void scrollToHighlightedText(String inputText) {
    final keyCurrentState = _getKeyCurrentState();
    if (keyCurrentState == null) return;

    if (inputText.isEmpty) {
      _lastMatches = const [];
      _currentMatchIndex = 0;
      keyCurrentState.applyHighlightedText([]);
      keyCurrentState.resetMatchInfo();
      keyCurrentState.widget.onMatchesFound?.call(0);
      keyCurrentState.widget.onSearchCleared?.call();
      return;
    }

    final query = inputText.trim();
    final pattern =
        keyCurrentState.widget.treatInputAsRegex ? query : RegExp.escape(query);
    final regex =
        RegExp(pattern, caseSensitive: keyCurrentState.widget.caseSensitive);

    final matches = regex.allMatches(keyCurrentState.widget.text).toList();
    _lastMatches = matches;
    _currentMatchIndex = 0;

    keyCurrentState.widget.onMatchesFound?.call(matches.length);
    if (matches.isEmpty) {
      keyCurrentState.widget.onNoMatch?.call();
      keyCurrentState.resetMatchInfo();
    }

    final textSpans = TextScrollHighlightHelper._highlightSearchedText(matches);
    keyCurrentState.applyHighlightedText(textSpans);

    if (textSpans.isNotEmpty) {
      _scrollToMatchIndex(keyCurrentState, 0);
    }
  }

  /// Scroll to the next match (if any).
  static void nextMatch() {
    final keyCurrentState = _getKeyCurrentState();
    if (keyCurrentState == null) return;
    if (_lastMatches.isEmpty) return;
    _currentMatchIndex = (_currentMatchIndex + 1) % _lastMatches.length;
    _scrollToMatchIndex(keyCurrentState, _currentMatchIndex);
  }

  /// Scroll to the previous match (if any).
  static void previousMatch() {
    final keyCurrentState = _getKeyCurrentState();
    if (keyCurrentState == null) return;
    if (_lastMatches.isEmpty) return;
    _currentMatchIndex =
        (_currentMatchIndex - 1 + _lastMatches.length) % _lastMatches.length;
    _scrollToMatchIndex(keyCurrentState, _currentMatchIndex);
  }

  /// Scroll to a specific match index (0-based).
  static void jumpToMatch(int index) {
    final keyCurrentState = _getKeyCurrentState();
    if (keyCurrentState == null) return;
    if (_lastMatches.isEmpty) return;
    if (index < 0 || index >= _lastMatches.length) return;
    _currentMatchIndex = index;
    _scrollToMatchIndex(keyCurrentState, _currentMatchIndex);
  }

  static void _scrollToMatchIndex(
      HighlightedTextScrollableState keyCurrentState, int index) {
    if (_lastMatches.isEmpty) return;
    if (index < 0 || index >= _lastMatches.length) return;

    final match = _lastMatches[index];
    final textBeforeMatch =
        keyCurrentState.widget.text.substring(0, match.start);

    TextScrollHighlightHelper._scrollToWord([match], textBeforeMatch);
    keyCurrentState.updateMatchInfo(
        index: index + 1, total: _lastMatches.length);
    keyCurrentState.widget.onMatchChanged?.call(index + 1, _lastMatches.length);
  }

  static HighlightedTextScrollableState? _getKeyCurrentState() {
    final keyCurrentState = scrollToHighlightedTextGlobalKey.currentState;
    _setKeyCurrentState(keyCurrentState);
    return keyCurrentState;
  }

  static void _setKeyCurrentState(
      HighlightedTextScrollableState? keyCurrentState) {
    if (keyCurrentState != null) {
      TextScrollHighlightHelper._setKeyCurrentState(keyCurrentState);
    }
  }
}

class TextScrollHighlightHelper {
  static late HighlightedTextScrollableState _currentState;

  static void _setKeyCurrentState(
      HighlightedTextScrollableState highlightedTextScrollableState) {
    _currentState = highlightedTextScrollableState;
  }

  static List<TextSpan> _highlightSearchedText(List<RegExpMatch> matches) {
    if (matches.isEmpty) return [];

    final List<TextSpan> spans = [];
    final String text = _currentState.widget.text;
    int lastMatchEnd = 0;

    for (final match in matches) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: _currentState.widget.unHighlightedTextStyle,
        ),
      );

      spans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: _currentState.widget.highlightedTextStyle,
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd),
          style: _currentState.widget.unHighlightedTextStyle,
        ),
      );
    }

    return spans;
  }

  static void _scrollToWord(
      Iterable<Match> matches, String? textBeforeFirstMatch) {
    final numberOfCharactersInLine =
        _calculateNumberOfCharactersByScreenWidth();
    final lineNumber =
        ((matches.first.start / numberOfCharactersInLine)).floor();
    final offset = _calculateOffset(lineNumber, textBeforeFirstMatch);
    _currentState.scrollController.animateTo(
      offset,
      duration: _currentState.widget.durationOfScroll,
      curve: _currentState.widget.animationCurveOfScroll,
    );
  }

  static TextPainter _getTextPainter(
      HighlightedTextScrollableState currentState) {
    if (currentState.widget.textDirection == TextDirection.ltr) {
      return TextPainter(
        text: TextSpan(
            text: 'a', style: currentState.widget.unHighlightedTextStyle),
        textDirection: TextDirection.ltr,
      )..layout();
    } else {
      return TextPainter(
        text: TextSpan(
            text: 'و', style: currentState.widget.unHighlightedTextStyle),
        textDirection: TextDirection.rtl,
      )..layout();
    }
  }

  static int _calculateNumberOfCharactersByScreenWidth() {
    final screenWidth = MediaQuery.of(_currentState.context).size.width -
        _currentState.widget.padding.horizontal;
    return ((screenWidth / _getTextPainter(_currentState).width)).floor() +
        _getWhiteSpaceNumber(_currentState);
  }

  static int _getWhiteSpaceNumber(HighlightedTextScrollableState currentState) {
    return 120 ~/ currentState.widget.unHighlightedTextStyle.fontSize!;
  }

  static int _countTextEmptyLines(HighlightedTextScrollableState currentState,
      String? textBeforeFirstMatch) {
    if (textBeforeFirstMatch == null || textBeforeFirstMatch.isEmpty) return 0;
    final lines = textBeforeFirstMatch.split('\n'); // Split the text into lines
    return lines.where((line) => line.trim().isEmpty).length;
  }

  static double _calculateOffset(int lineNumber, String? textBeforeFirstMatch) {
    final defaultLines = _currentState.widget.textDirection == TextDirection.ltr
        ? AppSpacing.oneLine
        : AppSpacing.oneLine;
    final offset = ((lineNumber +
                _countTextEmptyLines(_currentState, textBeforeFirstMatch) -
                defaultLines) *
            _getTextPainter(_currentState).height) +
        _currentState.widget.padding.vertical / 2;
    return offset;
  }
}
