import 'package:flutter/material.dart';
import 'dart:ui';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class StyleModel extends ChangeNotifier {
  StyleModel(this.context, {this.currentTheme});

  BuildContext context;
  Size size;
  Map<String, dynamic> contextSize;
  Map<String, Color> backgroundColor;
  Map<String, TextStyle> textStyle;
  String currentTheme;

  @override
  void notifyListeners() {
    getContextSize();
    getBackgroundColor();
    getContextSize();
  }

  //배경 색
  Map<String, dynamic> getBackgroundColor() {
    backgroundColor = {
      'backgroundColor1': hexToColor("#FFFFFF"),
      'backgroundColor2': hexToColor("#D0E1F5"),
      'backgroundColor3': hexToColor("#C0E4DA"),
      'backgroundColor4': hexToColor("#FEE893"),
      'backgroundColor5': hexToColor("#FAC8BF"),
      'backgroundColor6': hexToColor("#FEDCC1"),
      'homeBackgroundColor1': Colors.grey[150],
      'selectColor1': Colors.black12,
      'selectColor2': Colors.black.withOpacity(0.8),
    };
    return backgroundColor;
  }

  //텍스트 스타일
  Map<String, TextStyle> getTextStyle(
      {Color color, double fontSize, FontWeight fontWeight}) {
    size = MediaQuery.of(context).size;
    textStyle = {
      'titleTextStyle': TextStyle(
        fontSize: size.height * 0.032,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      'bodyTextStyle1': TextStyle(
        fontSize: size.height * 0.032,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w400,
      ),
      'infoTextStyle1': TextStyle(
          fontSize: size.height * 0.032,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w600,
          fontFamily: "NanumGothicBold"),
      'infoTextStyle2': TextStyle(
          fontSize: size.height * 0.04,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w800,
          fontFamily: "NanumGothicBold"),
      'infoTextStyle3': TextStyle(
        fontSize: size.height * 0.028,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w400,
      ),
      'infoTextStyle4': TextStyle(
        fontSize: size.height * 0.02,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w700,
      ),
      'infoTextStyle5': TextStyle(
        fontSize: size.height * 0.018,
        color: Colors.grey.shade600,
        fontWeight: FontWeight.w700,
      )
    };

    return textStyle;
  }

  // 화면 사이즈 지정
  Map<String, dynamic> getContextSize() {
    size = MediaQuery.of(context).size;

    contextSize = {
      'fullScreenHeight': size.height * 1,
      'screenHeightLevel1': size.height * 0.9,
      'screenHeightLevel2': size.height * 0.8,
      'screenHeightLevel3': size.height * 0.7,
      'screenHeightLevel4': size.height * 0.6,
      'screenHeightLevel5': size.height * 0.5,
      'screenHeightLevel6': size.height * 0.4,
      'screenHeightLevel7': size.height * 0.3,
      'screenHeightLevel7.5': size.height * 0.25,
      'screenHeightLevel8': size.height * 0.2,
      'screenHeightLevel8.5': size.height * 0.15,
      'screenHeightLevel9': size.height * 0.1,
      'screenHeightLevel10': size.height * 0.07,
      'screenHeightLevel11': size.height * 0.05,
      'screenHeightLevel12': size.height * 0.04,
      'screenHeightLevel13': size.height * 0.03,
      'screenHeightLevel14': size.height * 0.02,
      'screenHeightLevel15': size.height * 0.015,
      'fullScreenWidth': size.width * 1,
      'screenWidthLevel1': size.width * 0.9,
      'screenWidthLevel2': size.width * 0.8,
      'screenWidthLevel3': size.width * 0.7,
      'screenWidthLevel4': size.width * 0.6,
      'screenWidthLevel5': size.width * 0.5,
      'screenWidthLevel6': size.width * 0.4,
      'screenWidthLevel7': size.width * 0.3,
      'screenWidthLevel8': size.width * 0.2,
      'screenWidthLevel9': size.width * 0.1,
      'bigestIconSize': size.height * 0.05,
      'bigIconSize': size.height * 0.03,
      'middleIconSize': size.height * 0.02,
      'smallIconSize': size.height * 0.015,
      'smallFontSize': size.height * 0.015,
    };
    return contextSize;
  }
}
