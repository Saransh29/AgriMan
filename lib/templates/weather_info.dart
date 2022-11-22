import '../theme.dart';
import 'data_service.dart';
import 'package:flutter/material.dart';

import 'weather_model.dart';

class weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _weatherState();
}

class _weatherState extends State<weather> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: primColors.back,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_response != null)
                  Column(
                    children: [
                      Image.network(_response!.iconUrl),
                      Text(
                        '${_response!.tempInfo!.temperature}°',
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(_response!.weatherInfo!.description)
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    width: 150,
                    child: TextField(
                        controller: _cityTextController,
                        decoration: InputDecoration(labelText: 'City'),
                        textAlign: TextAlign.center),
                  ),
                ),
                ElevatedButton(onPressed: _search, child: Text('Search'))
              ],
            ),
          ),
        ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}

/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/weather_info.dart';
import '../utils/constants.dart';

Future<WeatherInfo> getWeather(String city) async {
  final queryParameters = {'q': city, 'appid': api_key};
  final uri = Uri.https(w_link, '/data/2.5/weather', queryParameters);
  late WeatherInfo info;
  await get(uri).then((value) => info = WeatherInfo(jsonDecode(value.body)));

  return info;
}

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherInfo? wInfo;
  String s = "";
  Widget? w;

  void handleWeatherTap() {
    getWeather("Delhi").then((value) => wInfo = value).then((v) {
      setState(() {
        s = wInfo.toString();
        w = wInfo!.toWidget();
      });
    });
  }

  @override
  void initState() {
    handleWeatherTap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather')),
      body: Column(
        children: [
          TextButton.icon(
            onPressed: handleWeatherTap,
            icon: Icon(Icons.wb_sunny),
            label: Text('getWeather'),
          ),
          Text(s),
          widget ?? Container(),
        ],
      ),
    );
  }
}
*/
