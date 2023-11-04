// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

// ignore: camel_case_types
class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

DateTime now = DateTime.now();
DateTime date1 = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
DateTime date2 = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

Map<FlSpot, dynamic> data = {};

TextEditingController date1_controler = TextEditingController();
TextEditingController date2_controler = TextEditingController();
bool isDate1 = false;

List<String> type = ['Daily', 'Weekly and Monthly '];
String dropdownvalue = 'Daily';

// ignore: camel_case_types
class _home_screenState extends State<home_screen> {
  Future<void> Get_data() async {
    data.clear();
    final firestore = FirebaseFirestore.instance;

    final collectionReference = firestore
        .collection("Products Sold")
        .where('DateTime', isGreaterThanOrEqualTo: date1)
        .where('DateTime', isLessThanOrEqualTo: date2);

    QuerySnapshot querySnapshot = await collectionReference.get();

    // ignore: avoid_function_literals_in_foreach_calls
    querySnapshot.docs.forEach((doc) {
      String name = doc.get("name").toString();
      double Price = double.parse(doc.get("Price").toString());
      double QTY = double.parse(doc.get("QTY").toString());
      DateTime date = DateTime.parse(doc.get("DateTime").toDate().toString());

      FlSpot Spot = FlSpot(Price, QTY);
      final info = {
        'name': name,
        "Price": Price,
        DateTime: date,
        "QTY": QTY,
      };

      setState(() {
        data.addAll({Spot: info});
      });
    });
  }

  void initState() {
    Get_data();
    super.initState();
  }

  Widget build(BuildContext context) {
    Future<void> datepicker() async {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
      ).then((value) {
        setState(() {
          if (value == null) {
            return;
          }
          if (isDate1) {
            String formattedDate =
                value.toString().substring(0, 10) + " 00:00:00.000";

            date1 = DateTime.parse(formattedDate);
            date1_controler.text = value.toString().substring(0, 10);
            isDate1 = false;
            return;
          }
          if (value.isBefore(DateTime.parse(date1_controler.text))) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Date 2 must be after Date 1"),
            ));
            return;
          }
          if (!isDate1) {
            String formattedDate =
                value.toString().substring(0, 10) + " 23:59:59.999";

            date2 = DateTime.parse(formattedDate);
            date2_controler.text = value.toString().substring(0, 10);
          }
        });
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Statistics"),
        ),
        body: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("statistics By"),
                    const SizedBox(
                      width: 50,
                    ),
                    DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: type.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          if (newValue == "Daily") {
                            now = DateTime.now();
                            date1 =
                                DateTime(now.year, now.month, now.day, 0, 0, 0);
                            date2 = DateTime(
                                now.year, now.month, now.day, 23, 59, 59, 999);
                            Get_data();
                          }

                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                Visibility(
                  visible: dropdownvalue == "Daily" ? false : true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: 150,
                        child: TextField(
                          controller: date1_controler,
                          onTap: () {
                            isDate1 = true;
                            datepicker();
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                            counterText: '',
                            contentPadding: const EdgeInsets.only(
                                top: 29, left: 85, right: 0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade200, width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      const Text("To"),
                      SizedBox(
                        height: 45,
                        width: 150,
                        child: TextField(
                          controller: date2_controler,
                          onTap: () {
                            datepicker();
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                            counterText: '',
                            contentPadding: const EdgeInsets.only(
                                top: 29, left: 85, right: 0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade200, width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {});
                            Get_data();
                          },
                          child: Text("Apply"))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  width: 400,
                  height: 250,
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(
                            show: true,
                            leftTitles: AxisTitles(
                                axisNameSize: 44,
                                axisNameWidget: Text("QTY"),
                                sideTitles: SideTitles(showTitles: true)),
                            bottomTitles: AxisTitles(
                                axisNameSize: 44,
                                axisNameWidget: Text("Price"),
                                sideTitles: SideTitles(showTitles: true))),
                        borderData: FlBorderData(
                          show: true,
                        ),
                        minX: 1000,
                        maxX: 4000,
                        minY: 1,
                        maxY: 30,
                        lineBarsData: [
                          LineChartBarData(
                            shadow: Shadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(5, 5),
                            ),
                            spots: data.keys.toList(),
                            isCurved: true,
                            color: Colors.blue,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withOpacity(0.15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
