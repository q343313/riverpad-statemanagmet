


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/models/studentmodel.dart';
import 'package:riverpadstate/models/usermodels.dart';
import 'package:riverpadstate/repositor/userrepositoroy.dart';

// final futureproviders  = FutureProvider((ref)async{
//   await Future.delayed(Duration(seconds: 8));
//   return 0;
// });

final futureproviders  = FutureProvider((ref)async{
  final UserRepository userRepository =UserRepository();
  final userdata  = await userRepository.getuserdata();
  return userdata;
});


final studentproviders = FutureProvider((ref)async{
  final UserRepository userRepository  = UserRepository();
  List<StudentModel>studentdata = await userRepository.getstudentdata();
  return studentdata;
});