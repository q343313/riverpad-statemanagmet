


import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchprovider = StateNotifierProvider<SearchNotifier,SearchStates>((val)=>SearchNotifier());

class SearchNotifier extends StateNotifier<SearchStates>{
  SearchNotifier():super(SearchStates(search: "",password: "",counter: 0,showpassword: false));
  void search(String value){
    state = state.copyWith(search: value);
  }

  void password(String password){
    state = state.copyWith(password: password);
  }

  increamentvalue(){
    state = state.copyWith(counter: state.counter +1);
  }

  decreamentvalue(){
    state = state.copyWith(counter:  state.counter -1);
  }

  showpassword(){
    state = state.copyWith(showpassword: !state.showpassword);
  }
}


class SearchStates {
  final String search;
  final String password;
  final bool showpassword;
  final int counter;
  SearchStates({required this.search,required this.password,required this.counter,required this.showpassword});
  SearchStates copyWith({String? search,String?password,int?counter,bool?showpassword}){
    return SearchStates(search: search??this.search,password: password??this.password,counter: counter??this.counter,showpassword: showpassword??this.showpassword);
  }
}