import 'package:airline_tag_ui/scrollwheel/resources/arrays.dart';
import 'package:airline_tag_ui/scrollwheel/resources/time.dart';
import 'package:airline_tag_ui/scrollwheel/widgets/bottom_picker_button.dart';
import 'package:airline_tag_ui/scrollwheel/widgets/close_icon.dart';
import 'package:airline_tag_ui/scrollwheel/widgets/simple_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airline_tag_ui/scrollwheel/resources/extensions.dart';
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
  BottomPicker.date({
    super.key,
    required this.pickerTitle,
    this.pickerDescription,
    this.titlePadding = const EdgeInsets.all(0),
    this.titleAlignment,
    this.dismissable = true,
    this.onChange,
    this.onSubmit,
    this.onClose,
    this.bottomPickerTheme = BottomPickerTheme.blue,
    this.gradientColors,
    this.initialDateTime,
    this.minDateTime,
    this.maxDateTime,
    this.buttonPadding,
    this.buttonWidth,
    this.buttonSingleColor,
    this.backgroundColor = Colors.white,
    this.dateOrder = DatePickerDateOrder.ymd,
    this.pickerTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.displayCloseIcon = true,
    this.closeIconColor = Colors.white,
    this.closeIconSize = 20,
    this.layoutOrientation = TextDirection.ltr,
    this.buttonAlignment = MainAxisAlignment.center,
    this.height,
    this.displaySubmitButton = true,
    this.buttonContent,
    this.buttonStyle,
    this.selectedTextStyle,
  }) {
    datePickerMode = CupertinoDatePickerMode.date;
    bottomPickerType = BottomPickerType.dateTime;
    use24hFormat = false;
    itemExtent = 0;
    onRangeDateSubmitPressed = null;
    assertInitialValues();
  }
  BottomPicker.dateTime({
    super.key,
    required this.pickerTitle,
    this.pickerDescription,
    this.titlePadding = const EdgeInsets.all(0),
    this.titleAlignment,
    this.dismissable = true,
    this.onChange,
    this.onSubmit,
    this.onClose,
    this.bottomPickerTheme = BottomPickerTheme.blue,
    this.gradientColors,
    this.initialDateTime,
    this.minuteInterval,
    this.minDateTime,
    this.maxDateTime,
    this.use24hFormat = false,
    this.buttonPadding,
    this.buttonWidth,
    this.buttonSingleColor,
    this.backgroundColor = Colors.white,
    this.dateOrder = DatePickerDateOrder.ymd,
    this.pickerTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.displayCloseIcon = true,
    this.closeIconColor = Colors.white,
    this.closeIconSize = 20,
    this.layoutOrientation = TextDirection.ltr,
    this.buttonAlignment = MainAxisAlignment.center,
    this.height,
    this.displaySubmitButton = true,
    this.buttonContent,
    this.buttonStyle,
    this.selectedTextStyle,
  }) {
    datePickerMode = CupertinoDatePickerMode.dateAndTime;
    bottomPickerType = BottomPickerType.dateTime;
    itemExtent = 0;
    onRangeDateSubmitPressed = null;
    assertInitialValues();
  }
  BottomPicker.time({
    super.key,
    required this.pickerTitle,
    this.pickerDescription,
    required this.initialTime,
    this.maxTime,
    this.minTime,
    this.titlePadding = const EdgeInsets.all(0),
    this.titleAlignment,
    this.dismissable = true,
    this.onChange,
    this.onSubmit,
    this.onClose,
    this.bottomPickerTheme = BottomPickerTheme.blue,
    this.gradientColors,
    this.minuteInterval = 1,
    this.use24hFormat = false,
    this.buttonPadding,
    this.buttonWidth,
    this.buttonSingleColor,
    this.backgroundColor = Colors.white,
    this.pickerTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.displayCloseIcon = true,
    this.closeIconColor = Colors.white,
    this.closeIconSize = 20,
    this.layoutOrientation = TextDirection.ltr,
    this.buttonAlignment = MainAxisAlignment.center,
    this.height,
    this.displaySubmitButton = true,
    this.buttonContent,
    this.buttonStyle,
    this.selectedTextStyle,
  }) {
    datePickerMode = CupertinoDatePickerMode.time;
    bottomPickerType = BottomPickerType.time;
    dateOrder = null;
    itemExtent = 0;
    onRangeDateSubmitPressed = null;
    initialDateTime = null;
    assertInitialValues();
  }
  BottomPicker.range({
    super.key,
    required this.pickerTitle,
    this.pickerDescription,
    required this.onRangeDateSubmitPressed,
    this.titlePadding = const EdgeInsets.all(0),
    this.titleAlignment,
    this.dismissable = true,
    this.onClose,
    this.bottomPickerTheme = BottomPickerTheme.blue,
    this.gradientColors,
    this.buttonPadding,
    this.buttonWidth,
    this.buttonSingleColor,
    this.backgroundColor = Colors.white,
    this.pickerTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.displayCloseIcon = true,
    this.closeIconColor = Colors.white,
    this.closeIconSize = 20,
    this.layoutOrientation = TextDirection.ltr,
    this.buttonAlignment = MainAxisAlignment.center,
    this.height,
    this.initialSecondDate,
    this.initialFirstDate,
    this.minFirstDate,
    this.minSecondDate,
    this.maxFirstDate,
    this.maxSecondDate,
    this.dateOrder = DatePickerDateOrder.ymd,
    this.buttonContent,
    this.buttonStyle,
    this.selectedTextStyle,
  }) {
    datePickerMode = CupertinoDatePickerMode.date;
    bottomPickerType = BottomPickerType.rangeDateTime;
    dateOrder = null;
    itemExtent = 0;
    onChange = null;
    onSubmit = null;
    displaySubmitButton = true;
    assert(onRangeDateSubmitPressed != null);
    assertInitialValues();
    if (minSecondDate != null && initialSecondDate != null) {
      assert(initialSecondDate!.isAfter(minSecondDate!));
    }
    if (minFirstDate != null && initialFirstDate != null) {
      assert(initialFirstDate!.isAfter(minFirstDate!));
    }
  }
  final Widget pickerTitle;
  final Widget? pickerDescription;
  final EdgeInsetsGeometry titlePadding;
  final Alignment? titleAlignment;
  final bool dismissable;
  late List<String>? items;
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
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: dismissable,
      enableDrag: true,
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

