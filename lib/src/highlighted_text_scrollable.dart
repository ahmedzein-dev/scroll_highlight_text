import 'package:flutter/material.dart';
import 'package:scroll_highlight_text/src/helper/text_scroll_highlight_helper.dart';
import 'package:scroll_highlight_text/src/styling/app_spacing.dart';
import 'package:scroll_highlight_text/src/styling/app_styles.dart';

GlobalKey<HighlightedTextScrollableState> scrollToHighlightedTextGlobalKey =
    GlobalKey();

enum MatchNavigationType { bar, floating }

class HighlightedTextScrollable extends StatefulWidget {
  /// The text content to be displayed and scrolled through.
  final String text;

  /// The controller for the text field where the user inputs the search term.
  ///
  /// If [autoDisposeSearchController] is set to true (default), the controller
  /// will be disposed automatically when the widget is removed from the widget tree.
  /// If manual disposal is desired, set [autoDisposeSearchController] to false.
  /// Otherwise, you may encounter the error "A TextEditingController was used after being disposed."
  /// If [autoDisposeSearchController] is set to false, ensure to dispose the controller manually to avoid memory leaks and errors.
  final TextEditingController searchController;

  /// Auto dispose the [searchController] upon the destruction of widget from the widget tree. Default is [true]
  final bool autoDisposeSearchController;

  /// Text Directions
  ///
  /// `TextDirection.ltr`: Indicates that the text is laid out from left to right, which is the default direction for languages like English.
  /// `TextDirection.rtl`: Indicates that the text is laid out from right to left, which is the default direction for languages like Arabic and Hebrew.
  final TextDirection textDirection;

  /// The text style applied to highlighted words or phrases.
  final TextStyle highlightedTextStyle;

  /// The text style applied to the rest of the text.
  final TextStyle unHighlightedTextStyle;

  /// The internal padding around the text widget.
  /// Padding should only be applied internally within this widget, not from external sources.
  /// If you want to apply custom internal padding, make sure to pass it to `HighlightedTextScrollable`.
  /// This ensures that the padding is considered during the calculation process.
  ///
  /// This ensures that the `HighlightedTextScrollable` widget works correctly and scrolls to the position of the right word.
  final EdgeInsetsGeometry padding;

  /// The duration of the scrolling animation.
  final Duration durationOfScroll;

  /// The animation curve used for scrolling transitions.
  final Curve animationCurveOfScroll;

  /// When false (default), the search input is treated as a **literal** string
  /// and is escaped before creating the RegExp.
  ///
  /// When true, the input is treated as a raw RegExp pattern.
  final bool treatInputAsRegex;

  /// Whether the search should be case sensitive. Default is false.
  final bool caseSensitive;

  /// Called whenever matches are calculated.
  final void Function(int count)? onMatchesFound;

  /// Called when the highlighted/current match changes.
  /// `index` is 1-based (1..total). `total` is total match count.
  final void Function(int index, int total)? onMatchChanged;

  /// Called when the search text becomes empty.
  final VoidCallback? onSearchCleared;

  /// Called when search text is not empty but no matches found.
  final VoidCallback? onNoMatch;

  /// Show built-in match navigation (Prev/Next + `index/total`).
  final bool showMatchNavigation;

  /// Optional custom navigation bar builder.
  ///
  /// - `index` is 1-based (1..total) when total > 0, otherwise 0.
  /// - `total` is total match count.
  /// - `onPrevious` / `onNext` will navigate between matches.
  final Widget Function(
    BuildContext context,
    int index,
    int total,
    VoidCallback onPrevious,
    VoidCallback onNext,
  )? matchNavigationBuilder;

  /// Padding for the default navigation bar (when [matchNavigationBuilder] is null).
  final EdgeInsetsGeometry matchNavigationPadding;

  /// Choose between a top bar navigation or floating (FAB-like) navigation.
  ///
  /// This only applies when [showMatchNavigation] is true.
  final MatchNavigationType matchNavigationType;

  /// Padding for the floating navigation overlay.
  final EdgeInsetsGeometry floatingNavigationPadding;

