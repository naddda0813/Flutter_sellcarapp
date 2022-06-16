import 'dart:convert';
import "package:charts_flutter/flutter.dart" as charts;
import 'package:flutter/material.dart';
import 'package:sell_car_app/chart_deveoloper.dart';
import 'package:sell_car_app/chart_series.dart';
import 'package:sell_car_app/static.dart';
import 'package:http/http.dart' as http;

class Chart extends StatefulWidget {
  final int inputAge;
  final dynamic inputMileage;
  final dynamic inputMpg;
  final dynamic inputEngineSize;
  final String inputFueltype;
  final String inputTransmission;

  const Chart({
    Key? key,
    required this.inputAge,
    required this.inputMileage,
    required this.inputMpg,
    required this.inputEngineSize,
    required this.inputFueltype,
    required this.inputTransmission,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final dynamic price = 1000; // 임시로 만든 것임
  final String model = Static.model; // 모델명
  final _valueList = ['Age', 'FuelType', 'Transmission']; // DropDownButton List
  String _selectedValue = 'Age'; // DrowDown 선택값
  final List jsonData = []; // db jsondata 리스트
  String jspUrl = ""; // db 가져오는 jsp url 주소
  final List<DeveloperSeries> data = []; // 차트 그릴 때 쓰는 data 리스트

  @override
  void initState() {
    super.initState();

    // 차트 그리는 data 리스트 채우기
    data.add(
      DeveloperSeries(
        feature: widget.inputAge,
        target: price,
        chartColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
    );

    data.add(
      DeveloperSeries(
        feature: widget.inputAge + 5,
        target: price,
        chartColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
    );

    data.add(
      DeveloperSeries(
        feature: widget.inputAge + 10,
        target: price,
        chartColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
    );
  }

// 화면 그림
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 4, 31, 56),
          title: Image.asset(
            "images/sellcar.png",
            width: 180,
          )),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),

            // Dropdown Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("CHOOSE CHART : "),
                const SizedBox(
                  width: 30,
                ),
                DropdownButton(
                  value: _selectedValue,
                  items: _valueList.map(
                    (value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value as String;

                      getJsonData(_selectedValue);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // Chart
            jsonData.isEmpty
                ? const Text("NO DATA")
                : DeveloperChart(data: data),
          ],
        ),
      ),
    );
  }

// Functions
  Future<bool> getJsonData(String selectedValue) async {
    if (selectedValue == 'Age') {
      jspUrl = 'http://localhost:8080/Flutter/query_age_price.jsp?model=$model';
    } else if (selectedValue == 'Transmission') {
      jspUrl = 'http://localhost:8080/Flutter/query_transmission_price.jsp?model=$model';
    } else if (selectedValue == 'FuelType') {
      jspUrl = 'http://localhost:8080/Flutter/query_fueltype_price.jsp?model=$model';
    }
    var url = Uri.parse(jspUrl);
    var response = await http.get(url);

    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      // - 키 값 이용해서 안쪽 데이터에 접근
      List result = dataConvertedJSON['results'];
      jsonData.addAll(result);
    });
    return true;
  }
} // End
