import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_case/core/services/firebase_services.dart';

class FirebaseViewModel extends Cubit<bool> {
  final FirebaseServices _firebaseServices;

  FirebaseViewModel(this._firebaseServices) : super(false);

  Future logEvent() async {
    _firebaseServices.logEvent();
  }
}
