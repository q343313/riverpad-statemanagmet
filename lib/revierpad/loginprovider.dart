


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpadstate/main.dart';
import 'package:riverpadstate/repositor/userrepositoroy.dart';

enum AccountStates {loading,success,failure,initial}
final loginproviders  = StateNotifierProvider<LoginNotifiers,LoginStates>((user)=>LoginNotifiers(getIt()));

class LoginNotifiers extends StateNotifier<LoginStates>{
  final UserRepository userRepository;
  LoginNotifiers(this.userRepository):super(LoginStates());

  addemail(String email){
    state = state.copyWith(email: email);
  }

  addpassword(String password){
    state = state.copyWith(passwrod: password);
  }

  loginuser()async{
    state= state.copyWith(accountStates: AccountStates.loading);
    try{
      final token = await userRepository.loginuseraccount(state.email, state.passwrod);
      state = state.copyWith(token: token["token"].toString(),accountStates: AccountStates.success,);
    }catch(e){
      state = state.copyWith(accountStates: AccountStates.failure,token: "User Login Failed");
    }
  }

  resetstates(){
    state = state.copyWith(token: "",accountStates: AccountStates.initial,email: "",passwrod: "");
  }

}

class LoginStates{
  final String email;
  final String passwrod;
  final AccountStates accountStates;
  final String token;
  LoginStates({
    this.accountStates = AccountStates.initial,
    this.email = "",
    this.token = "",
    this.passwrod = ""
});

  LoginStates copyWith({
    String?email,
     String?passwrod,
     AccountStates?accountStates,
     String?token
}){
    return LoginStates(
      email: email??this.email,
      passwrod: passwrod??this.passwrod,
      token: token??this.token,
      accountStates: accountStates??this.accountStates
    );
  }
}

