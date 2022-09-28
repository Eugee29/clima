import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'da0a5d0486ae4899dfdcd88c1cb034e2';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    try {
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?q=$cityName&units=metric&appid=$apiKey');
      return await networkHelper.getData();
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    try {
      await location.getCurrentLocation();
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');

      return await networkHelper.getData();
    } catch (e) {
      return null;
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
