import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app1/constants/api_cons.dart';
import 'package:weather_app1/models/weather_model.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherModel;
  Future<WeatherModel?> fetchData() async {
    final dio = Dio();
    final response = await dio.get(ApiCons.api);
    if (response.statusCode == 200 || response.statusCode == 201) {
      weatherModel = WeatherModel(
        id: response.data['weather'][0]['id'],
        main: response.data['weather'][0]['main'],
        description: response.data['weather'][0]['description'],
        icon: response.data['weather'][0]['icon'],
        // temp: response.data['main'][0]['temp'],
        // country: response.data['sys']['country'],
        // city: response.data['name'],
      );
      return weatherModel;
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: weatherModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
              children: [
                Text(weatherModel!.id.toString()),
                Text(weatherModel!.main),
                Text(weatherModel!.icon),
                Text(weatherModel!.description),
                // Text(weatherModel!.city),
                // Text(weatherModel!.country),
              ],
            )),
    );
  }
}