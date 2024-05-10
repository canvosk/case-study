import 'package:get_it/get_it.dart';
import 'package:study_case/app/viewmodel/firebase_viewmodel.dart';
import 'package:study_case/app/viewmodel/movies_viewmodel.dart';
import 'package:study_case/core/constants/api_strings.dart';
import 'package:study_case/core/services/firebase_services.dart';
import 'package:study_case/core/services/movie_services.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies

  sl.registerSingleton<ApiStrings>(ApiStrings());
  sl.registerSingleton<FirebaseServices>(FirebaseServices());

  sl.registerSingleton<MovieServices>(MovieServices(sl(), sl()));

  sl.registerSingleton<MovieViewModel>(MovieViewModel(sl(), sl()));
  sl.registerSingleton<FirebaseViewModel>(FirebaseViewModel(sl()));
}
