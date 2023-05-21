//P9: creamos el provider BBDD que tendrá estructura singleton
//P10: creamos constructor de ripo privado
//P11: se define una variablew que tendrá por valor el constructor de la clase
//P12: implementamos la dependencia  sqflite y path_provider (será con estas que crearemos la BBDD)
//p13: creamos objeto de tipo Database, no lo inicializo inicialmente por eso pongo el ?
//p14: creamos getter que devuelve obj de tipo Database si este no esta vacío
//p15: si está vacio lo que se hará es usar el metodo initDB que inicializara la BBDD (para no alentizar el fx de la app lo pongo asyncrono)
//p16: definimos del getter que es lo que se va a devolver (variable tipo Future<Database>)
//p17: determino que _database siempre devuelva valor: en el return añado ! al final de lo que se devolvera
//p18: defino el metodo initDB
//p19: para crear la bbdd primero se obtendrá el path, la ruta con la que una vez este creada la BBDD accederemos a ella
//p20: a partir de ahi ya crearemos la BBDD
//p21: ahora se tienen que configurar los select, update, insert y demas de la BBDD, para eso crearemos un model: scan_model.dart
//p25: una vez configurada esa clase scan_model vamos a definir las operaciones que se pueden realizar: selects, inserts, etc
//p26: una vez definidas las operaciones haremos una prueba en el homescreen


import 'dart:ffi';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider{

  static Database? _database; //p13

  static final DBProvider db = DBProvider._(); //P11

  DBProvider._(); //P10

  Future<Database> get database async { //p14 p16
    if (_database == null) _database = await initDB();      
    
    return _database!; //p17
        
  }

  Future<Database> initDB() async { //p18
    //p19
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path= join(documentsDirectory.path, 'Scans.db');  //puede dar error al detectar el join asi que agrego a mano el import del package path
    print(path); // para comprobar que se obtiene bien la ruta


    //p20
    //si tengo sentencias con sql para la creacion podria usar _database.execute(sentenciaSQL)
    return await openDatabase(
      path,
      version: 1, //si cambiamos la version devolvera objetos diferentes de la clase BBDD, si lo mantengo estatico me deviuelve siempre mi BBDD creada
      onOpen: (db) {
        
      },
      onCreate: (Database db, int version) async { //será aqui donde se creará la BBDD
        //las sentencias sql se introduciran entre ''' sentenciasSQL '''
        await db.execute(''' 
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipus TEXT,
            valor TEXT
          )

        ''');
      } ,
      
      
      
      );


  }

  //p25

  //FORMA 1 de hacer INSERT
  Future<int> insertRawScan(ScanModel nouScan) async{
    //defino las 3 variables que introducire:
    final id =nouScan.id;
    final tipus= nouScan.tipus;
    final valor = nouScan.valor;

    //creo un objeto de database
    final db= await database; //en BBDD todas las operaciones son asincronas

    //creo una variable donde se guardaran las respuestas de la peticion
    final res = await db.rawInsert('''

      INSERT INTO Scans(ide, tipus, valor)
      VALUES($id,$tipus,$valor)

    ''');

    //para comprobar que se hace correctamente el insert metemos un print:
    print(res);
    return res;

  }

  //FORMA 2 de hacer INSERT:
    Future<int> insertScan(ScanModel nouScan) async{
    //creo un objeto de database
    final db= await database; //en BBDD todas las operaciones son asincronas
    
    //insert en el que mapeo directamente los valores del objeto nouScan que se pasan por parametro en la tabla
    final res = await db.insert('Scans', nouScan.toMap());

    //para comprobar que se hace correctamente el insert metemos un print:
    print(res);
    return res;
    }


    //Select de todos los elementos de la tabla (lista de objetos d ela tabla)
    Future<List<ScanModel>> getAllScans() async{
      //creo un objeto de database
    final db= await database; //en BBDD todas las operaciones son asincronas

    final res= await db.query('Scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() :[];
    //lo que devolverá es una lista de scanmodels en el que los elementos mapeados en el scanmodel los mapea a la respuesta, todo esto siempre que obtenga algo de la query

    }

  //Select de un elemento de la tabla segun su id 
  Future<ScanModel?> getScansByID(int id) async{ //como se puede devolver un null definimos que devolverá un scan model pero que puede estar vacio '?'
      //creo un objeto de database
    final db= await database; //en BBDD todas las operaciones son asincronas

    final res= await db.query('Scans', where: 'id= ?', whereArgs: [id] );

    if (res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    }else{
      return null;
    }

    
    }

  //Select de todos los elementos de la tabla segun su tipo
  Future<List<ScanModel?>> getScansByTipus(String tipus) async{ //como se puede devolver un null definimos que devolverá un scan model pero que puede estar vacio '?'
      //creo un objeto de database
    final db= await database; //en BBDD todas las operaciones son asincronas

    final res= await db.query('Scans', where: 'tipus= ?', whereArgs: [tipus] );

    if (res.isNotEmpty) {
      return res.map((e) => ScanModel.fromMap(e)).toList();
    }else{
      return [];
    }    
    }

  //Update
  Future<int> UpdateScan(ScanModel nouScan) async{
  //creo un objeto de database
  final db= await database; //en BBDD todas las operaciones son asincronas

  final res= await db.update('Scans', nouScan.toMap(), where: 'id = ?', whereArgs: [nouScan.id] );
  
  return res;
  }

  //Delete Tipo 1: Todo el contenido de la tabla  sin usar sentencias sql
  Future<int> DeleteAll() async{

  //creo un objeto de database
  final db= await database; //en BBDD todas las operaciones son asincronas
  final res= await db.delete('Scans');
  
  return res;
  }

  //Delete Tipo 2: Todo el contenido de la tabla usando sentencias sql
  Future<int> DeleteRawAll() async{

  //creo un objeto de database
  final db= await database; //en BBDD todas las operaciones son asincronas
  final res= await db.rawDelete('''Delete From Scans''');
  
  return res;
  }

  //Delete un Scan
Future<int> DeleteScan(int id) async{
//creo un objeto de database
  final db= await database; //en BBDD todas las operaciones son asincronas
  final res= await db.delete('Scans', where: 'id = ?', whereArgs: [id]);  
  return res;
  }
}