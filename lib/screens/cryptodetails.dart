import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/favorite.dart';
import '../provider/fav_provider.dart';

class CryptoDetailsPage extends StatefulWidget {
  final dynamic data;

  CryptoDetailsPage({required this.data});

  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
  bool _isFavorite = false;
  List<dynamic> favourites = [];

  void _toggleFavorite(BuildContext context) {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    if (_isFavorite) {
      Provider.of<Favorites>(context, listen: false)
          .addToFavorites(widget.data);
    } else {
      Provider.of<Favorites>(context, listen: false)
          .removeFromFavorites(widget.data);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoriteScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final price = double.parse(widget.data['quote']['USD']['price'].toString());
    final priceString = price.toStringAsFixed(2);
    final favorites = Provider.of<Favorites>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.data['name']),
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });

                // Add/remove cryptocurrency from favorites list
                if (_isFavorite) {
                  favourites.add(widget.data);
                } else {
                  favourites.remove(widget.data);
                }
              },
            ),
          ],
        ),
      ),
      body: Card(
        elevation: 0.0,
        color: Colors.transparent,
        child: Column(
          children: [
            ListTile(
              leading: Image.network(
                'https://s2.coinmarketcap.com/static/img/coins/64x64/${widget.data['id']}.png',
                height: 40.0,
                width: 40.0,
              ),
              title: Text(
                widget.data['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              trailing: Text(
                '\$$priceString',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                widget.data['symbol'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                widget.data['slug'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Market Cap',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '\$${widget.data['quote']['USD']['market_cap'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Volume 24h',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '\$${widget.data['quote']['USD']['volume_24h'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Percent Change 24h',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '${widget.data['quote']['USD']['percent_change_24h'].toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Percent Change 7d',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '${widget.data['quote']['USD']['percent_change_7d'].toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Percent Change 30d',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '${widget.data['quote']['USD']['percent_change_30d'].toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Percent Change 60d',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '${widget.data['quote']['USD']['percent_change_60d'].toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            //display future data
          ],
        ),
      ),
    );
  }
}
