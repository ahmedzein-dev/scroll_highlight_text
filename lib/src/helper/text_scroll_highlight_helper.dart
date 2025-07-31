import 'package:flutter/material.dart';

import '../highlighted_text_scrollable.dart';
import '../styling/app_spacing.dart';

class TextScrollHighlight {
  static void scrollToHighlightedText(String inputText) {
    final keyCurrentState = _getKeyCurrentState();
    if (keyCurrentState == null) return;

    if (inputText.isEmpty) {
      keyCurrentState.applyHighlightedText([]);
      return;
    }

    final regex = RegExp(inputText.trim(), caseSensitive: false);
    final matches = regex.allMatches(keyCurrentState.widget.text);
    final textSpans =
        TextScrollHighlightHelper._highlightSearchedText(regex, matches);
    keyCurrentState.applyHighlightedText(textSpans);

    if (textSpans.isNotEmpty) {
      TextScrollHighlightHelper._scrollToWord(matches, textSpans.first.text);
    }
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

  static List<TextSpan> _highlightSearchedText(
      RegExp regex, Iterable<RegExpMatch> matches) {
    if (matches.isEmpty) return [];

    List<TextSpan> spans = [];
    List<String> parts = _currentState.widget.text.split(regex);
    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(
        text: parts[i],
        style: _currentState.widget.unHighlightedTextStyle,
      ));
      if (i < parts.length - 1) {
        spans.add(TextSpan(
          text: regex.stringMatch(_currentState.widget.text),
          style: _currentState.widget.highlightedTextStyle,
        ));
      }
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
        ? AppSpacing.twoLines
        : AppSpacing.threeLines;
    final offset = ((lineNumber +
                _countTextEmptyLines(_currentState, textBeforeFirstMatch) -
                defaultLines) *
            _getTextPainter(_currentState).height) +
        _currentState.widget.padding.vertical / 2;
    return offset;
  }
}
