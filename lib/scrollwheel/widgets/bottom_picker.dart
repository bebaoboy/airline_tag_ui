import 'package:airline_tag_ui/scrollwheel/resources/arrays.dart';
import 'package:airline_tag_ui/scrollwheel/resources/time.dart';
import 'package:airline_tag_ui/scrollwheel/widgets/animated_tile.dart';
import 'package:airline_tag_ui/scrollwheel/widgets/bottom_picker_button.dart';
import 'package:airline_tag_ui/scrollwheel/widgets/close_icon.dart';
import 'package:airline_tag_ui/scrollwheel/widgets/simple_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airline_tag_ui/scrollwheel/resources/extensions.dart';
import 'package:intl/intl.dart' hide TextDirection;
export 'package:airline_tag_ui/scrollwheel/resources/time.dart';

// ignore: must_be_immutable
class BottomPicker extends StatefulWidget {
  late CupertinoDatePickerMode datePickerMode;
  late BottomPickerType bottomPickerType;
  BottomPicker({
    super.key,
    required this.pickerTitle,
    this.pickerDescription,
    required this.items,
    this.titleAlignment,
    this.titlePadding = const EdgeInsets.all(0),
    this.dismissable = true,
    this.onChange,
    this.onSubmit,
    this.onClose,
    this.bottomPickerTheme = BottomPickerTheme.blue,
    this.gradientColors,
    this.selectedItemIndex = 0,
    this.buttonPadding,
    this.buttonWidth,
    this.buttonSingleColor,
    this.backgroundColor = Colors.white,
    this.pickerTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.itemExtent = 35.0,
    this.displayCloseIcon = true,
    this.closeIconColor = Colors.white,
    this.closeIconSize = 20,
    this.layoutOrientation = TextDirection.ltr,
    this.buttonAlignment = MainAxisAlignment.center,
    this.height,
    this.displaySubmitButton = true,
    this.selectionOverlay,
    this.buttonContent,
    this.buttonStyle,
    this.selectedTextStyle,
  }) {
    dateOrder = null;
    onRangeDateSubmitPressed = null;
    bottomPickerType = BottomPickerType.simple;
    assert(items != null && items!.isNotEmpty);
    assert(selectedItemIndex >= 0);
    if (selectedItemIndex > 0) {
      assert(selectedItemIndex < items!.length);
    }
  }

  final Widget pickerTitle;
  final Widget? pickerDescription;
  final EdgeInsetsGeometry titlePadding;
  final Alignment? titleAlignment;
  final bool dismissable;
  late List<DateTime>? items;
  late Function(dynamic)? onChange;
  late Function(dynamic)? onSubmit;
  final Function? onClose;
  final BottomPickerTheme bottomPickerTheme;
  late int selectedItemIndex;
  DateTime? initialDateTime;
  Time? initialTime;
  Time? maxTime;
  Time? minTime;
  int? minuteInterval;
  DateTime? maxDateTime;
  DateTime? minDateTime;
  late bool use24hFormat;
  final double? buttonPadding;
  final double? buttonWidth;
  final Color backgroundColor;
  late DatePickerDateOrder? dateOrder;
  final TextStyle pickerTextStyle;
  final TextStyle? selectedTextStyle;
  late double itemExtent;
  final bool displayCloseIcon;
  final Color closeIconColor;
  final double closeIconSize;
  final TextDirection layoutOrientation;
  final MainAxisAlignment buttonAlignment;
  final double? height;
  late Function(DateTime, DateTime)? onRangeDateSubmitPressed;
  DateTime? minFirstDate;
  DateTime? minSecondDate;
  DateTime? maxFirstDate;
  DateTime? maxSecondDate;
  DateTime? initialFirstDate;
  DateTime? initialSecondDate;
  Widget? selectionOverlay;
  final Widget? buttonContent;
  late bool displaySubmitButton;
  final Color? buttonSingleColor;
  final List<Color>? gradientColors;
  final BoxDecoration? buttonStyle;
  Future<DateTime?> show(BuildContext context) {
    return showModalBottomSheet<DateTime>(
      context: context,
      isDismissible: dismissable,
      enableDrag: false,
      sheetAnimationStyle: AnimationStyle(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          reverseCurve: Curves.easeOut),
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: context.bottomPickerWidth,
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          onClosing: () {},
          builder: (context) {
            return FractionallySizedBox(heightFactor: 0.95, child: this);
          },
        );
      },
    );
  }

  @override
  BottomPickerState createState() => BottomPickerState();
}

