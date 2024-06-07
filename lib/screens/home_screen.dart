import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khu_meet/screens/landing_screen.dart';

class HomePage extends StatefulWidget {
  final Future<Map<String, dynamic>?> userInfo;
  final String univ;
  const HomePage({super.key, required this.userInfo, required this.univ});

  @override
  State<StatefulWidget> createState() {
    return _HomePageWidget();
  }
}

class _HomePageWidget extends State<HomePage>{
  Map<String, dynamic>? _user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<Map<String, dynamic>?>(
          future: widget.userInfo,
          builder: (context, info){
            if(info.connectionState == ConnectionState.waiting){
              return Text("loading ...");
            } else if(info.hasError){
              return Center(
                child: Text("error 발생"),
              );
            }else{
              _user = info.data;
              print("_user : ${_user}");
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffA3BDED),
                      Color(0xff5A80B2),
                    ],
                  ),
                ),
                child: Column(
                  children: [Container(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.white, width: 2), ),
                    ),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 30, top: 40, right: 30, bottom: 5),
                    child: TextButton(onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Landing())
                      );
                    },
                        style: TextButton.styleFrom(
                        ),
                        child: Text("< ${widget.univ}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),)),
                  ),
                    Text(
                      '취향 카드',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: "title",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: PageView.builder(
                        itemCount: 5, // 카드의 총 개수
                        itemBuilder: (context, index) {
                          return CardWidget(index: index);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '당신과 취향이 비슷한 사람의 비율은?',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          PercentageBar(label: '강아지', percentage: 0.75),
                          SizedBox(height: 10),
                          PercentageBar(label: '고양이', percentage: 0.25),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
          ],
        ),
      ),
    );
  }
}


class PercentageBar extends StatelessWidget {
  final String label;
  final double percentage;

  PercentageBar({required this.label, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Text(
          '${(percentage * 100).toStringAsFixed(0)} %',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
