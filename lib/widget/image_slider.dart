import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 150.0, // Ubah tinggi gambar sesuai kebutuhan Anda
          enlargeCenterPage: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 10),
          aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          viewportFraction: 1.0,
        ),
        items: [
          _buildCarouselItem(
            'assets/images/milk.png',
            const Color.fromARGB(255, 167, 228, 249),
            BorderRadius.circular(10.0), // BorderRadius dengan radius 10.0
          ),
          _buildCarouselItem(
            'assets/images/officialstore.png',
            const Color.fromARGB(255, 253, 226, 173),
            BorderRadius.circular(10.0), // BorderRadius dengan radius 10.0
          ),
          // Tambahkan gambar lain di sini
        ],
      ),
    );
  }

  Widget _buildCarouselItem(
    String imagePath,
    Color bgColor,
    BorderRadius borderRadius,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Image.asset(
            imagePath,
            height: 200.0, // Sesuaikan tinggi gambar sesuai kebutuhan
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
