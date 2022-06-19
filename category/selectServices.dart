import 'package:dotcom/result/searchServiceFromSearchIcon.dart';
import 'package:dotcom/util/category.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectServices extends StatelessWidget {
  const SelectServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String searchService;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Services Category',
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
                    searchService = 'Appliances Repair';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Appliances Repair');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Appliances Repair',
                      image: 'lib/images/Appliances Repair.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Automotive Repair';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Automotive Repair');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Automotive Repair',
                      image: 'lib/images/Automotive Repair.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Catering';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Catering');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Catering Service',
                      image: 'lib/images/Catering Services.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Cooking and Baking';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Cooking and Baking');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Cooking and Baking',
                      image: 'lib/images/Bake and Cook.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Driver';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('categoryProductFromSearchIcon', 'Driver');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Driver', image: 'lib/images/Driver.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Gadget Repair';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Gadget Repair');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Gadget Repair',
                      image: 'lib/images/Gadget Repair.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Haircut and Nails';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Haircut and Nails');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Haircut and Nails',
                      image: 'lib/images/Haircut and Nails.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Household Chores';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Home Service');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Home Service',
                      image: 'lib/images/Household Chores.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Spa and Massage';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('categoryProductFromSearchIcon', 'Massage');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Massage', image: 'lib/images/Massage.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Printing Service';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString(
                        'categoryProductFromSearchIcon', 'Printing Service');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
                  },
                  child: const CategoryCointainer(
                      label: 'Printing Service',
                      image: 'lib/images/Printing Services.png'),
                ),
                InkWell(
                  onTap: () async {
                    searchService = 'Others';
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('categoryProductFromSearchIcon', 'Others');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const SearchedSearviceInSearchIcon()));
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
