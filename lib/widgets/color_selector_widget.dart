import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wiqr/helpers/kColors.dart';

class ColorSelectorWidget extends StatelessWidget {
  String value;
  String groupValue;
  Function onSelect;
  ColorSelectorWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicRadio(
      onChanged: (v) => onSelect(v),
      value: value,
      groupValue: groupValue,
      padding: EdgeInsets.all(10.h),
      style: NeumorphicRadioStyle(
        intensity: 0.6,
        boxShape: NeumorphicBoxShape.circle(),
        selectedDepth: -7,
        unselectedDepth: 7,
        selectedColor: KColor.primaryColor.withOpacity(0.7),
        unselectedColor: KColor.primaryColor.withOpacity(0.01),
      ),
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: HexColor(value),
        ),
      ),
    );
  }
}
