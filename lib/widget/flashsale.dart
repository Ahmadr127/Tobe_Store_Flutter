import 'package:flutter/material.dart';
import 'package:tobe_mart/widget/product_thumbnail.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: [
            // Title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Traktiran Pengguna Baru",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      "Berakhir dalam:",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.red),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("20 : 10 : 00",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                    const Spacer(),
                    const Text(
                      "Lihat semua",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            // Items
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 2),
                        height: 230,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/traktiran.png"), // Ubah dengan path gambar Anda
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  const ProductThumbnail(),
                  const ProductThumbnail(),
                  const ProductThumbnail(),
                  const ProductThumbnail(),
                  const ProductThumbnail(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
