
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/imagesbloc/image_bloc.dart';
import '../domains/appcolors.dart';

class Customimagewidget extends StatelessWidget {
  final String image;
  final  double radius;
  const Customimagewidget({super.key,this.image= "",this.radius = 60});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.black12,
          backgroundImage: image != null && image.isNotEmpty?FileImage(File(image)):null,
          child: image == null || image.isEmpty?
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined,color: Colors.white,),
              AutoSizeText(minFontSize: 12,maxFontSize: 15,"upload image",style: Theme.of(context).textTheme.titleSmall,)
            ],
          ):null,
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.scaffolddarkmode
                    : AppColors.scaffoldlightmode,
                child: Icon(Icons.camera_alt_outlined,color: Colors.white,)
            ))
      ],
    );
  }
}


Future<void>showimagedialog(BuildContext context){
  return showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: 180,
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.textfieldlightmode
                  : AppColors.textfieldlightmode,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              customlisttile(
                  icon: Icon(Icons.library_add),
                  callback: (){
                    Navigator.pop(context);
                    context.read<ImageBloc>().add(GalleryCapture());
                  },
                  title: "Gallery Capture",
                  context: context),
              customlisttile(
                  icon: Icon(Icons.camera_alt_outlined),
                  callback: (){
                    Navigator.pop(context);
                    context.read<ImageBloc>().add(CameraCapture());
                  },
                  title: "Camera Capture",
                  context: context),
              customlisttile(
                  icon: Icon(Icons.delete,color: Colors.red,),
                  callback: (){
                    Navigator.pop(context);
                    context.read<ImageBloc>().add(DeleteImages());
                  },
                  title: "Delete Image",
                  context: context)
            ],
          ),
        );
      });
}


Widget customlisttile({required Icon icon,required VoidCallback callback,required String title,required BuildContext context}){
  return ListTile(
    leading: icon,
    onTap: callback,
    title: AutoSizeText(title,maxFontSize: 22,minFontSize: 18,style: Theme.of(context).textTheme.bodyMedium,),
  );
}