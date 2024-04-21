import 'package:bitdex/screens/favorite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/api.dart';
import '../screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List _cryptoData = [];
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List _filteredCryptoData = [];
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _fetchCryptoData();
    _searchController.addListener(() {
      _filterCryptoData(_searchController.text);
    });
    // _filteredCryptoData = List.from(_cryptoData);
    // _filteredCryptoData = List.from(_cryptoData);
    // _filterCryptoData(_searchController.text);
  }

  Future<void> _fetchCryptoData() async {
    final cryptoData = await Api.fetchCryptoData();
    setState(() {
      _cryptoData = cryptoData;
    });
  }

  void _filterCryptoData(String searchText) {
    setState(() {
      _filteredCryptoData = _cryptoData
          .where((data) =>
              data['name'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void _sortCryptoData(String option) {
    setState(() {
      switch (option) {
        case 'name':
          _filteredCryptoData.sort((a, b) => a['name'].compareTo(b['name']));
          break;
        case 'price':
          _filteredCryptoData.sort((a, b) =>
              a['quote']['USD']['price'].compareTo(b['quote']['USD']['price']));
          break;
        default:
          break;
      }
    });
  }

  void _showSortOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sort Cryptocurrency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text('Name'),
              onTap: () {
                _sortCryptoData('name');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Price'),
              onTap: () {
                _sortCryptoData('price');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Clear Sorting'),
              onTap: (() {
                //clear all sorting
                _filteredCryptoData = List.from(_cryptoData);
                Navigator.pop(context);
              }),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BitDex'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _filteredCryptoData = _cryptoData;
                }
              });
            },
            icon: _isSearching
                ? const Icon(Icons.clear)
                : const Icon(Icons.search),
          ),
          IconButton(
            onPressed: _showSortOptions,
            icon: const Icon(Icons.sort),
          ),
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white54,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Homepage'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoriteScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                // print('Log out tapped');
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const login()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.pink,
              Color.fromARGB(255, 88, 1, 201),
              Colors.black87,
            ],
          ),
        ),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 550),
              width:
                  _isSearching ? MediaQuery.of(context).size.width * 0.6 : 0.0,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  _filterCryptoData(value);
                },
                decoration: const InputDecoration(
                  hintText: 'Search Cryptocurrency',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(143, 255, 255, 255)),
                  border: InputBorder.none,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _cryptoData.length, //_cryptoData.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = _cryptoData[index]; //_cryptoData[index];
                  final price =
                      double.parse(data['quote']['USD']['price'].toString());
                  final priceString = price.toStringAsFixed(2);

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cryptodetails',
                          arguments: data);
                    },
                    child: Card(
                      elevation: 0.0,
                      color: Colors.transparent,
                      child: ListTile(
                        leading: Image.network(
                          'https://s2.coinmarketcap.com/static/img/coins/64x64/${data['id']}.png',
                          height: 40.0,
                          width: 40.0,
                        ),
                        title: Text(
                          data['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '\$$priceString',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
