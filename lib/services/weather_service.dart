import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '2b0f6e1b73abad3b243bd5406b562e0e';  // Replace with your actual API key

  Future<String> getTemperature(double lat, double lon) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      double temp = data['main']['temp'];
      return temp.toStringAsFixed(1);  // Returns the temperature as a string with 1 decimal
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
