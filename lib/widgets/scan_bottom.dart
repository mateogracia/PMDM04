import 'package:flutter/material.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

import '../models/scan_model.dart';
import '../providers/db_provider.dart';

//p45: de momento vamos a poner dentro de este boton la funcionalidad de que se cree un nuevo objeto de tipo scanModel, es temporal 
//p46: como dijimos ya no usaremos DBProvider sino que trabajaremos con scanlistprovider, ais que definimos el proveedor
//p47: una vez definido lo que haremos será usar ese objeto para crear un nuevo scan al que le pasaremos por parametro un valor (url de un sitio web)
//p48: una vez definido lo que hace la pantalla del direccions screen ahora hay que hacer lo mismo con la de mapas screen
//p77; hasta ahora pasabamos un scan con una url de tipo gepo o de tipo http, ahora usaremos la libreria flutter_barcode_scanner que ya implementamos hace 2 pasos
//p78: al no tener un dispositivo movil en el que probar el codigo de antes nos daria un fallo, por tanto lo dejaremos como estaba antes pero la funcionalidad de usar la camara para escanear QR queda comentada
//TAMBIEN QUEDA COMENTADA LA LIBRERIA EN PUBSPEC.YAML Y LA IMPORTACION DE LA LIBRERIA AL PRINCIPIO DEL CODIGO; SI NO LO HACEMOS LA APP NO FUNCIONARÁ

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        print('Botó polsat!');
        //String barcodeScanRes= 'https://paucasesnovescifp.cat'; //p47 
        //prueba para los casos en que se devuelve un enlace de geolocalizacion
        String barcodeScanRes= 'geo:39.7260847,2.9134922'; //p47 
        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode( //p77 este codigo esta en pub.dev
        //                                            '#3D8BEF', 
        //                                            'Cancelar', 
        //                                            false, 
        //                                            ScanMode.QR);

        final scanListProvider = Provider.of<ScanListProvider>(context, listen:false); //p46
        ScanModel nouscan= ScanModel(valor: barcodeScanRes);
        scanListProvider.nouScan(barcodeScanRes); //p47 
        //DBProvider.db.insertScan(nouScan); //como ya dijimos no vamos a trabajar directamente con DBProvider sino que lo haremos desde scan_listprovider
        launchURL(context, nouscan); //p64
      
      },
    );
  }
}
