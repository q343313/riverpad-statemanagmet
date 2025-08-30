part of 'image_bloc.dart';



class ImageStates extends Equatable{
  final XFile?imagepath;
  ImageStates({
    this.imagepath
});

  ImageStates copyWith({XFile?image}){
    return ImageStates(imagepath: image);
  }

  @override
  List<Object?>get props => [imagepath];
}
