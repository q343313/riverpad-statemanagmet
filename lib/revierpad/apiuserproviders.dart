



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/main.dart';
import 'package:riverpadstate/models/userapimodel.dart';
import 'package:riverpadstate/repositor/userrepositoroy.dart';

enum UserStates {loading,success,failure,initial}

final appuserprovider = StateNotifierProvider<UserApiNotifiy,UserApiStates>((val)=>UserApiNotifiy(getIt()));

class UserApiNotifiy extends StateNotifier<UserApiStates>{
  final UserRepository userRepository;
  UserApiNotifiy(this.userRepository):super(UserApiStates());

  getuserdata()async{

    state = state.copyWith(userStates: UserStates.loading);

    try{
      final data = await userRepository.getuserdata();
      state  = state.copyWith(userApiModel: data,userStates: UserStates.success,message: "Get USer data succesfully");
    }catch(e){
      state  = state.copyWith(userStates: UserStates.failure,message: e.toString());
    }


  }

}

class UserApiStates {
  final UserApiModel?userApiModel;
  final UserStates userStates;
  final String message;
  UserApiStates({
    this.userApiModel,
    this.userStates = UserStates.initial,
    this.message = ""
});

  UserApiStates copyWith({
    UserApiModel?userApiModel,
     UserStates?userStates,
    String?message
}){
    return UserApiStates(
      userApiModel: userApiModel??this.userApiModel,
      userStates: userStates??this.userStates,
      message: message??this.message
    );
  }

}