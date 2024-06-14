import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../resources/index.dart';

mixin CheckInternetConnectionMixin {
  Future<bool?> showInternetConnectionBottomSheet(Size size) async {
    return Fluttertoast.showToast(
        msg: 'No Internet Connection',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.red,
        textColor: ColorManager.white,
        fontSize: AppSize.s16);
  }
}
