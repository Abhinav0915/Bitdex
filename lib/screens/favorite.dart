
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/fav_provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Cryptocurrencies'),
      ),
      body: Consumer<Favorites>(
        builder: (context, favorites, child) {
          if (favorites.favorites.isEmpty) {
            return const Center(
              child: Text('No favorites added.'),
            );
          } else {
            return ListView.builder(
              itemCount: favorites.favorites.length,
              itemBuilder: (context, index) {
                final crypto = favorites.favorites[index];
                final price = double.parse(crypto['quote']['USD']['price'].toString());
                final priceString = price.toStringAsFixed(2);

                return ListTile(
                  leading: Image.network(
                    'https://s2.coinmarketcap.com/static/img/coins/64x64/${crypto['id']}.png',
                    height: 40.0,
                    width: 40.0,
                  ),
                  title: Text(
                    crypto['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  subtitle: Text(
                    '\$$priceString',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}