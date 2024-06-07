import 'dart:async';
import 'package:flutter/material.dart';
import 'package:khu_meet/widgets/percent.dart';
import 'package:khu_meet/widgets/card.dart';
import 'landing_screen.dart';

class HomePage extends StatefulWidget {
  final Future<Map<String, dynamic>?> userInfo;
  final String univ;
  const HomePage({super.key, required this.userInfo, required this.univ});

  @override
  State<StatefulWidget> createState() {
    return _HomePageWidget();
  }
}

class _HomePageWidget extends State<HomePage> {
  Map<String, dynamic>? _user;
  PageController _pageController = PageController(viewportFraction: 0.8);

  final List<String> cardTexts = [
    '더 좋아하는\n동물은?',
    '더 좋아하는\n색깔은?',
    '더 좋아하는\n음식은?',
    '더 좋아하는\n음료는?',
    '더 좋아하는\n운동은?',
  ];

  final List<String> cardselections = [
    '강아지 vs 고양이',
    '빨강 vs 파랑',
    '피자 vs 햄버거',
    '커피 vs 차',
    '축구 vs 농구',
  ];

  String selectedOption = '';
  double selectedPercentage = 0.5;
  int num = 0;

  void handleSelectOption(String option) {
    setState(() {
      selectedOption = option;
      // 선택된 옵션에 따라 퍼센티지 설정
      selectedPercentage = (selectedOption == '강아지' || selectedOption == '빨강' ||
          selectedOption == '피자' || selectedOption == '커피' || selectedOption == '축구')
          ? 0.75
          : 0.25;
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "title",
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<Map<String, dynamic>?>(
          future: widget.userInfo,
          builder: (context, info) {
            if (info.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (info.hasError) {
              return Center(
                child: Text("error 발생"),
              );
            } else {
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
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.white, width: 2)),
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30, top: 60, right: 30, bottom: 5),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Landing()),
                          );
                        },
                        style: TextButton.styleFrom(),
                        child: Text(
                          "< ${widget.univ}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: cardTexts.length,
                        onPageChanged: (index){
                          setState(() {
                            num = index;
                            selectedPercentage = 0.5;
                          });
                        },// 카드의 총 개수
                        itemBuilder: (context, index) {
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1;
                              if (_pageController.position.haveDimensions) {
                                value = _pageController.page! - index;
                                value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                              }
                              return Transform.scale(
                                scale: value,
                                child: CardWidget(
                                  index: index,
                                  selection: cardselections[index],
                                  text: cardTexts[index],
                                  onSelect: handleSelectOption,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Text(
                            '당신과 취향이 비슷한 사람의 비율은?',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          PercentageBar(label: cardselections[num], percentage: selectedPercentage),
                          // SizedBox(height: 10),
                          // PercentageBar(label: '고양이', percentage: 0.25),
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
