import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  Future<void> SignUpUser(
      {required String emailData, required String passwordData}) async {
    try {
      emit(SignupLoading());
      
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailData,
        password: passwordData,
      );
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailure(errMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailure(errMessage: 'email-already-in-use'));
      }
    } catch (e) {
      emit(SignupFailure(errMessage: e.toString()));
    }
  }
}
