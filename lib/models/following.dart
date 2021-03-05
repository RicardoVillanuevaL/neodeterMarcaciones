import 'package:flutter/cupertino.dart';

class Following extends ChangeNotifier{
  final List<Widget> _followingList = [];

  List<Widget> get followingList => followingList;

  clear(){
    _followingList.clear();
    notifyListeners();
  }

  add(Widget value){
    _followingList.add(value);
    notifyListeners();
  }

  remove(Widget value){
    _followingList.removeWhere((element) => element==value);
    notifyListeners();
  }

  selectall(){
    return _followingList;
  }
}