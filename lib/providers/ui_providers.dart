import 'package:flutter/material.dart';

//PASO 1: crear provider

class UIProvider extends ChangeNotifier{
  int _selectedMenuOpt = 1;
  //defino una variable que me determinará si se ha seleccionado alguna opcion del menu

  //defino sus getters y setters
  int get selectedMenuOpt{
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int index){
    this._selectedMenuOpt = index;
    notifyListeners(); //de forma que cuando haga un cambio en el valor de la variable se lo notifico a los listeners
  }
}
