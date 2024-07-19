// ignore_for_file: avoid_print

import 'package:airline_tag_ui/scrollwheel/bottom_picker.dart';
import 'package:airline_tag_ui/scrollwheel/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airplane Tag',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Scaffold(
        body: ExampleApp(),
      ),
    );
  }
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

List<DateTime> getHoursInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inHours; i++) {
    days.add(startDate.add(Duration(hours: i)));
  }
  return days;
}

class _ExampleAppState extends State<ExampleApp> {
  final countryList = [
    'Algeria 🇩🇿',
    'Maroco 🇲🇦',
    'Tunisia 🇹🇳',
    'Palestine 🇵🇸',
    'Egypt 🇪🇬',
    'Syria 🇸🇾',
    'Irak 🇮🇶',
    'Mauritania 🇲🇷',
    'Algeria 🇩🇿',
    'Maroco 🇲🇦',
    'Tunisia 🇹🇳',
    'Palestine 🇵🇸',
    'Egypt 🇪🇬',
    'Syria 🇸🇾',
    'Irak 🇮🇶',
    'Mauritania 🇲🇷',
    'Algeria 🇩🇿',
    'Maroco 🇲🇦',
    'Tunisia 🇹🇳',
    'Palestine 🇵🇸',
    'Egypt 🇪🇬',
    'Syria 🇸🇾',
    'Irak 🇮🇶',
    'Mauritania 🇲🇷',
    'Algeria 🇩🇿',
    'Maroco 🇲🇦',
    'Tunisia 🇹🇳',
    'Palestine 🇵🇸',
    'Egypt 🇪🇬',
    'Syria 🇸🇾',
    'Irak 🇮🇶',
    'Mauritania 🇲🇷',
    'Algeria 🇩🇿',
    'Maroco 🇲🇦',
    'Tunisia 🇹🇳',
    'Palestine 🇵🇸',
    'Egypt 🇪🇬',
    'Syria 🇸🇾',
    'Irak 🇮🇶',
    'Mauritania 🇲🇷',
    'Algeria 🇩🇿',
    'Maroco 🇲🇦',
    'Tunisia 🇹🇳',
    'Maroco 🇲🇦',
    'Tunisia 🇹🇳',
    'Palestine 🇵🇸',
    'Egypt 🇪🇬',
    'Syria 🇸🇾',
    'Irak 🇮🇶',
    'Mauritania 🇲🇷',
    'Algeria 🇩🇿',
    'Maroco 🇲🇦',
    'Tunisia 🇹🇳',
  ];

  final buttonWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF6F2F2),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://github.com/koukibadr/Bottom-Picker/blob/main/example/bottom_picker_logo.gif?raw=true',
            width: 200,
          ),
          SizedBox(
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: () {
                _openSimpleItemPicker(
                    context,
                    getHoursInBetween(
                            DateTime.now().subtract(const Duration(days: 3)),
                            DateTime.now().add(const Duration(days: 3)))
                        .map(
                          (e) =>
                              "${DateFormat("HH:mm a").format(e)} - ${DateFormat("HH:mm a").format(e.add(const Duration(hours: 1)))}",
                        )
                        .toList());
              },
              child: const Text('Simple Item picker'),
            ),
          ),
        ],
      ),
    );
  }

  int index = 5;

  void _openSimpleItemPicker(BuildContext context, List<String> items) {
    BottomPicker(
      itemExtent: 100,
      selectedItemIndex: index,
      items: items,
      layoutOrientation: TextDirection.rtl,
      closeIconSize: 30,
      selectedTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 107, 237, 251)),
      pickerTextStyle: const TextStyle(
          fontSize: 12, color: Colors.white, fontWeight: FontWeight.w900),
      pickerTitle: const Text(
        'Schedule',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
      ),
      onChange: (p0) {
        print(p0);
        setState(() {
          index = p0;
        });
      },
      // backgroundColor: const Color.fromARGB(255, 29, 75, 186),
      backgroundColor: const Color.fromARGB(255, 107, 237, 251),
      bottomPickerTheme: BottomPickerTheme.morningSalad,
      onSubmit: (index) {
        print(index);
      },
      buttonAlignment: MainAxisAlignment.end,
      displaySubmitButton: false,
      height: MediaQuery.of(context).size.height,
    ).show(context);
  }
}
