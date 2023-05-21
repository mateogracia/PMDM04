
import 'package:flutter/material.dart';
import 'package:qr_scan/providers/db_provider.dart';

import '../models/scan_model.dart';

//esta clase servirá de interfaz entre el db_provider y los widgets, las operaciones se definen en dbprovider pero se ejecutaran aqui
//p29: defino la lista de ScanModel que se tendrá por si hay que hacer alguna modificacion, asi como el tipo seleccionado en funcion del boton elegido
//p30: creo un metodo que recibirá como parametro un string (el valor que va a tomar un Scanmodel) de forma que crea un objeto de tipo ScanModel con el valor que se pasa, pero haria falta el resto de parametros (id y tipus) 
//para eso usamos el metodo insert que nos devuelve el id que le corresponde asi que ya tendriamos eso y luego si el tipus que tiene este objeto coincide con el de la variable lo añadimos al la lista de obj Scan Model que tienen ese tipo
//p31: crearemos otro metodo que se encargará de cargar todos los ScanModels de la tabla de la BBDD
//p32: con otro metodo lo que haremos será cargar solo los datos de la tabla que tienen definido el tipus = al que s epase por parametro
//p33: creo un metodo con el que borrare todos los datos de la tabla
//p34: creo un metodo donde borrare un regustro de la tabla, el que tengo por id el que le paso por parametro



class ScanListProvider extends ChangeNotifier{
  //p29
  List<ScanModel?> ListaScans = [];
  String tipusSeleccionado = 'http';  //este valor irá cambiando segun el boton que se seleccione: si es maps el tipo será geo y si es direccions el tipo sera http

  //p30
  Future<ScanModel> nouScan (String valor) async{
    final nouScan = ScanModel(valor: valor);
    final id= await DBProvider.db.insertScan(nouScan);

    nouScan.id = id;

    if (nouScan.tipus == tipusSeleccionado) {
      this.ListaScans.add(nouScan);
      notifyListeners();
    }

    return nouScan;
  }

  //p31
  carregaScans() async{
  final scans = await DBProvider.db.getAllScans();
  this.ListaScans= [...scans]; //lo que hacemos es meter la lista que obtuvimos dentro de la lista que definimos inicialmente que es atributo de esta clase scan_list_provider
  notifyListeners();
  }

  //p32
  carregaScansPerTipus(String tipus) async{
  final scans = await DBProvider.db.getScansByTipus(tipus);
  this.ListaScans= [...scans]; //lo que hacemos es meter la lista que obtuvimos dentro de la lista que definimos inicialmente que es atributo de esta clase scan_list_provider
  notifyListeners();
  }

  //p33
  borrarTodos() async{
  final scans = await DBProvider.db.DeleteAll(); // en este caso no hago nada con la lista porque el delete me devuelve un int informando si se ha eliminado o no, nada mas, por tanto la lista ne estos casos estará vacia
  notifyListeners();
  }

  //p34
  borrarTodosPorID(int id) async{
  final scans = await DBProvider.db.DeleteScan(id); // en este caso no hago nada con la lista porque el delete me devuelve un int informando si se ha eliminado o no, nada mas, por tanto la lista ne estos casos estará vacia
  notifyListeners();
  }
}