import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductThumbnail extends StatelessWidget {
  const ProductThumbnail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      height: 230,
      width: 120,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: Container(
              height: 130,
              width: double.infinity,
              color: Colors.blue,
              child: Image.asset(
                "assets/images/products/thumbnailproduct.webp",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.pink.shade50),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Text(
                      "100%",
                      style: TextStyle(
                          fontSize: 8,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Rp 39.000",
                  style: TextStyle(
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Rp 0",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                SizedBox(
                    width: 15,
                    height: 15,
                    child: SvgPicture.asset(
                        "assets/images/products/official-badge.svg")),
                const SizedBox(
                  width: 2,
                ),
                const Text(
                  "Jakarta",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: double.infinity,
              height: 2,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Segera habis",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 9,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
