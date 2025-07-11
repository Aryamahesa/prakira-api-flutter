  import 'package:flutter/material.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:prakira/models/constant.dart';
  // import 'package:prakira/ui/weather_page.dart';
  import 'package:prakira/ui/welcome1.dart';

  class GetStarted extends StatelessWidget {
    const GetStarted({super.key});

    @override
    Widget build(BuildContext context) {
      // Inisialisasi objek Constant
      Constant myConstant = Constant();

      return Scaffold(
        body: Container(
          // Menggunakan dekorasi background dari Constant
          decoration: myConstant.getStartedBgDecoration,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // padding untuk logo
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: SvgPicture.asset(
                    // gambar logo
                    'assets/icons/Group 1 (1).svg',
                  ),
                ),

                const SizedBox(height: 100),

                // padding untuk button
                GestureDetector(
                  onTap: () {
                    // navigasi ke halaman weather
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Welcome()),
                    );
                  },
                  child: Container(
                    height: 64,
                    width: 250,
                    decoration: BoxDecoration(
                      color: myConstant.getStartbuttonColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: myConstant.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
