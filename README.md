# 🌦️ Prakira Weather

**Prakira** adalah aplikasi cuaca mobile yang modern dan bersih, dibangun menggunakan Flutter. Aplikasi ini memungkinkan pengguna untuk melihat kondisi cuaca terkini dan prakiraan cuaca untuk berbagai kota di Indonesia, dengan data yang diambil langsung dari OpenWeatherMap API.

## ✨ Fitur Utama

- 🚀 **Halaman Pembuka**: Halaman "Get Started" yang menarik dan hanya muncul sekali saat aplikasi pertama kali dijalankan.
- 🌍 **Pemilihan Lokasi Dinamis**: Pengguna dapat memilih beberapa kota dari daftar yang tersedia untuk dipantau cuacanya.
- 🌤️ **Data Cuaca Real-time**: Menampilkan kondisi cuaca terkini, termasuk suhu, kelembapan, kecepatan angin, dan suhu maksimal untuk kota yang dipilih.
- 📅 **Prakiraan Cuaca 5 Hari**: Menyajikan prakiraan cuaca untuk 5 hari ke depan dalam tampilan horizontal yang mudah digulir.
- 👆 **Dropdown Pemilih Kota**: Mudah beralih antar kota yang telah dipilih langsung dari halaman utama untuk melihat detail cuaca.
- 🎨 **Antarmuka Modern**: Desain UI yang menarik dengan efek *glassmorphism* pada halaman pemilihan kota dan ikonografi yang jelas untuk setiap kondisi cuaca.

## 🛠️ Teknologi yang Digunakan

- [Flutter](https://flutter.dev/) - Framework UI untuk membangun aplikasi dari satu basis kode.
- [Dart](https://dart.dev/) - Bahasa pemrograman yang digunakan untuk Flutter.
- [OpenWeatherMap API](https://openweathermap.org/api) - Sebagai sumber utama data cuaca dan prakiraan.
- [shared_preferences](https://pub.dev/packages/shared_preferences) - Untuk menyimpan status halaman pembuka (agar hanya muncul sekali).
- [http](https://pub.dev/packages/http) - Untuk melakukan panggilan ke API.
- [intl](https://pub.dev/packages/intl) - Untuk memformat tanggal agar mudah dibaca.
- [flutter_svg](https://pub.dev/packages/flutter_svg) - Untuk menampilkan logo pada halaman pembuka.

## 📸 Screenshot

| Halaman Get Started | Halaman Pemilihan Kota | Halaman Utama | Tampilan List |
| :---: | :---: | :---: | :---: |
| [Screenshot_2025-07-11-13-54-51-941_com example prakira](https://github.com/user-attachments/assets/f22d3665-d74a-4081-9a8f-a35baca14584) | [Screenshot_2025-07-11-13-54-57-864_com example prakira](https://github.com/user-attachments/assets/e4e2cf76-4e30-42a6-8047-b417e01e8f0c) | ![Screenshot_2025-07-11-13-55-01-050_com example prakira](https://github.com/user-attachments/assets/50ce1b32-bb8a-43a7-9ba8-9f664a7b20b4) | ![Screenshot_2025-07-11-13-55-03-536_com example prakira](https://github.com/user-attachments/assets/a2ea5790-03c0-43b8-b08b-9799aa592cb2)

| **[Contoh Gambar]** | **[Contoh Gambar]** | **[Contoh Gambar]** |


## ⚙️ Instalasi dan Konfigurasi

1.  **Clone repository ini**
    ```bash
    git clone [https://github.com/aryamahesa/prakira-api-flutter.git](https://github.com/aryamahesa/prakira-api-flutter.git)
    cd prakira-api-flutter
    ```

2.  **Install dependensi Flutter**
    ```bash
    flutter pub get
    ```

3.  **Tambahkan Kunci API**
    - Dapatkan kunci API gratis dari [OpenWeatherMap](https://openweathermap.org/api).
    - Buka file `lib/ui/home.dart`.
    - Ganti nilai variabel `_apiKey` dengan kunci API Anda.
      ```dart
      // lib/ui/home.dart

      final String _apiKey = 'GANTI_DENGAN_KUNCI_API_ANDA';
      ```

4.  **Jalankan Aplikasi**
    ```bash
    flutter run
    ```
