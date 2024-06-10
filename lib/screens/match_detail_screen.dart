import 'package:flutter/material.dart';
import 'chat_screen.dart';

class DetailPage extends StatefulWidget {
  Map<String,String> card;

  DetailPage({required this.card});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int photoClicks = 0;
  int nameClicks = 0;
  int mbtiClicks = 0;
  int introClicks = 0;


  @override
  Widget build(BuildContext context) {
    int totalClicks = photoClicks + nameClicks + mbtiClicks + introClicks;

    return Scaffold(
      appBar: AppBar(
        title: Text('경희대학교'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '* 하루 한 번씩 주어지는 코인 세 개로 확인 가능해요!',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  photoClicks++;
                });
              },
              child: Container(
                color: Colors.grey[300],
                height: 200,
                width: double.infinity,
                child: Center(
                  child: photoClicks >= 3 ?  Image.asset(
                    'assets/images/cat.jpeg',
                    fit: BoxFit.cover,
                    height: 150,
                    width: 250,
                  ): Text('사진은 코인 3개가 필요해요'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.card['department']!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  nameClicks++;
                });
              },
              child: Text(
                '이름: ${nameClicks >= 3 ? '${widget.card["name"]}' : '이름은 코인 3개가 필요해요'}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  mbtiClicks++;
                });
              },
              child: Text(
                'MBTI: ${mbtiClicks >= 1 ? '${widget.card['mbti']}' : 'MBTI는 코인 1개가 필요해요'}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  introClicks++;
                });
              },
              child: Container(
                color: Colors.grey[300],
                height: 100,
                width: double.infinity,
                child: Center(
                  child: Text(introClicks >= 2 ? '${widget.card['introduction']}' : '자기소개는 코인 2개가 필요해요'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: totalClicks >= 6
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(user: widget.card)
                    ),
                  );
                }
                    : null,
                child: Text('채팅 시작'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: totalClicks >= 6 ? Colors.white : Colors.grey, // 버튼 색상 변경
              ),
            ),
            )],
        ),
      ),
    );
  }
}
