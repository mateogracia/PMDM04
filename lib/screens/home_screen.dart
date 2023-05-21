import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/screens/screens.dart';
import 'package:qr_scan/widgets/widgets.dart';

import '../providers/ui_providers.dart';

//P7: creo una instancia de mi provider
//P8: defino como index el valor que este proveedor va a ir tomando (con el get)
//p21: para comprobar que se ha definido correctamente el db_provider vamos a crear un objeto de la misma (veremos que está vien configurada si al crearlo y relanzar la app nos printa en terminal el path)
//p27: para verificar si se han definido bien la operaciones del db_provider haremos una prueba con un insert
//p28: las operaciones definidas NO se aplicaran directamente en db_provider sino que crearemos un nuevo proveedor: scan_list_provider que contendrá todas estas operaciones
//p50 para corregir lo mencionado en el paso anterior primero crearemos un objeto proveedor de tiposcanlistprovider
//p51 dentro de esta clase provider tenemos un metodo que nos busca en la base de datos todos los elementos segun el tipo que queramos y nos rellena la lista que es atributo del provider, esto lo haremos cuando se seleccione un boton u otro
//p52: daremos funcionalidad al boton que nos elimina todos los elementos de la BBDD, para ello crearemos una instancia de provider de tipo Scanlistprovider y luego solo se tiene que llamar al metodo que ya teniamos que borra la bbdd
//p53: ahora implementaremos la funcionalidad para que si se arrastra algun tile a la derecha se elimine solo ese tile, eso lo haremos desde la clase scan_tiles


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () { //p52
              final instanceProvider= Provider.of<ScanListProvider>(context, listen: false); //en listen se pone a false siempre que este dentro de un metodo (en este caso onPressed)
              instanceProvider.borrarTodos();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider= Provider.of<UIProvider>(context); //P7

    // Canviar per a anar canviant entre pantalles
    final currentIndex = uiProvider.selectedMenuOpt; //P8


    //creacion de BBDD PRUEBA
    //DBProvider.db.database; //p21

    //prueba de las operaciones de db_provider:
    //ScanModel nouScan = ScanModel(valor: 'https://paucasesnovescifp.cat'); //creo un objeto de ScanModel
    //DBProvider.db.insertScan(nouScan); //p27
    //DBProvider.db.DeleteAll(); //para borrar la BBDD
    //DBProvider.db.insertRawScan(nouScan); //p27

    final scanListProvider= Provider.of<ScanListProvider>(context, listen: false);//p50 p56

    switch (currentIndex) {
      case 0:

        scanListProvider.carregaScansPerTipus('geo'); //p51
        return MapasScreen();

      case 1:
        scanListProvider.carregaScansPerTipus('http'); //p51
        return DireccionsScreen();

      default:
      scanListProvider.carregaScansPerTipus('geo'); //p51
        return MapasScreen();
    }
  }
}
