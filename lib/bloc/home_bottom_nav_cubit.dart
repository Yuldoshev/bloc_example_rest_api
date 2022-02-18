import 'package:bloc_app/presetation/ui/form_page.dart';
import 'package:bloc_app/presetation/widget/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomNavIndexBloc extends Cubit<int> {
  HomeBottomNavIndexBloc() : super(0);
  void changeBottomNavIndex(int nIndex) => emit(nIndex);

  List<Widget> pages = [
    const UserList(),
    const FormPage(),
  ];
}
