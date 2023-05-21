import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/providers/ui_providers.dart';
import 'package:qr_scan/screens/home_screen.dart';
import 'package:qr_scan/screens/mapa_screen.dart';

//P3: dentro del main implemento el multiprovider, delegando el metodo myapp al child y creando un changenotifierprov donde defino el proveedor que he creado
//p44: tengo que definir otro ChangeNotifierProvider que se va a usar: ScanListProvider se usa en las tiles

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_)=> UIProvider()),
    ChangeNotifierProvider(create: (_)=> ScanListProvider()),
    ], //P3
   child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'mapa': (_) => MapaScreen(),
      },
      theme: ThemeData(
        // No es pot emprar colorPrimary des de l'actualització de Flutter
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.deepPurple,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
