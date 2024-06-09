import 'package:flutter/material.dart';
import 'match_detail_screen.dart';

class MatchPeoplePage extends StatelessWidget {
  final VoidCallback onBack;
  MatchPeoplePage({required this.onBack});

  final List<Map<String, String>> cards = [
    {'title': '컴퓨터공학과 xx학번', 'department': '컴퓨터공학과', 'year': 'xx학번', 'image': 'assets/images/cat.jpeg'},
    {'title': '국제학과 xx학번', 'department': '국제학과', 'year': 'xx학번', 'image': 'assets/images/cat.jpeg'},
    {'title': '연극영화학과 xx학번', 'department': '연극영화학과', 'year': 'xx학번', 'image': 'assets/images/cat.jpeg'},
    {'title': '국제학과 xx학번', 'department': '국제학과', 'year': 'xx학번', 'image': 'assets/images/cat.jpeg'},
  ];

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
                  onBack();
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
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(card: cards[index]),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Image.asset(
                            cards[index]['image']!,
                            fit: BoxFit.cover,
                            height: 150,
                            width: 250,
                          ),
                          ListTile(
                            title: Text(cards[index]['title']!),
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
