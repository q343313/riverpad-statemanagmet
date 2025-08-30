

import 'package:bloc/bloc.dart';
import 'package:riverpadstate/bloc/themebloc/themestates.dart';

class ThemeCubits extends Cubit<ThemeStates>{
  ThemeCubits():super(LightThemeStates());

  toggletheme(){
    if(state is LightThemeStates){
      emit(DarkThemeStates());
    }else{
      emit(LightThemeStates());
    }
  }
}