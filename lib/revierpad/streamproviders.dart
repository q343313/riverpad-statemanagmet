


import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamproviders = StreamProvider((val)async*{
  var val = Random().nextDouble();
  while (true){
    await Future.delayed(Duration(seconds: 3),(){
      val += Random().nextDouble() + 4 * 2;
    });
    yield double.parse(val.toStringAsFixed(2));
  }
});