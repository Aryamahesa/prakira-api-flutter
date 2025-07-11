import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:prakira/models/city.dart';
import 'package:prakira/models/constant.dart';
import 'package:prakira/ui/home.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  // Daftar ini hanya berisi kota yang bisa dipilih (bukan default)
  final List<City> _selectableCities =
      City.getCities().where((city) => city.isDefault == false).toList();

  @override
  Widget build(BuildContext context) {
    Constant myConstant = Constant();
    // Menghitung kota yang dipilih secara dinamis dari state
    List<City> currentlySelectedCities =
        _selectableCities.where((city) => city.isSelected).toList();

    return Scaffold(
      body: Container(
        decoration: myConstant.getStartedBgDecoration,
        child: Stack(
          children: [
            Column(
              children: [
                _buildCustomAppBar('Select Locations'),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 120),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _selectableCities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildGlassCityCard(_selectableCities[index]);
                    },
                  ),
                ),
              ],
            ),

            // Tombol "Lanjutkan" hanya muncul jika ada kota yang dipilih
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // 1. Ambil kota default dari daftar asli.
                  City defaultCity = City.getCities().firstWhere(
                    (city) => city.isDefault == true,
                  );

                  // 2. Buat daftar akhir yang akan dikirim,
                  //    dimulai dengan kota default.
                  List<City> finalCitiesToSend = [defaultCity];

                  // 3. Tambahkan kota-kota yang baru saja dipilih pengguna.
                  finalCitiesToSend.addAll(currentlySelectedCities);

                  // 4. Kirim daftar gabungan ini ke halaman Home.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => Home(selectedCities: finalCitiesToSend),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: myConstant.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(String title) {
    // ... (Fungsi ini tidak perlu diubah)
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCityCard(City city) {
    // ... (Fungsi ini tidak perlu diubah)
    return GestureDetector(
      onTap: () {
        setState(() {
          city.isSelected = !city.isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      city.isSelected
                          ? Colors.white.withOpacity(0.8)
                          : Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        city.isSelected = !city.isSelected;
                      });
                    },
                    child: Image.asset(
                      city.isSelected
                          ? 'assets/icons/checked.png'
                          : 'assets/icons/unchecked.png',
                      width: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    city.name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight:
                          city.isSelected ? FontWeight.bold : FontWeight.normal,
                      color:
                          city.isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