class BottomPickerState extends State<BottomPicker>
    with TickerProviderStateMixin {
  //animation
  late AnimationController animationController;
  late Animation<double> animation;

  // This controller is responsible for the animation
  late AnimationController _animate;

  void startAnimation() {
    //if you want to call it again, e.g. after pushing and popping
    //a screen, you will need to reset to 0. Otherwise won't work.
    animationController.value = 0;
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    _animate.dispose();

    super.dispose();
  }

  late int selectedItemIndex;
  late DateTime selectedDateTime;
  late DateTime selectedFirstDateTime =
      widget.initialFirstDate ?? DateTime.now();
  late DateTime selectedSecondDateTime =
      widget.initialSecondDate ?? DateTime.now();
  @override
  void initState() {
    //animation controller - this sets the timing
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    //let's give the movement some style, not linear
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);

    startAnimation();
    _animate = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
        lowerBound: 1,
        upperBound: 1.2)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
    if (widget.bottomPickerType == BottomPickerType.simple) {
      selectedItemIndex = widget.selectedItemIndex;
    } else if (widget.bottomPickerType == BottomPickerType.time) {
      selectedDateTime = (widget.initialTime ?? Time.now()).toDateTime;
    } else {
      selectedDateTime = widget.initialDateTime ?? DateTime.now();
    }
    _selectedTextStyle = widget.selectedTextStyle;
  }

  List<int> slide = [60, 120, 150];
  bool exit = false;
  TextStyle? _selectedTextStyle;

  void _onBounce() {
    //Firing the animation right away
    _animate.forward();

    //Now reversing the animation after the user defined duration
    Future.delayed(const Duration(milliseconds: 400), () {
      _animate.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollStartNotification) {
          // _onStartScroll(scrollNotification.metrics);
          exit = false;
          return true;
        } else if (scrollNotification is ScrollUpdateNotification) {
          // _onUpdateScroll(scrollNotification.metrics);
          return true;
        } else if (scrollNotification is ScrollEndNotification) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (!exit) {
              exit = true;
              Future.delayed(const Duration(seconds: 2), () {
                print(widget.items![selectedItemIndex]);
                if (mounted) {
                  Navigator.of(context).pop(widget.items![selectedItemIndex]);
                }
              });
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  setState(() {
                    _onBounce();
                  });
                }
              });
            }
          });

          return true;
        }
        return false;
      },
      child: Container(
          clipBehavior: Clip.antiAlias,
          height: widget.height ?? context.bottomPickerHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.white,
                widget.backgroundColor,
                widget.backgroundColor,
                widget.backgroundColor
              ], // Gradient from https://learnui.design/tools/gradient-generator.html
              tileMode: TileMode.mirror,
            ),
            // color: widget.backgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomRight: Radius.elliptical(100, 150)),
                  child: Container(
                    // color: const Color.fromARGB(255, 37, 94, 227),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          // Colors.white,
                          Color.fromARGB(255, 130, 161, 232),
                          Color.fromARGB(255, 37, 94, 200),
                          Color.fromARGB(255, 37, 94, 227)
                        ], // Gradient from https://learnui.design/tools/gradient-generator.html
                        tileMode: TileMode.mirror,
                      ),
                    ),

                    width: MediaQuery.of(context).size.width - 20,
                    height: MediaQuery.of(context).size.height / 2 + 30,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 30,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.elliptical(100, 150)),
                    child: Container(
                      // color: const Color.fromARGB(255, 37, 94, 227),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            // Colors.white,
                            Color.fromARGB(255, 37, 94, 227),
                            Color.fromARGB(255, 37, 94, 227),
                            Color.fromARGB(255, 14, 78, 228)
                          ], // Gradient from https://learnui.design/tools/gradient-generator.html
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height / 2 + 70,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 80, 28, 28),
                  child: AnimatedTile(
                      chainCurve: const Interval(
                        0.3,
                        0.7,
                        curve: Curves.ease,
                      ),
                      slide: slide[1],
                      animation: animation,
                      child: widget.pickerTitle),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 40, top: 20),
                    child: AnimatedTile(
                      chainCurve: const Interval(
                        0.8,
                        1,
                        curve: Curves.ease,
                      ),
                      slide: slide[2],
                      animation: animation,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 20),
                            child: Directionality(
                              textDirection: widget.layoutOrientation,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: widget.titlePadding,
                                    child: const Row(
                                      children: [
                                        // Expanded(child: widget.pickerTitle),
                                        // if (widget.displayCloseIcon)
                                        //   CloseIcon(
                                        //     onPress: _closeBottomPicker,
                                        //     iconColor: widget.closeIconColor,
                                        //     closeIconSize: widget.closeIconSize,
                                        //   ),
                                      ],
                                    ),
                                  ),
                                  if (widget.pickerDescription != null)
                                    widget.pickerDescription!,
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: widget.bottomPickerType ==
                                      BottomPickerType.simple
                                  ? SimplePicker(
                                      scale: _animate.value,
                                      endEffect: exit,
                                      items: widget.items!
                                          .map(
                                            (e) =>
                                                "${DateFormat("HH:mm a").format(e)} - ${DateFormat("HH:mm a").format(e.add(const Duration(hours: 1)))}",
                                          )
                                          .toList(),
                                      onChange: (int index) {
                                        selectedItemIndex = index;
                                        setState(() {});
                                        print(index);
                                        widget.onChange?.call(index);
                                      },
                                      selectedItemIndex: selectedItemIndex,
                                      textStyle: widget.pickerTextStyle,
                                      selectedTextStyle: _selectedTextStyle,
                                      itemExtent: widget.itemExtent,
                                      selectionOverlay: widget.selectionOverlay,
                                    )
                                  : Container()),
                          if (widget.displaySubmitButton)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: widget.buttonAlignment,
                                children: [
                                  BottomPickerButton(
                                    onClick: () {
                                      if (widget.bottomPickerType ==
                                          BottomPickerType.rangeDateTime) {
                                        widget.onRangeDateSubmitPressed?.call(
                                          selectedFirstDateTime,
                                          selectedSecondDateTime,
                                        );
                                      } else if (widget.bottomPickerType ==
                                              BottomPickerType.dateTime ||
                                          widget.bottomPickerType ==
                                              BottomPickerType.time) {
                                        widget.onSubmit?.call(selectedDateTime);
                                      } else {
                                        widget.onSubmit
                                            ?.call(selectedItemIndex);
                                      }
                                      Navigator.pop(context);
                                    },
                                    gradientColors: widget.gradientColor,
                                    buttonPadding: widget.buttonPadding,
                                    buttonWidth: widget.buttonWidth,
                                    solidColor: widget.buttonSingleColor,
                                    buttonChild: widget.buttonContent,
                                    style: widget.buttonStyle,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )),
                const Align(
                  alignment: Alignment(0.93, 0.05),
                  child: Icon(
                    size: 25,
                    Icons.timer,
                  ),
                ),
                if (widget.displayCloseIcon)
                  AnimatedTile(
                    chainCurve: const Interval(
                      0.0,
                      0.5,
                      curve: Curves.ease,
                    ),
                    slide: slide[0],
                    animation: animation,
                    child: Align(
                      alignment: const Alignment(-0.87, -0.92),
                      child: CloseIcon(
                        onPress: _closeBottomPicker,
                        iconColor: widget.closeIconColor,
                        closeIconSize: widget.closeIconSize,
                      ),
                    ),
                  ),
              ],
            ),
          )),
    );
  }

  void _closeBottomPicker() {
    if (widget.onClose == null) {
      Navigator.pop(context);
    } else {
      widget.onClose?.call();
    }
  }
}
