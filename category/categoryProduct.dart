import 'package:dotcom/util/searchCategory.dart';
import 'package:flutter/material.dart';

class SelectProducts extends StatelessWidget {
  const SelectProducts({Key? key}) : super(key: key);

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
                SearchCategory(
                    label: 'Accessories', image: 'lib/images/Accessories.png'),
                SearchCategory(
                    label: 'Appliances', image: 'lib/images/Appliances.png'),
                SearchCategory(
                    label: 'Clothes', image: 'lib/images/Clothes.png'),
                SearchCategory(
                    label: 'Foods and Drinks',
                    image: 'lib/images/Foods and Drinks.png'),
                SearchCategory(
                    label: 'Gadgets', image: 'lib/images/Gadgets.png'),
                SearchCategory(
                    label: 'Health and Personal Care',
                    image: 'lib/images/Health and Personal Care.png'),
                SearchCategory(
                    label: 'Toys and Collectibles',
                    image: 'lib/images/Toys and Collectibles.png'),
                SearchCategory(label: 'Sports', image: 'lib/images/Sports.png'),
                SearchCategory(label: 'Others', image: 'lib/images/Others.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
