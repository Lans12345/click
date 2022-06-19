import 'package:dotcom/category/selectServices.dart';
import 'package:dotcom/util/regions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRegionServices extends StatefulWidget {
  const SearchRegionServices({Key? key}) : super(key: key);

  @override
  State<SearchRegionServices> createState() => _SearchRegionServicesState();
}

class _SearchRegionServicesState extends State<SearchRegionServices> {
  late String searchRegion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Select Location',
          style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Quicksand'),
        ),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  InkWell(
                    onTap: () async {
                      searchRegion = 'Region 1';
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString(
                          'regionProductFromSearchIcon', 'Region 1');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SelectServices()));
                    },
                    child: const RegionContainer(
                      label: 'Region 1',
                    ),
                  ),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 2';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 2');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 2')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 3';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 3');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 3')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 4';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 4');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 4')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 5';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 5');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 5')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 6';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 6');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 6')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 7';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 7');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 7')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 8';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 8');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 8')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 9';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 9');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 9')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 10';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 10');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 10')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 11';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 11');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 11')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 12';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 12');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 12')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'Region 13';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString(
                            'regionProductFromSearchIcon', 'Region 13');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'Region 13')),
                  InkWell(
                      onTap: () async {
                        searchRegion = 'NCR';
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('regionProductFromSearchIcon', 'NCR');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SelectServices()));
                      },
                      child: const RegionContainer(label: 'NCR')),
                ],
              ),
            ),
          ]),
    );
  }
}
