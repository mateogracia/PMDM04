import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/ui_providers.dart';

//P2: implementar funcion onTap en la barra de navegacion
//P4: defino un objeto de tipo provider (uiProvider), no olvidar que el proveedor se define de que tipo será (<>)
//P5: añadimos el objeto prov al ontap y uso el setter para definirle el valor i (el setter se usa igualando, no pasando como param por parentesis)
//P6: haremos que el current index vaya obteniendo valores del proveedor en cada momento (usamos el get: solo con llamar al metodo ya está)
//CON ESTO YA SE MARCARIAN LOS BOTONES AL SELECCIONARLOS, NOS FALTA ACTUALIZAR TAMBIEN EL BODY (HOME SCREEN)
class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final uiProvider= Provider.of<UIProvider>(context); //P4
    final currentIndex = uiProvider.selectedMenuOpt; //P6
    return BottomNavigationBar(
      //definiré un evento para cuando se clique en los botones de abajo:
        //onTap: (int i) => print('opc: $i'), //P2
        onTap: (int i) => uiProvider.selectedMenuOpt = i, //P2 P5
        elevation: 0,
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Direccions',
          )
        ]);
  }
}
