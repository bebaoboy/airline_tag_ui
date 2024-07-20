import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class SimplePicker extends StatefulWidget {
  final int selectedItemIndex;
  final Function(int)? onChange;
  final List<String> items;
  final TextStyle textStyle;
  final TextStyle? selectedTextStyle;
  final double itemExtent;
  final Widget? selectionOverlay;
  const SimplePicker({
    super.key,
    required this.items,
    required this.onChange,
    required this.selectedItemIndex,
    required this.textStyle,
    this.selectedTextStyle,
    required this.itemExtent,
    this.selectionOverlay,
  });
  @override
  State<SimplePicker> createState() => _SimplePickerState();
}

class _SimplePickerState extends State<SimplePicker> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple,
            Colors.transparent,
            Colors.transparent,
            Colors.purple
          ],
          stops: [
            0.15,
            0.4,
            0.7,
            1.0
          ], // 10% purple, 80% transparent, 10% purple
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstOut,
      child: CustomCupertinoPicker.builder(
        itemExtent: widget.itemExtent,
        diameterRatio: 5,
        childCount: widget.items.length,
        magnification: 1.2,
        squeeze: 0.9,
        selectionOverlay: widget.selectionOverlay ??
            const CupertinoPickerDefaultSelectionOverlay(),
        scrollController: FixedExtentScrollController(
          initialItem: widget.selectedItemIndex,
        ),
        onSelectedItemChanged: widget.onChange,
        itemBuilder: (context, index) {
          print(widget.selectedItemIndex);
          return Center(
            child: AnimatedDefaultTextStyle(
              style: (widget.selectedItemIndex == index
                      ? widget.selectedTextStyle
                      : (widget.selectedItemIndex - index).abs() == 1
                          ? widget.selectedTextStyle!.copyWith(
                              color: widget.textStyle.color,
                              fontWeight: FontWeight.w600,
                              fontSize: widget.textStyle.fontSize! * 1.2,
                              backgroundColor: Colors.transparent)
                          : widget.textStyle)!
                  .copyWith(letterSpacing: 1.0),
              duration: Durations.medium4,
              child: Text(
                widget.items[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

const Color _kHighlighterBorder = CupertinoDynamicColor.withBrightness(
  color: Color(0x33000000),
  darkColor: Color(0x33FFFFFF),
);
// Eyeballed values comparing with a native picker to produce the right
// curvatures and densities.
const double _kDefaultDiameterRatio = 1.07;
const double _kDefaultPerspective = 0.005;
const double _kSqueeze = 1.45;

// Opacity fraction value that dims the wheel above and below the "magnifier"
// lens.
const double _kOverAndUnderCenterOpacity = 0.8;

class CustomCupertinoPicker extends StatefulWidget {
  CustomCupertinoPicker({
    super.key,
    this.diameterRatio = _kDefaultDiameterRatio,
    this.backgroundColor,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.scrollController,
    this.squeeze = _kSqueeze,
    this.highlighterBorderColor = _kHighlighterBorder,
    this.highlighterBorder,
    this.highlighterBorderWidth,
    this.scrollPhysics,
    required this.itemExtent,
    required this.onSelectedItemChanged,
    required List<Widget> children,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
    bool looping = false,
  })  : assert(diameterRatio > 0.0,
            RenderListWheelViewport.diameterRatioZeroMessage),
        assert(magnification > 0),
        assert(highlighterBorderColor != null),
        assert(itemExtent > 0),
        assert(squeeze > 0),
        childDelegate = looping
            ? ListWheelChildLoopingListDelegate(children: children)
            : ListWheelChildListDelegate(children: children);
  CustomCupertinoPicker.builder({
    super.key,
    this.diameterRatio = _kDefaultDiameterRatio,
    this.backgroundColor,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.scrollController,
    this.squeeze = _kSqueeze,
    this.highlighterBorderColor = _kHighlighterBorder,
    this.highlighterBorder,
    this.highlighterBorderWidth,
    this.scrollPhysics,
    required this.itemExtent,
    required this.onSelectedItemChanged,
    required NullableIndexedWidgetBuilder itemBuilder,
    int? childCount,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
  })  : assert(diameterRatio > 0.0,
            RenderListWheelViewport.diameterRatioZeroMessage),
        assert(magnification > 0),
        assert(highlighterBorderColor != null),
        assert(itemExtent > 0),
        assert(squeeze > 0),
        childDelegate = ListWheelChildBuilderDelegate(
            builder: itemBuilder, childCount: childCount);
  final double diameterRatio;
  final Color? backgroundColor;
  final double offAxisFraction;
  final bool useMagnifier;
  final double magnification;
  final FixedExtentScrollController? scrollController;
  final double itemExtent;
  final double squeeze;
  final ValueChanged<int>? onSelectedItemChanged;
  final ListWheelChildDelegate childDelegate;
  final Color? highlighterBorderColor;
  final Border? highlighterBorder;
  final double? highlighterBorderWidth;
  final ScrollPhysics? scrollPhysics;
  final Widget? selectionOverlay;
  @override
  State<StatefulWidget> createState() => _CupertinoPickerState();
}

class _CupertinoPickerState extends State<CustomCupertinoPicker> {
  int? _lastHapticIndex;
  FixedExtentScrollController? _controller;
  @override
  void initState() {
    super.initState();
    if (widget.scrollController == null) {
      _controller = FixedExtentScrollController();
    }
  }

  @override
  void didUpdateWidget(CustomCupertinoPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != null && oldWidget.scrollController == null) {
      _controller = null;
    } else if (widget.scrollController == null &&
        oldWidget.scrollController != null) {
      assert(_controller == null);
      _controller = FixedExtentScrollController();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handleSelectedItemChanged(int index) {
    // Only the haptic engine hardware on iOS devices would produce the
    // intended effects.
    final bool hasSuitableHapticHardware;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        hasSuitableHapticHardware = true;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        hasSuitableHapticHardware = false;
        break;
    }
    // assert(hasSuitableHapticHardware != null);
    if (hasSuitableHapticHardware && index != _lastHapticIndex) {
      _lastHapticIndex = index;
      HapticFeedback.selectionClick();
    }
    widget.onSelectedItemChanged?.call(index);
  }

  Widget _buildSelectionOverlay(Widget selectionOverlay) {
    // final double height = widget.itemExtent * widget.magnification;
    final resolvedBorderColor = CupertinoDynamicColor.maybeResolve(
        widget.highlighterBorderColor, context);
    BoxBorder? defaultBoxBorder;
    if (resolvedBorderColor != null) {
      defaultBoxBorder = Border(
        top: BorderSide(width: 0.0, color: resolvedBorderColor),
        bottom: BorderSide(width: 0.0, color: resolvedBorderColor),
      );
    }
    return IgnorePointer(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: widget.highlighterBorder ?? defaultBoxBorder,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(
              // height: height,
              width: widget.highlighterBorderWidth,
            ),
            child: selectionOverlay,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        CupertinoTheme.of(context).textTheme.pickerTextStyle;
    final Color? resolvedBackgroundColor = CupertinoDynamicColor.maybeResolve(
        widget.backgroundColor,
        context); // assert(RenderListWheelViewport.defaultPerspective == _kDefaultPerspective);
    final Widget result = DefaultTextStyle(
      style: textStyle.copyWith(
          color: CupertinoDynamicColor.maybeResolve(textStyle.color, context)),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: _CupertinoPickerSemantics(
              scrollController: widget.scrollController ?? _controller!,
              child: ListWheelScrollView.useDelegate(
                perspective: _kDefaultPerspective,
                controller: widget.scrollController ?? _controller,
                physics:
                    widget.scrollPhysics ?? const FixedExtentScrollPhysics(),
                diameterRatio: widget.diameterRatio,
                offAxisFraction: widget.offAxisFraction,
                useMagnifier: widget.useMagnifier,
                magnification: widget.magnification,
                overAndUnderCenterOpacity: _kOverAndUnderCenterOpacity,
                itemExtent: widget.itemExtent,
                squeeze: widget.squeeze,
                onSelectedItemChanged: _handleSelectedItemChanged,
                childDelegate: widget.childDelegate,
              ),
            ),
          ),
          if (widget.selectionOverlay != null)
            _buildSelectionOverlay(widget.selectionOverlay!),
        ],
      ),
    );
    return DecoratedBox(
      decoration: BoxDecoration(color: resolvedBackgroundColor),
      child: result,
    );
  }
}

class CupertinoPickerDefaultSelectionOverlay extends StatelessWidget {
  const CupertinoPickerDefaultSelectionOverlay({
    super.key,
    // this.background = CupertinoColors.tertiarySystemFill,
    this.background = const Color(0x00000000),
    this.capStartEdge = true,
    this.capEndEdge = true,
  });
  final bool capStartEdge;
  final bool capEndEdge;
  final Color background;
  static const double _defaultSelectionOverlayHorizontalMargin = 9;
  static const double _defaultSelectionOverlayRadius = 8;
  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(_defaultSelectionOverlayRadius);
    return Container(
      margin: EdgeInsetsDirectional.only(
        start: capStartEdge ? _defaultSelectionOverlayHorizontalMargin : 0,
        end: capEndEdge ? _defaultSelectionOverlayHorizontalMargin : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.horizontal(
          start: capStartEdge ? radius : Radius.zero,
          end: capEndEdge ? radius : Radius.zero,
        ),
        color: CupertinoDynamicColor.resolve(background, context),
      ),
    );
  }
}

class _CupertinoPickerSemantics extends SingleChildRenderObjectWidget {
  const _CupertinoPickerSemantics({
    super.child,
    required this.scrollController,
  });
  final FixedExtentScrollController scrollController;
  @override
  RenderObject createRenderObject(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    return _RenderCupertinoPickerSemantics(
        scrollController, Directionality.of(context));
  }

  @override
  void updateRenderObject(BuildContext context,
      covariant _RenderCupertinoPickerSemantics renderObject) {
    assert(debugCheckHasDirectionality(context));
    renderObject
      ..textDirection = Directionality.of(context)
      ..controller = scrollController;
  }
}

class _RenderCupertinoPickerSemantics extends RenderProxyBox {
  _RenderCupertinoPickerSemantics(
      FixedExtentScrollController controller, this._textDirection) {
    _updateController(null, controller);
  }
  FixedExtentScrollController get controller => _controller;
  late FixedExtentScrollController _controller;
  set controller(FixedExtentScrollController value) =>
      _updateController(_controller, value);

  void _updateController(FixedExtentScrollController? oldValue,
      FixedExtentScrollController value) {
    if (value == oldValue) {
      return;
    }
    if (oldValue != null) {
      oldValue.removeListener(_handleScrollUpdate);
    } else {
      _currentIndex = value.initialItem;
    }
    value.addListener(_handleScrollUpdate);
    _controller = value;
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsSemanticsUpdate();
  }

  int _currentIndex = 0;
  void _handleIncrease() {
    controller.jumpToItem(_currentIndex + 1);
  }

  void _handleDecrease() {
    controller.jumpToItem(_currentIndex - 1);
  }

  void _handleScrollUpdate() {
    if (controller.selectedItem == _currentIndex) {
      return;
    }
    _currentIndex = controller.selectedItem;
    markNeedsSemanticsUpdate();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isSemanticBoundary = true;
    config.textDirection = textDirection;
  }

  @override
  void assembleSemanticsNode(SemanticsNode node, SemanticsConfiguration config,
      Iterable<SemanticsNode> children) {
    if (children.isEmpty) {
      return super.assembleSemanticsNode(node, config, children);
    }
    final SemanticsNode scrollable = children.first;
    final Map<int, SemanticsNode> indexedChildren = <int, SemanticsNode>{};
    scrollable.visitChildren((SemanticsNode child) {
      assert(child.indexInParent != null);
      indexedChildren[child.indexInParent!] = child;
      return true;
    });
    if (indexedChildren[_currentIndex] == null) {
      return node.updateWith(config: config);
    }
    config.value = indexedChildren[_currentIndex]!.label;
    final SemanticsNode? previousChild = indexedChildren[_currentIndex - 1];
    final SemanticsNode? nextChild = indexedChildren[_currentIndex + 1];
    if (nextChild != null) {
      config.increasedValue = nextChild.label;
      config.onIncrease = _handleIncrease;
    }
    if (previousChild != null) {
      config.decreasedValue = previousChild.label;
      config.onDecrease = _handleDecrease;
    }
    node.updateWith(config: config);
  }
}
