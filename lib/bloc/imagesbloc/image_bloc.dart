import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:riverpadstate/repositor/imagerepository.dart';

part 'image_event.dart';
part 'image_state.dart';


class ImageBloc extends Bloc<ImageEvent,ImageStates>{
  final ImageRepository imageRepository;
  ImageBloc(this.imageRepository):super(ImageStates()){
    on<CameraCapture>(_addcamera);
    on<GalleryCapture>(_gallery);
    on<DeleteImages>(_deleteimages);
  }

  _addcamera(CameraCapture event,Emitter<ImageStates>emit)async{
    final image = await imageRepository.cameraimages();
    emit(state.copyWith(image: image));
  }

  _gallery(GalleryCapture event,Emitter<ImageStates>emit)async{
    final image = await imageRepository.galleryimages();
    emit(state.copyWith(image: image));
  }

  _deleteimages(DeleteImages event,Emitter<ImageStates>emit){
    emit(state.copyWith(image: null));
  }
}
