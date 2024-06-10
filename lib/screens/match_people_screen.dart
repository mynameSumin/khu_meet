import 'package:flutter/material.dart';
import 'match_detail_screen.dart';
import '../service/user_api.dart';

class MatchPeoplePage extends StatefulWidget {
  final VoidCallback onBack;

  MatchPeoplePage({required this.onBack});

  @override
  State<StatefulWidget> createState() {
    return _MatchPeopleWidget();
  }
}

class _MatchPeopleWidget extends State<MatchPeoplePage> {
  final List<Map<String, String>> cards = [];
  List<User> users = [];
  bool isLoading = true; // 데이터를 가져오는 중인지 여부를 나타내는 변수

  void getUsers() async {
    users = await fetchUsersFromSameSchool('경희대학교');
    users.forEach((user) {
      print(user.mbti);
      cards.add({"department": "${user.department}", "mbti":"${user.mbti}","introduction":"${user.introduction}","email":"${user.email}","studentId": "${user.studentId}", "name": "${user.name}", "image": "assets/images/cat.jpeg"});
    });

    setState(() {
      isLoading = false; // 데이터를 가져온 후에 isLoading을 false로 설정하여 로딩이 완료되었음을 알림
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  widget.onBack();
                },
                style: TextButton.styleFrom(),
                child: Text(
                  "< 뒤로가기",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              child: Text(
                '당신과 취향이\n   비슷해요!',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: "title",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: isLoading // isLoading이 true이면 로딩 중임을 나타내는 화면을 표시
                  ? Center(child: CircularProgressIndicator()) // 로딩 중이면 프로그레스 바를 표시
                  : ListView.builder(
                itemCount: cards.length - 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            card: cards[index + 1],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Image.asset(
                            cards[index + 1]['image']!,
                            fit: BoxFit.cover,
                            height: 150,
                            width: 250,
                          ),
                          ListTile(
                            title: Text(cards[index + 1]['department']!),
                            subtitle: Text(cards[index + 1]['name']!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
