


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreproviders = StreamProvider((val)async*{

  final referance =await FirebaseFirestore.instance.collection("notifications");
  yield referance.snapshots();
});

final changeproviders = StateProvider.family<int,int>((val,number){
  return number * 10;
});