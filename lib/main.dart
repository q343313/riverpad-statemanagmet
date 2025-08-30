import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpadstate/bloc/imagesbloc/image_bloc.dart';
import 'package:riverpadstate/bloc/themebloc/themecubits.dart';
import 'package:riverpadstate/bloc/themebloc/themestates.dart';
import 'package:riverpadstate/config/domains/appthemes.dart';
import 'package:riverpadstate/data/databasesave.dart';
import 'package:riverpadstate/repositor/imagerepository.dart';
import 'package:riverpadstate/repositor/userrepositoroy.dart';
import 'package:riverpadstate/views/splashScreens.dart';

import 'firebase_options.dart';


GetIt getIt = GetIt.instance;
void main() async {
  injections();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubits()),
        BlocProvider(create: (_)=>ImageBloc(getIt()))
      ],
      child: BlocBuilder<ThemeCubits, ThemeStates>(
        builder: (context, state) {
          return ProviderScope(
            child: GetMaterialApp(
              title: "Riverpad",
              theme: state is LightThemeStates?AppThemes.lightthemedata:AppThemes.darkthemedata,
              home: Splashscreens(),
            ),
          );
        },
      ),
    );
  }

}

void injections(){
  getIt.registerLazySingleton<UserDataBase>(()=>UserDataBase());
  getIt.registerLazySingleton<ImageRepository>(()=>ImageRepository());
  getIt.registerLazySingleton<UserRepository>(()=>UserRepository());
}