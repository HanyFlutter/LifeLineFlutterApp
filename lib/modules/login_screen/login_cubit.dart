import 'package:bloc/bloc.dart';

import 'login_states.dart';
 bool _showPassword=true;
class LoginCubit extends Cubit<LoginStates>{

  LoginCubit(super.initialState);
  void toggelEye(){
    _showPassword=!_showPassword;
    emit(ShowPasswordState());

  }
}