import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';



//p65: en esta clase creamos una instancia de scanmodel y a partir de esta enseñaremos su valor por pantalla
//p66: añadimos la dependencia google_maps_flutter y vamos a la pagina que viene en las recomendaciones de la dependencia creamos un proyecto>APIs y servs>Panel
//p67: convertimos el statelesswidget en statefulwidget (con la bombilla)
//p68: añadimos al codigo lo que indica pub.dev sobre esta dependencia
//p69: vamos a cambiar los valores que se pasan al codigo nuevo en la variable LatLng, para ello añadiremos nuevo codigo en el scan_model
//p71: cambiaremos el codigo donde se definia la LatLong, por el metodo creado, tambn haremos el zoom mas grande para que se vea mejor, añadiremos un tilt para que se carguen mas cosas en el mapa y cambiaremos el maptype a normal para verlo como se veria en google maps
//p72: vamos a añadir un marcador automatico para cuando se abra el mapa: estos se deben establecer en el body de googleMaps pero se le tiene que pasar un objeto de tipo Marker, que tendremos que crear
//p73: añadiremos las funcionalidad extra d ela app bar con su nuevo boton
//p74: la ultima funcionalidad que nos queda es el boton flotante debajo de la pantalla que cambia el maptype
//p75: para finalizar queda implementar la funcionalidad de lectura de codigos de barra con el boton, para ello implementamos la dependencia: flutter_barcode_scanner
//p76: ahora haremos los cambios necesarios en la clase scan_bottom

class MapaScreen extends StatefulWidget { //p67
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>(); //p68
  MapType _currentMapType = MapType.normal; 
  @override
  Widget build(BuildContext context) {
    
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    
    final CameraPosition _puntInicial = CameraPosition( //p68
    //target: LatLng(37.42796133580664, -122.085749655962),//p71
    target: scan.getLatLng(), //p71
    zoom: 17, //P71
    tilt: 50, //p71
    );

    

    Set<Marker> markers = new Set<Marker>(); //p72
    markers.add( //p72 ahora añado un marcador en la latlong que se pase, s epodrán añadir todos los marcadores que queramos
      new Marker(
        position: scan.getLatLng(), 
        markerId: MarkerId('id1'),
        )
    );

    return Scaffold(
      appBar: AppBar(//p73
        title: Text('Ubicacion'),
        actions: [
          IconButton(
            icon: Icon(Icons.center_focus_strong),
            onPressed: () { //p73 de esta manera lo que hacemos es cambiar la variable _controller
              _controller.future.then((GoogleMapController controller) {
              controller.animateCamera(CameraUpdate.newLatLng(scan.getLatLng()));
              });
            }           
          ),           
        ],
      ),
      //body: Center(child: Text('${scan.valor}')),  //p65
      body: GoogleMap( //p68 (sustituimos el body de arriba por este)
        mapType: _currentMapType, //p71
        markers: markers,  //p72
        initialCameraPosition: _puntInicial,   
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },        
      ),
      floatingActionButton: Align( //p74
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            // Cambiar el estado del mapType
            setState(() {
              _currentMapType = _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
            });
          },
          child: Icon(Icons.remove_red_eye),
        ),
        
      )
    
    );
    
  }
}
