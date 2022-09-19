import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
