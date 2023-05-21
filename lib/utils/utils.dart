//p61: una vez creada la clase defino una variable de tipo uri (url) que se pasará al metodo que configuramos 
//p62: con este metodo primero se hará una validación: si el tipus del scan que se le pasa es "http" lo que hará es abrir la pagina web, si por otro lado es de otro tipo lo que hara es abrir el navegador (la variable mapa ya estaba definida en la plantilla)
//p63: ahora que el metodo está creado habra que añadir un llamado a este desde la funcionalidad ontap del scantiles
//p64: tambien configuramos esta funcionalidad cuando se de al scan button 

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scan_model.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  final url =  Uri.parse(scan.valor); 
  if (scan.tipus == 'http') {
    if(!await launchUrl(url)) {throw Exception('Could not launch $url');
  }
  } else{
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}