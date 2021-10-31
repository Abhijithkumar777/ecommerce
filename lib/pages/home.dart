import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intertoon/pages/productdetails.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List productlist = [];
  List bannerList = [];

  Future<void> fetchDataFromAPI() async {
    print("hi");
    var url = "http://omanphone.smsoman.com/api/homepage";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        productlist = json.decode(response.body);
      });
    }
  }

  List<Widget> bannerContainerList = [];

//API call for Banner
  Future<void> fetchBanner() async {
    var url = "http://omanphone.smsoman.com/api/configuration";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        bannerList = (json.decode(response.body))['data']['slider'];
      });
      for (int i = 0; i < bannerList.length; i++) {
        bannerContainerList.add(Container(
          child: Image(
            image: NetworkImage(bannerList[i]['image']),
          ),
        ));
      }
    }
  }

  @override
  void initState() {
    fetchDataFromAPI();
    fetchBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset:false,
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
              items: bannerContainerList,
            ),
            height: screenHeight * 0.3,
            width: screenWidth,
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            height: screenHeight * 0.4,
            child: ListView.builder(
              itemCount: productlist.length,
              itemBuilder: (context, index) {
                return Container(
                    child: productlist[index]['type'] == 'banner'
                        ? Container(
                            child: Image(
                              image: NetworkImage(
                                  productlist[index]['data']['file']),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12),
                            child: Container(
                              width: screenWidth,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          productlist[index]['data']['title'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        MaterialButton(
                                          color: Colors.red,
                                          onPressed: () {},
                                          child: Text(
                                            'VIEW ALL',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Container(
                                      height: 250,
                                      child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2),
                                          itemCount: productlist[index]['data']
                                                  ['items']
                                              .length,
                                          itemBuilder: (_, innerIndex) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Productdetail()));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.05)),
                                                height: screenHeight * 0.25,
                                                // color: Colors.white,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height:
                                                          screenHeight * 0.15,
                                                      child: Image(
                                                          image: NetworkImage("https://omanphone.smsoman.com/pub/media/catalog/product" +
                                                              productlist[index]
                                                                              [
                                                                              'data']
                                                                          [
                                                                          'items']
                                                                      [
                                                                      innerIndex]
                                                                  ['image'])),
                                                    ),
                                                    Text(productlist[index]
                                                            ['data']['items']
                                                        [innerIndex]['name']),
                                                    Text("OMR " +
                                                        productlist[index]['data']
                                                                        [
                                                                        'items']
                                                                    [innerIndex]
                                                                ['price']
                                                            .toString()),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }))
                                ],
                              ),
                            ),
                          ));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    Text(
      'Index 2: Categories',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
