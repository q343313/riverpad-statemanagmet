



import 'package:flutter_riverpod/flutter_riverpod.dart';

final bothrevierpade = StateProvider<AppStates>((val){
  return AppStates(showpassword: false, slider: 0.4);
});

class AppStates {
  final double slider;
  final bool showpassword;
  AppStates({required this.showpassword,required this.slider});

  AppStates copyWith({double?slider,bool?showpassword}){
    return AppStates(showpassword: showpassword??this.showpassword, slider: slider??this.slider);
  }
}