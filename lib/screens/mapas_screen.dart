import 'package:flutter/material.dart';

import '../widgets/scan_tiles.dart';

//p49: añado el mismo return que en direccionsscreen pero esta vez creara tiles en los caso en que lo que se pase sea de tipo geo, sin embargo esto no funcionará porque el scan_list_provider tiene configurado unicamente aceptar 'http', esto lo modificaremos en el home screen


class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'geo'); //p49
  }
}
