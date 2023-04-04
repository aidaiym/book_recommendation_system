import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<int> {
  AdminCubit() : super(0);

  void change(int v) => v != state ? emit(v) : {};
}
