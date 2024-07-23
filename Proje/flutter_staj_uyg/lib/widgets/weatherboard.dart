import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WeatherBoard extends StatefulWidget {
  final String apiKey;
  final String city;

  WeatherBoard({required this.apiKey, required this.city});

  @override
  _WeatherBoardState createState() => _WeatherBoardState();
}

class _WeatherBoardState extends State<WeatherBoard> {
  Map<String, dynamic> weatherData = {};
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final url = 'http://api.openweathermap.org/data/2.5/weather?q=${widget.city}&appid=${widget.apiKey}&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Hava durumu bilgileri yüklenirken bir hata oluştu.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final dayFormat = DateFormat('EEEE', 'tr_TR');
    final timeFormat = DateFormat('HH:mm');

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(8, 31, 47, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.white)))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hava Durumu', style: TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 18)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weatherData['main'] != null && weatherData['main']['temp'] != null
                                  ? '${weatherData['main']['temp'].round()}°C'
                                  : 'N/A',
                              style: TextStyle(color: Color.fromARGB(255, 231, 244, 255), fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              weatherData['main'] != null
                                  ? 'Nem: ${weatherData['main']['humidity'] ?? 'N/A'}%'
                                  : 'Nem: N/A',
                              style: TextStyle(color: Color.fromARGB(255, 231, 244, 255)),
                            ),
                            Text(
                              weatherData['rain'] != null && weatherData['rain']['1h'] != null
                                  ? 'Yağış: ${weatherData['rain']['1h']}mm'
                                  : 'Yağış: 0mm',
                              style: TextStyle(color: Color.fromARGB(255, 231, 244, 255)),
                            ),
                            Text(
                              weatherData['wind'] != null && weatherData['wind']['speed'] != null
                                  ? 'Rüzgar: ${weatherData['wind']['speed']}m/s'
                                  : 'Rüzgar: N/A',
                              style: TextStyle(color: Color.fromARGB(255, 231, 244, 255)),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              dayFormat.format(DateTime.now()),
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              timeFormat.format(DateTime.now()),
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(height: 4),
                            Text(
                              weatherData['weather'] != null && weatherData['weather'].isNotEmpty
                                  ? weatherData['weather'][0]['main'] ?? 'N/A'
                                  : 'N/A',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}