import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

/// 1. 로그아웃
/// 2. 개발자들
/// 3. 오픈소스 라이센스
/// 4. (보류) 알람 설정
class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: InkWell(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.yellow,
          ),
          onTap: () => Navigator.pushReplacementNamed(context, '/membership'),
        ),
      ),
    );
  }
}
