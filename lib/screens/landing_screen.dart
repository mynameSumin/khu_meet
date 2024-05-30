import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khu_meet/screens/login_screen.dart';
import 'package:khu_meet/screens/school_certification_screen.dart';

class circlePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

    //큰하트 경로
    final path = Path();
    path.moveTo(size.width / 2, size.height / 4);
    path.cubicTo(
      3 * size.width / 3.7, 0,
      size.width, size.height / 2,
      size.width / 2, 3 * size.height / 3.5,
    );
    path.cubicTo(
      0, size.height / 2,
      size.width / 6, 0,
      size.width / 2, size.height / 4,
    );

    // 그림자 효과를 위한 약간의 위치 조정
    final shadowPath = Path.from(path);
    shadowPath.shift(Offset(-5, 5));

    // 그림자 그리기
    canvas.drawPath(shadowPath, shadowPaint);

    // 실제 하트 그리기
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Landing extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        body: Container (
          width: double.infinity,
          height: Size.infinite.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffDCD0FF),
                Color(0xffFAACA8)
              ],
            ),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 80, bottom: 20),
                padding: EdgeInsets.only(top: 20, bottom: 50),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white, width: 3), top: BorderSide(color: Colors.white, width: 3)),
                ),
                child: Text('" 경희의 \n    소개팅 "',
                  style: TextStyle(fontSize: 50, color: Colors.white, fontFamily: 'title',height: 2.3, letterSpacing: 7),),
              ),
              CustomPaint(
                painter: circlePainter(),
                size: Size(300,260),
                ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                minimumSize: Size(220, 50),
                textStyle: TextStyle(fontSize: 17,),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )
              ),
              child: Text("시작하기"),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login())
                );
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: Text("회원가입"),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SchoolCertificationPage())
                );
              },
            ),
            ],
          )
        )
    );
  }
}