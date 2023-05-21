import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

//p42: ahora lo que se va a devolver en lugar de un texto fijo será un tile que hemos definido en la clase scan_tiles en funcion del parametro que se introduzca
//p43: como estamos usando mas providers e inicialmente solo definimos uno en el main será necesario definir los otros que usemos, una vez hagamos estas dos cosas en la pantalla principal ya no aparece el texto de antes habrá que configurar que se enseñe la tile cuando es tipus http
class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Center(child: Text('Dir. Screen'),    );  este el return de antes
    return ScanTiles(tipus: 'http'); //p42
  }
}
