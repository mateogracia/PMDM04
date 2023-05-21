//p35: crearemos un widget de tipe Statelesswidget donde se van representar maps screen y direccions screen
//p36: determinaremos una variable que serán los tipos
//p37: una vez creada se tiene que añadir la variable al constructor de la clase
//p38: cambiamos el container que se devuelve en return, ahora será un ListView.Builder
//p39: dentro del build crearemos un par de variables: una para acceder a los scanlistproviders y otra que será la lista de scans del proveedor que hemos obtenido
//p40: Dentro del ListView.Builder tendremos un contador que tendrá como valor el tamaño de la lista que definimos antes, por otra parte el itemBuilder será un metodo en el que 
//definiremos un listTile que contendrá: un leading (un icono que segun si el tipo es http o no cambiará), un title, subtitle, trailing y una accion a desarrollar cuando se clicke en el
//P41: para que estos tiles se generen debemos definirlos dentro de las clases screen
//p54: vamos a implementar la funcionalidad de eliminar registro al arrastrar el tile, para ello en el list tile hacerle un wrapped with widget (nos pone,os sonre listtile y damos a la bombilla amarilla)
//p55: cambiaremos el widget por dismissible y este metodo exige por parametro una key y un child, child ya tenemos ais que añadimos uniquekey() un metodo que nos genera una key
//p56: para que se pueda clicar  y arrastrar falta añadir otro parametro que seria el ondismissed y modificar dentro del home screen a la instancia del ScanListProvider añadirle el listen: false
//p57: dentro del dismissible añadire nuevas funcionalidades como que cuando se arrastre aparezca un fondo rojo y un icono de papelera
//p58: será dentro del ondismissed donde pongo la funcionalidad de borrado de mi dicho elemento
//p59: ahora que he hecho esto habilitaremos la opcion de que si se clica en un tile de direcciones se abra una pagina web o si es un tile de mapa abrira un mapa, para ello implementamos la dependencia url_launcher
//p60: ahora vamos a crear una rchivo  utils (sera como un access data, contendrá solo metodos de ayuda)



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

//p35
class ScanTiles extends StatelessWidget {
  final String tipus; //p36

  const ScanTiles({Key? key, required this.tipus}) : super(key: key);//p37

  @override
  Widget build(BuildContext context) {
    final scanListProvider= Provider.of<ScanListProvider>(context);//p39
    final scans= scanListProvider.ListaScans;//p39

    return ListView.builder(  
      itemCount: scans.length,
      itemBuilder: (_,index)=> Dismissible(//p54 p55
        key: UniqueKey(), //p55
        background: Container( //p57
          color: Colors.red[300],
          child: Align(
            child: Icon(Icons.delete_forever),
            alignment: Alignment.centerRight ,),
        ),
        onDismissed: (DismissDirection direct) { //p58
          final prov= Provider.of<ScanListProvider>(context, listen: false);
          prov.borrarTodosPorID(scans[index]!.id!);
        },
        child: ListTile( //p40
          leading: Icon(this.tipus== 'http' ? Icons.web : Icons.map_outlined), 
          title: Text(scans[index]!.valor),
          subtitle: Text(scans[index]!.id.toString() ),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black,),
          onTap: () {
            launchURL(context, scans[index]!); //p63
          },
          ),
      )); //p38
  }
}