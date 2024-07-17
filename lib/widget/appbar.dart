import 'package:flutter/material.dart';
import 'package:tobe_mart/page/troli_page.dart';
import 'package:tobe_mart/page/mail_list_page.dart';
import 'package:tobe_mart/page/search_result_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  void _searchProducts(BuildContext context) {
    final searchQuery = _searchController.text;
    if (searchQuery.isNotEmpty) {
      _focusNode.unfocus(); // Unfocus the TextField before navigating
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return SearchResultPage(searchQuery: searchQuery);
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      print("Focus: ${_focusNode.hasFocus}");
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Background color similar to the image
        elevation: 0, // No shadow
        title: SizedBox(
          width: 330, // Set desired width for the search bar
          height: 36, // Set desired height for the search bar
          child: TextField(
            focusNode: _focusNode,
            controller: _searchController,
            onSubmitted: (value) => _searchProducts(context),
            decoration: InputDecoration(
              hintText: 'Cari di ToBe Store',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: SizedBox(
              width: 30,
              child: IconButton(
                icon: const Icon(Icons.mail_outline, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return ListMail();
                  }));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: SizedBox(
              width: 30,
              child: IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.black),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 2.0),
            child: SizedBox(
              width: 30,
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return const ChartPage();
                  }));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
