part of 'image_bloc.dart';


class ImageEvent extends Equatable{
  @override
  List<Object>get props => [];
}

class CameraCapture extends ImageEvent{}
class GalleryCapture extends ImageEvent{}
class DeleteImages extends ImageEvent{}
