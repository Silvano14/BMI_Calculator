import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globo_fitness/shared/menu_drawer.dart';

import '../shared/menu_button.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  TextEditingController txtHeight = TextEditingController();
  TextEditingController txtWeight = TextEditingController();
  String heightMessage = "";
  String weightMessage = "";
  final double fontSize = 18;
  String result = "";
  bool isMetric = true;
  bool isImperial = false;
  double? height;
  double? weight;
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage =
        "Please insert your height in ${isMetric ? "meters" : "inches"} exa: 1.70";
    weightMessage =
        "Please insert your weight in ${isMetric ? "kilos" : "pounds"}";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bmi calculator"),
      ),
      bottomNavigationBar: const MenuButton(),
      body: SingleChildScrollView(child:
        Column(children: [
          ToggleButtons(
            isSelected: isSelected,
            onPressed: toggleMeasure,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'isMetric',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'isImperial',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: txtHeight,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: fontSize),
              decoration: InputDecoration(hintText: heightMessage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: txtWeight,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: fontSize),
              decoration: InputDecoration(hintText: weightMessage),
            ),
          ),
          ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Calculate BMI",
                  style: TextStyle(fontSize: fontSize))),
          Text(
            result,
            style: TextStyle(fontSize: fontSize),
          )
        ]),
      ),
      drawer: const MenuDrawer(),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else if (value == 1) {
      isMetric = false;
      isImperial = true;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }

  void calculateBMI() {
    double bmi = 0;
    double weight = double.tryParse(txtWeight.text) ?? 0;
    double height = double.tryParse(txtHeight.text) ?? 0;

    if (isMetric) {
      bmi = weight / (height * height);
    } else {
      bmi = weight * 703 / (height * height);
    }

    setState(() {
      result = "Your BMI is ${bmi.toStringAsFixed(2)}";
    });
  }
}
