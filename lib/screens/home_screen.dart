import 'dart:async';
import 'package:flutter/material.dart';
import 'package:khu_meet/screens/chat_list_screen.dart';
import 'package:khu_meet/widgets/percent.dart';
import 'package:khu_meet/widgets/card.dart';
import 'landing_screen.dart';
import 'profile_screen.dart';
import 'match_people_screen.dart';
import '../models/questions.dart';
import '../models/options.dart';
import '../service/questions_api.dart';

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
  //취향 카드 정보 받아오기
  late Future<List<Question>> questions;
  late Future<List<Option>> options;
  late Future<List<dynamic>> optionSelect;
  String? selectedQuestionId;

  //카드 회전을 위한 변수 선언
  Map<String, dynamic>? _user; //로그인시 받아온 사용자 정보
  PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentIndex = 0; // 현재 페이지를 추적하기 위한 변수
  int _selectedIndex = 0; // BottomNavigationBar의 현재 선택된 인덱스

  String selectedOption = '';
  List<double?> selectedPercentages = []; // 변경된 부분

  @override
  void initState(){
    super.initState();
    questions = QuestionsApi().getQuestions();
    questions.then((questionList) {
      if (questionList.isNotEmpty) {
        selectedQuestionId = questionList[0].id;
        options = QuestionsApi().getOptions(selectedQuestionId!);
        optionSelect = QuestionsApi().getSelectionCountByQuestion(selectedQuestionId!);
      }
    });
  }

  void onQuestionSelected(String questionId){
    setState(() {
      selectedQuestionId = questionId;
      options = QuestionsApi().getOptions(questionId);
    });
  }

  // 각 옵션에 대한 응답 개수를 가져오는 함수
  Future<List<int>> getOptionResponseCounts(String questionId) async {
    try {
      List<dynamic> optionSelect = await QuestionsApi()
          .getSelectionCountByQuestion(questionId);
      print(optionSelect[0]);
      List<int> optionResponseCounts = [];

      if (optionSelect.length == 2) {
        for (dynamic option in optionSelect) {
          int responseCount = option['count'] ?? 0;
          optionResponseCounts.add(responseCount);
        }
      } else {
        // 질문 아이디에 해당하는 옵션 목록 가져오기
        List<Option> options = await QuestionsApi().getOptions(questionId);

        // 존재하는 선택지가 몇 번째 선택지인지 가져오기
        for (int i = 0; i < options.length; i++) {
          if (options[i].id == optionSelect[0]['option_id']) {
            for (int j = 0; j < 2; j++) {
              if (j == i) {
                optionResponseCounts.add(optionSelect[0]['count']);
              } else {
                optionResponseCounts.add(0);
              }
            }
          }
        }
      }
        return optionResponseCounts;
    } catch (e) {
      print("Error fetching option response counts: $e");
      return [];
    }
  }

  void handleSelectOption(String optionId) async {
    if(selectedOption == "") {
      await QuestionsApi().saveSelection(_user?["email"], selectedQuestionId!, optionId);
    }else{
      await QuestionsApi().updateSelection(_user?["email"], selectedQuestionId!, optionId);
    }
    setState(() {
      selectedOption = optionId;
    });
    List<int> responseCounts = await getOptionResponseCounts(selectedQuestionId!);
    print(responseCounts.length);
    if (responseCounts.length > 1) {
      int totalResponses = responseCounts.reduce((a, b) => a + b);
      List<double?> percentages = responseCounts.map((count) => count / totalResponses).toList();
      setState(() {
        selectedPercentages = percentages;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePageContent();
      case 1:
        return ChatListScreen();
      case 2:
        return ProfilePage();
      default:
        return _buildHomePageContent();
    }
  }

  Widget _buildHomePageContent() {
    return FutureBuilder<Map<String, dynamic>?>(
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
          return FutureBuilder<List<Question>>(
            future: questions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No questions available'));
              } else {
                final questions = snapshot.data!;
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
                          itemCount: questions.length, // 카드의 총 개수
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index; // 페이지 변경 시 현재 페이지 인덱스 업데이트
                              onQuestionSelected(questions[index].id);
                              selectedPercentages = [];
                              getOptionResponseCounts(questions[index].id);
                            });
                          },
                          itemBuilder: (context, index) {
                            return FutureBuilder<List<Option>>(
                              future: options,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Failed to load options'));
                                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                  return Center(child: Text('No options available'));
                                } else {
                                  List<Option> options = snapshot.data!;
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
                                          selection: options,
                                          text: questions[index].questionText,
                                          onSelect: handleSelectOption,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      if (selectedPercentages.isNotEmpty)
                        Container(
                          margin: EdgeInsets.all(20),
                          child: FutureBuilder<List<Option>>(
                            future: options,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Failed to load options'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text('No options available'));
                              } else {
                                List<Option> options = snapshot.data!;
                                return PercentageBar(
                                  label: options,
                                  percentages: selectedPercentages,
                                );
                              }
                            },
                          ),
                        ),
                      if(selectedPercentages.isEmpty)
                        Container(
                          margin: EdgeInsets.all(20),
                          child: FutureBuilder<List<Option>>(
                            future: options,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Failed to load options'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text('No options available'));
                              } else {
                                List<Option> options = snapshot.data!;
                                return PercentageBar(
                                  label: options,
                                  percentages: [null,null],
                                );
                              }
                            },
                          ),
                        ),
                      Container(
                        width: 370,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            onPressed: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MatchPeoplePage()),
                            );},
                          child: Text("취향 기반 이상형 찾으러 가기", style: TextStyle(
                            color: Colors.white
                          ),)),
                      )
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "title",
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: Container(
          height: 75,
          child: BottomNavigationBar(
            backgroundColor: Colors.black.withOpacity(0.9),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.blue,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white,), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat, color: Colors.white,), label: '채팅'),
              BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.white), label: '마이페이지'),
            ],
          ),
        ),
      ),
    );
  }
}
