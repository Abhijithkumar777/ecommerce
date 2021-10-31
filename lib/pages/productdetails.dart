import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Productdetail extends StatefulWidget {
  const Productdetail({Key? key}) : super(key: key);

  @override
  _ProductdetailState createState() => _ProductdetailState();
}

class _ProductdetailState extends State<Productdetail> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Center(child: Text("Ecommerce App")),
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: screenHeight * 0.09,
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.grey,
                  ),
                  hintText: 'Search Products ...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                disableCenter: true,
                viewportFraction: 1,
              ),
              items: [],
            ),
            height: screenHeight * 0.3,
            width: screenWidth,
          ),
          SizedBox(height: screenHeight * 0.01),
        ],
      ),
    );
  }
}