  HighlightedTextScrollable({
    required this.text,
    required this.searchController,
    this.autoDisposeSearchController = true,
    this.textDirection = TextDirection.ltr,
    this.durationOfScroll = const Duration(milliseconds: 400),
    this.animationCurveOfScroll = Curves.ease,
    this.highlightedTextStyle = AppStyles.highlightedTextStyle,
    this.unHighlightedTextStyle = AppStyles.unHighlightedTextStyle,
    this.padding = const EdgeInsets.symmetric(
        horizontal: AppSpacing.defaultPadding,
        vertical: AppSpacing.mediumPadding),
    this.treatInputAsRegex = false,
    this.caseSensitive = false,
    this.onMatchesFound,
    this.onMatchChanged,
    this.onSearchCleared,
    this.onNoMatch,
    this.showMatchNavigation = false,
    this.matchNavigationBuilder,
    this.matchNavigationPadding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.defaultPadding,
      vertical: AppSpacing.smallPadding,
    ),
    this.matchNavigationType = MatchNavigationType.bar,
    this.floatingNavigationPadding = const EdgeInsets.all(
      AppSpacing.defaultPadding,
    ),
  }) : super(key: scrollToHighlightedTextGlobalKey);

  @override
  State<HighlightedTextScrollable> createState() =>
      HighlightedTextScrollableState();
}

class HighlightedTextScrollableState extends State<HighlightedTextScrollable> {
  final ScrollController scrollController = ScrollController();
  List<TextSpan>? textSpans;
  String? searchControllerCurrentValue;
  int _matchIndex = 0; // 1-based; 0 means none
  int _matchTotal = 0;
  @override
  void initState() {
    super.initState();
    searchControllerCurrentValue = '';
    textSpans = _initTextSpans();
    widget.searchController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (widget.autoDisposeSearchController) {
      widget.searchController.dispose();
    }
    widget.searchController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final String inputText = widget.searchController.text;
    if (_isInputTextNotEmpty(inputText)) {
      _updateSearchControllerCurrentValue(inputText);
    }

    _scrollToHighlightedText(inputText);
  }

  void _updateSearchControllerCurrentValue(String value) {
    searchControllerCurrentValue = value;
  }

  bool _isInputTextNotEmpty(String text) {
    return text.isNotEmpty;
  }

  void _scrollToHighlightedText(String inputText) {
    if (_isSearchControllerCurrentValueNotEmpty()) {
      TextScrollHighlight.scrollToHighlightedText(inputText);
    }
  }

  bool _isSearchControllerCurrentValueNotEmpty() {
    return searchControllerCurrentValue?.isNotEmpty ?? false;
  }

  void applyHighlightedText(final List<TextSpan> spans) {
    if (mounted) {
      setState(() {
        textSpans = spans.isEmpty ? _initTextSpans() : spans;
        if (spans.isEmpty) {
          scrollController.animateTo(0,
              duration: widget.durationOfScroll,
              curve: widget.animationCurveOfScroll);
        }
      });
    }
  }

  void updateMatchInfo({required int index, required int total}) {
    if (!mounted) return;
    setState(() {
      _matchIndex = index;
      _matchTotal = total;
    });
  }

  void resetMatchInfo() => updateMatchInfo(index: 0, total: 0);

  List<TextSpan> _initTextSpans() {
    return [
      TextSpan(
        text: widget.text,
        style: widget.unHighlightedTextStyle,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scrollView = SingleChildScrollView(
      padding: widget.padding,
      controller: scrollController,
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          children: textSpans,
        ),
      ),
    );

    return Directionality(
      textDirection: widget.textDirection,
      // Always render the text the same way as before.
      // If navigation is enabled, overlay floating buttons (FAB-like) on top.
      child: !widget.showMatchNavigation
          ? scrollView
          : Stack(
              children: [
                scrollView,
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: widget.floatingNavigationPadding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: Colors.black.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(999),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            child: Text(
                              _matchTotal == 0
                                  ? '0/0'
                                  : '$_matchIndex/$_matchTotal',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FloatingActionButton.small(
                          heroTag: '${hashCode}_prev',
                          onPressed: _matchTotal == 0
                              ? null
                              : TextScrollHighlight.previousMatch,
                          child: const Icon(Icons.keyboard_arrow_up),
                        ),
                        const SizedBox(height: 4),
                        FloatingActionButton.small(
                          heroTag: '${hashCode}_next',
                          onPressed: _matchTotal == 0
                              ? null
                              : TextScrollHighlight.nextMatch,
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
