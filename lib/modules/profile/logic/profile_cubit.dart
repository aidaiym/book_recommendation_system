import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<int> {
  ProfileCubit() : super(0);

  void change(int v) => v != state ? emit(v) : {};
}
