import 'package:dotcom/result/searchedProductFromSearIcon.dart';
import 'package:dotcom/util/category.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectProduct extends StatefulWidget {
  const SelectProduct({Key? key}) : super(key: key);

  @override
  State<SelectProduct> createState() => _SelectProductState();
}

class _SelectProductState extends State<SelectProduct> {
  late String searchProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Products Category',
          style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Quicksand'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () async {
                    searchProduct = 'Accessories';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Accessories');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedProductInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Accessories',
                      image: 'lib/images/Accessories.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchProduct = 'Appliances';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Appliances');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedProductInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Appliances', image: 'lib/images/Appliances.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchProduct = 'Clothes';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('categoryProductFromSearchIcon', 'Clothes');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedProductInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Clothes', image: 'lib/images/Clothes.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchProduct = 'Foods and Drinks';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Foods and Drinks');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedProductInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Foods and Drinks',
                      image: 'lib/images/Foods and Drinks.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchProduct = 'Gadgets';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('categoryProductFromSearchIcon', 'Gadgets');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedProductInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Gadgets', image: 'lib/images/Gadgets.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchProduct = 'Health and Personal Care';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('categoryProductFromSearchIcon',
                        'Health and Personal Care');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedProductInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Health and Personal Care',
                      image: 'lib/images/Health and Personal Care.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchProduct = 'Toys and Collectibles';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('categoryProductFromSearchIcon',
                        'Toys and Collectibles');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedProductInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Toys and Collectibles',
                      image: 'lib/images/Toys and Collectibles.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchProduct = 'Sports';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('categoryProductFromSearchIcon', 'Sports');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedProductInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Sports', image: 'lib/images/Sports.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchProduct = 'Others';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('categoryProductFromSearchIcon', 'Others');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedProductInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Others', image: 'lib/images/Others.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
