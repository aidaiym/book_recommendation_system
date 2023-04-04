import 'package:flutter_bloc/flutter_bloc.dart';

class BookCubit extends Cubit<int> {
  BookCubit() : super(0);

  void change(int v) => v != state ? emit(v) : {};
}
