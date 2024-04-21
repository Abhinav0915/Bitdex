import 'package:bitdex/provider/fav_provider.dart';
import 'package:bitdex/screens/cryptodetails.dart';
import 'package:bitdex/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bitdex/screens/login.dart';
import 'package:bitdex/screens/splash.dart';
import 'package:bitdex/screens/homepage.dart';
import '../screens/favorite.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Favorites()),
    ], child: const BitDex()),
  );
}

class BitDex extends StatelessWidget {
  const BitDex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routes = {
      '/': (context) => const login(),
      '/cryptodetails': (context) => CryptoDetailsPage(
            data: ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>,
          ),
      '/signup': (context) => const signup(),
      '/homepage': (context) => const homepage(),
      '/favorite': (context) => FavoriteScreen(),
      '/splash': (context) => const splash(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: '/homepage',
      routes: routes,
    );
  }
}
