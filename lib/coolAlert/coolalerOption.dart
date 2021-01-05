import 'package:flutter/widgets.dart';
import 'package:qtameen/cool/src/widgets/CoolAlert.dart';

class CoolAlertOptions {
  String title;
  String text;
  CoolAlertType type;
  CoolAlertAnimType animType;
  bool barrierDismissible = false;
  VoidCallback onConfirmBtnTap;
  VoidCallback onCancelBtnTap;
  String confirmBtnText;
  String cancelBtnText;
  Color confirmBtnColor;
  bool showCancelBtn;
  double borderRadius;
  Widget callWid;

  CoolAlertOptions({
    this.title,
    this.text,
    @required this.type,
    this.animType,
    this.barrierDismissible,
    this.onConfirmBtnTap,
    this.onCancelBtnTap,
    this.confirmBtnText,
    this.cancelBtnText,
    this.confirmBtnColor,
    this.callWid,
    this.showCancelBtn,
    this.borderRadius,
  });
}
