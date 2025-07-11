import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prakira/models/constant.dart';
import 'package:prakira/models/city.dart';

class Home extends StatefulWidget {
  final List<City> selectedCities;

  const Home({super.key, required this.selectedCities});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Constant myConstant = Constant();
  final String _apiKey = ' '; // change with your own API key

  // Variabel state untuk menyimpan data dari API
  bool _isLoading = true;
  String _location = '';
  double _temp = 0.0;
  double _maxTemp = 0.0;
  String _weatherStateName = 'Loading...';
  int _humidity = 0;
  double _windSpeed = 0.0;
  String _currentDate = 'Loading...';
  String _imageUrl = '';
  List<dynamic> _forecastList = [];

  // Create a shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    super.initState();
    if (widget.selectedCities.isNotEmpty) {
      // Set lokasi awal dari kota pertama yang dipilih
      _location = widget.selectedCities.first.name;
      // Panggil API untuk lokasi awal
      _fetchAllWeatherData(_location);
    } else {
      // Fallback jika tidak ada kota (seharusnya tidak terjadi)
      setState(() {
        _isLoading = false;
        _weatherStateName = 'No city selected';
      });
    }
  }

  // Fungsi gabungan untuk mengambil cuaca saat ini dan prakiraan
  void _fetchAllWeatherData(String location) {
    fetchCurrentWeather(location);
    fetchForecast(location);
  }

  void fetchCurrentWeather(String location) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$_apiKey&units=metric',
      );
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        setState(() {
          _location = result['name'];
          _temp = result['main']['temp'];
          _maxTemp = result['main']['temp_max'];
          _weatherStateName = result['weather'][0]['main'];
          _humidity = result['main']['humidity'];
          _windSpeed = result['wind']['speed'];
          final now = DateTime.now();
          _currentDate = DateFormat('EEEE, d MMMM y').format(now);
          _imageUrl = _weatherStateName.replaceAll(' ', '').toLowerCase();
        });
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle error
    }
  }

  void fetchForecast(String location) async {
    try {
      var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$_apiKey&units=metric',
      );
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        // Filter untuk mendapatkan satu prakiraan per hari (sekitar tengah hari)
        final List<dynamic> dailyForecasts =
            result['list']
                .where((item) => item['dt_txt'].toString().contains('12:00:00'))
                .toList();
        setState(() {
          _forecastList = dailyForecasts;
          _isLoading = false; // Loading selesai setelah kedua API berhasil
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  // Helper widget untuk item cuaca (Wind, Humidity, Max Temp)
  Widget weatherItem({
    required String text,
    required int value,
    required String unit,
    required String imageUrl,
  }) {
    return Column(
      children: [
        Text(text, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 8),
        Image.asset(imageUrl, width: 30, height: 30),
        const SizedBox(height: 8),
        Text(
          value.toStringAsFixed(1) + unit,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Decoration decoration = myConstant.menuPageBgDecoration;
    return Scaffold(
      // backgroundColor: Decorations.menuPageBgDecoration.color,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        // backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/weather-icons/profile.png',
                  width: 40,
                  height: 40,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/weather-icons/pin.png', width: 20),
                  const SizedBox(width: 4),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _location,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items:
                          widget.selectedCities.map((City city) {
                            return DropdownMenuItem(
                              value: city.name,
                              child: Text(city.name),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _location = newValue;
                            _fetchAllWeatherData(_location);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                // decoration: decoration,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _location,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    Text(
                      _currentDate,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      width: size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        color: myConstant.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: myConstant.primaryColor.withOpacity(.5),
                            offset: const Offset(0, 25),
                            blurRadius: 10,
                            spreadRadius: -12,
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -40,
                            left: 20,
                            child:
                                _imageUrl.isEmpty
                                    ? const SizedBox()
                                    : Image.asset(
                                      'assets/weather-icons/$_imageUrl.png',
                                      width: 150,
                                    ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 20,
                            child: Text(
                              _weatherStateName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    _temp.toStringAsFixed(0),
                                    style: TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      foreground:
                                          Paint()..shader = linearGradient,
                                    ),
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground:
                                        Paint()..shader = linearGradient,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          weatherItem(
                            text: 'Wind Speed',
                            value: _windSpeed.toInt(),
                            unit: ' Kmh',
                            imageUrl: 'assets/weather-icons/windspeed.png',
                          ),
                          weatherItem(
                            text: 'Humidity',
                            value: _humidity.toInt(),
                            unit: '%',
                            imageUrl: 'assets/weather-icons/humidity.png',
                          ),
                          weatherItem(
                            text: 'Max Temp',
                            value: _maxTemp.toInt(),
                            unit: '°C',
                            imageUrl: 'assets/weather-icons/max-temp.png',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Forecast',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _forecastList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var forecastItem = _forecastList[index];
                          String weatherName =
                              forecastItem['weather'][0]['main'];
                          String weatherUrl =
                              weatherName.replaceAll(' ', '').toLowerCase();
                          var parsedDate = DateTime.parse(
                            forecastItem['dt_txt'],
                          );
                          var dayOfWeek = DateFormat(
                            'EEE',
                          ).format(parsedDate); // 'Mon', 'Tue'
                          double temp = forecastItem['main']['temp'];

                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            margin: const EdgeInsets.only(
                              right: 20,
                              bottom: 10,
                              top: 10,
                            ),
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 1),
                                  blurRadius: 5,
                                  color: myConstant.primaryColor.withOpacity(
                                    .2,
                                  ),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${temp.toStringAsFixed(0)}°C',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: myConstant.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Image.asset(
                                  'assets/weather-icons/$weatherUrl.png',
                                  width: 40,
                                ),
                                Text(
                                  dayOfWeek,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: myConstant.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
