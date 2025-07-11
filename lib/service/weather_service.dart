import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class WeatherService {
  static const String _apiKey = '1303dcfbb0d1300f95ba7c6c11dbb586';
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  // Mengambil data cuaca berdasarkan nama kota
  Future<Map<String, dynamic>> getWeatherByCity(String city) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat data cuaca untuk kota $city');
    }
  }

  // Mengambil data cuaca berdasarkan koordinat (latitude, longitude)
  Future<Map<String, dynamic>> getWeatherByCoordinates(
    double lat,
    double lon,
  ) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat data cuaca untuk koordinat');
    }
  }

  Future<void> requestLocationPermission() async {
    // Meminta izin lokasi
    var status = await Permission.location.request();

    if (status.isGranted) {
      // Izin diberikan, lanjutkan ke logika berikutnya
      print("Izin lokasi diberikan.");
    } else if (status.isDenied) {
      // Izin ditolak oleh pengguna
      print("Izin lokasi ditolak.");
    } else if (status.isPermanentlyDenied) {
      // Izin ditolak permanen, arahkan pengguna ke pengaturan
      openAppSettings();
    }
  }

  // Mendapatkan lokasi pengguna saat ini
  Future<Position> getCurrentLocation() async {
    // Memeriksa dan meminta izin lokasi
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else if (status.isPermanentlyDenied) {
      throw Exception(
        'Izin lokasi ditolak secara permanen. Silakan aktifkan di pengaturan.',
      );
    } else {
      throw Exception('Izin lokasi ditolak.');
    }
  }
}
