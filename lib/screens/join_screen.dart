import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khu_meet/screens/join_complete_screen.dart';
import 'package:khu_meet/screens/landing_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import "package:khu_meet/service/user.dart";

class JoinPage extends StatefulWidget {
  final String email;
  final String univ;
  final String mbti;
  final int studentId;
  final String college;
  final String depart;

  const JoinPage({
    required this.email,
    required this.univ,
    required this.mbti,
    required this.studentId,
    required this.college,
    required this.depart,
  });

  @override
  State<StatefulWidget> createState() {
    return _JoinPageWidget();
  }
}

class _JoinPageWidget extends State<JoinPage> {
  String? introduction;
  String? name;
  final _formKey1 = GlobalKey<FormState>();
  // 이미지 업로드 위한 변수들
  final picker = ImagePicker();
  List<XFile?> images = []; // 가져온 사진들 보여주기

  void printInfo() {
    print(widget.email);
    print(widget.univ);
    print(widget.mbti);
    print(widget.studentId);
    print(widget.college);
    print(widget.depart);
  }

  @override
  void initState() {
    super.initState();
    loadImageFromAssets();
    printInfo();
  }

  Future<void> loadImageFromAssets() async {
    try {
      final ByteData byteData = await rootBundle.load('assets/images/cat.jpeg');
      final String tempDirPath = '${Directory.systemTemp.path}/images';
      final Directory tempDir = Directory(tempDirPath);
      if (!tempDir.existsSync()) {
        tempDir.createSync(recursive: true);
      }
      final File imageFile = File('$tempDirPath/cat.jpeg');
      await imageFile.writeAsBytes(byteData.buffer.asUint8List());
      setState(() {
        images.add(XFile(imageFile.path)); // XFile 형식으로 변환하여 추가
      });
    } catch (e) {
      print("Error loading image from assets: $e");
    }
  }

  Future<void> sendUserData() async {
    if (_formKey1.currentState!.validate() && images.isNotEmpty) {
      _formKey1.currentState!.save();

      if(images.isEmpty)
        print("이미지 없음");
      List<String> imagePaths = images.map((image) => image!.path).toList();

      User user = User(
        widget.univ,
        widget.email,
        widget.college,
        widget.depart,
        widget.studentId,
        name!,
        introduction!,
        widget.mbti,
        imagePaths,
      );

      await sendUser(user);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinCompletePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffDCD0FF),
                  Color(0xffFAACA8),
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.white, width: 2)),
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 30, top: 40, right: 30, bottom: 5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Landing()),
                      );
                    },
                    style: TextButton.styleFrom(),
                    child: Text("< home",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 40),
                  child: Text("사용자에 대해\n알려주세요",
                    style: TextStyle(fontSize: 45, fontFamily: 'title', height: 1.5, color: Colors.white),
                  ),
                ),
                // 인증 폼
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Form(
                    key: _formKey1,
                    child: Column(
                      children: [
                        // 자기 소개
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10, 30, 0, 10),
                          child: Text("나의 소개", style: TextStyle(
                            fontSize: 20, fontFamily: "title", color: Colors.white,
                          )),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.2),
                              contentPadding: EdgeInsets.fromLTRB(15, 30, 10, 0),
                              hintText: "이름을 적어주세요",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "이름을 입력해주세요";
                              } else {
                                name = value;
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              name = value;
                            },
                          ),
                        ),
                        // 자기 소개 작성
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          maxLines: 3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.2),
                            contentPadding: EdgeInsets.fromLTRB(15, 30, 10, 0),
                            hintText: "자기 소개를 작성해주세요 (50자 이상)",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "자기소개를 입력해주세요";
                            } else {
                              introduction = value;
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            introduction = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(40, 30, 0, 10),
                  child: Text("사진 (최소 1장)", style: TextStyle(
                    fontSize: 20, fontFamily: "title", color: Colors.white,
                  )),
                ),
                // 카메라로 촬영하기
                Container(
                  margin: EdgeInsets.only(bottom: 0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 10, bottom: 0),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.5, blurRadius: 5),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () async {
                            XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 30);
                            if (image != null) {
                              setState(() {
                                images.add(image);
                              });
                            }
                          },
                          icon: Icon(Icons.add_a_photo, size: 30, color: Colors.white),
                        ),
                      ),
                      // 갤러리에서 가져오기
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.5, blurRadius: 5)],
                        ),
                        child: IconButton(
                          onPressed: () async {
                            List<XFile?> multiImage = await picker.pickMultiImage();
                            setState(() {
                              images.addAll(multiImage);
                            });
                          },
                          icon: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.all(10),
                      child: GridView.builder(
                        padding: EdgeInsets.all(0),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: images.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1 / 1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(images[index]!.path)),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: InkWell(
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: sendUserData,
                    child: Text("완료", style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
