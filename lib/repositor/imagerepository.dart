


import 'package:image_picker/image_picker.dart';

class ImageRepository {

  final _picked = ImagePicker();

  Future<XFile?>galleryimages()async{
     XFile?imagepath = await _picked.pickImage(source: ImageSource.gallery,imageQuality: 80);
    return imagepath;
  }

  Future<XFile?>cameraimages()async{
     XFile?imagepath = await _picked.pickImage(source: ImageSource.camera,imageQuality: 80);
    return imagepath;
  }



}