class BottomPickerState extends State<BottomPicker> {
  late int selectedItemIndex;
  late DateTime selectedDateTime;
  late DateTime selectedFirstDateTime =
      widget.initialFirstDate ?? DateTime.now();
  late DateTime selectedSecondDateTime =
      widget.initialSecondDate ?? DateTime.now();
  @override
  void initState() {
    super.initState();
    if (widget.bottomPickerType == BottomPickerType.simple) {
      selectedItemIndex = widget.selectedItemIndex;
    } else if (widget.bottomPickerType == BottomPickerType.time) {
      selectedDateTime = (widget.initialTime ?? Time.now()).toDateTime;
    } else {
      selectedDateTime = widget.initialDateTime ?? DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: widget.height ?? context.bottomPickerHeight,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
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
                color: const Color.fromARGB(255, 37, 94, 227),
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
                  color: const Color.fromARGB(255, 37, 94, 227),
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height / 2 + 70,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 80, 28, 28),
              child: widget.pickerTitle,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, top: 20),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 20),
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
                      child: widget.bottomPickerType == BottomPickerType.simple
                          ? SimplePicker(
                              items: widget.items!,
                              onChange: (int index) {
                                selectedItemIndex = index;
                                setState(() {});
                                print(index);
                                widget.onChange?.call(index);
                              },
                              selectedItemIndex: selectedItemIndex,
                              textStyle: widget.pickerTextStyle,
                              selectedTextStyle: widget.selectedTextStyle,
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
                                widget.onSubmit?.call(selectedItemIndex);
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
            ),
            const Align(
              alignment: Alignment(0.93, 0.05),
              child: Icon(
                size: 25,
                Icons.timer,
              ),
            ),
            if (widget.displayCloseIcon)
              Align(
                alignment: const Alignment(-0.87, -0.92),
                child: CloseIcon(
                  onPress: _closeBottomPicker,
                  iconColor: widget.closeIconColor,
                  closeIconSize: widget.closeIconSize,
                ),
              ),
          ],
        ),
      ),
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
