//p22: voy a la pagina de quicktype.io y configuro un json simple de prueba que esa pagina me convertira en una clase
//p23: configuramos el campo valor como obligatorio (required) y el resto opcionales (añado ? a su delcaracion)
//p24: determino una validacion  en el constructor de manera que si el valor que metemos contiene la cadena http el tipo se determina automaticamente como http y sino lo determinara como tipo geo
//p69: para obtener la latlong crearemos un getter, lo primero es implementar la dependencia peor si la implementamos entera dara error por eso solo implementaremos de la dependencia el tipo: LatLng
//p70: ahora dentro del metodo definiremos la variable donde se almacenará latlong, en la cual nosotros ya directamente le haremos un split mediante un substring separando por la coma, y luego asignamos cada una de las partes a la variable que le corresponda (lat y long)
//p71: ahora modificaremos el codigo de mapa screen con el nuevo metodo que hemos configurado
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng; //p69

class ScanModel {
    int? id; //p23
    String? tipus; //p23
    String valor;

    ScanModel({
        this.id,
        this.tipus,
        required this.valor, //p23
    }){ //p24
      if (this.valor.contains('http')) {
        this.tipus= 'http';
      }else{
        this.tipus= 'geo';
      }
    }




    factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipus: json["tipus"],
        valor: json["valor"],
    );

    LatLng getLatLng(){ //devuelve un obj de tipo LatLong que tiene como primer parametro la latitud y segundo la longitud
      final latLng = this.valor.substring(4).split(','); //p70
      final lat = double.parse(latLng[0]) ;//p70
      final long= double.parse(latLng[1]) ;//p70

      return LatLng(lat, long);
    }

    Map<String, dynamic> toMap() => {
        "id": id,
        "tipus": tipus,
        "valor": valor,
    };
}