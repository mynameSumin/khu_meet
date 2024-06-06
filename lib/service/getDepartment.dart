import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class getDepartment extends StatefulWidget {
  final Function(bool) dataChanged;
  getDepartment({required this.dataChanged});
  @override
  _getDepartment createState() => _getDepartment();
}

class _getDepartment extends State<getDepartment> {
  Map<String, List<String>> department = {};
  String? selectCollege;
  String? selectDepart;
  List<String> dropdownItems = [];
  List<String> dropdownDepart = [];

  @override
  void initState(){
    super.initState();
    crawling();
  }

  void sendData(){
    widget.dataChanged(selectCollege != null && selectDepart != null);
  }
  void crawling() async {
    var uri = Uri.parse("https://www.khu.ac.kr/kor/user/contents/view.do?menuNo=200105");
    http.Response response = await http.get(uri);
    dom.Document? doc = parser.parse(response.body);

    //단과대 이름 찾기
    List<dom.Element>? elements = doc.querySelectorAll("tr");

    //단과대, 과 매칭
    for(var element in elements){
      for(var depart in element.querySelectorAll("a")){
        if(department.containsKey(element.querySelector("th")!.text)){
          department[element.querySelector("th")!.text]!.add(depart.text);
        }
        else{
          department[element.querySelector("th")!.text] = [depart.text];
        }
      }
    }

    setState(() {
      dropdownItems = department.keys.toList();
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 800,
            height: 900,
          child: dropdownItems.isEmpty?
          Text("로딩중")
          : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(10),
                  child: DropdownButton(
                    hint: Text("단과대", style: TextStyle(color: Colors.white),),
                    value: selectCollege,
                    dropdownColor: Colors.black.withOpacity(0.2),
                    onChanged: (String? value){
                      setState(() {
                        selectCollege = value!;
                        selectDepart = null;
                      });
                      sendData();
                    },
                    items: dropdownItems.sublist(1).map((e) => DropdownMenuItem(value: e,child: Text(e,
                      overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),))).toList(),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 10, left: 10),
                  child: DropdownButton(
                      hint: Text("학과", style: TextStyle(color: Colors.white),),
                      icon: (null),
                      value: selectDepart,
                      items: selectCollege == null ?
                      [] : department[selectCollege]!.sublist(1).toSet().map((e){
                        return DropdownMenuItem(value: e, child: Text(e,
                            overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),),);}).toList(),
                      isExpanded: false,
                      dropdownColor: Colors.black.withOpacity(0.3),
                      onChanged: (value){
                        setState(() {
                          selectDepart = value as String?;
                        });
                        sendData();
                      }),
                ),
              ],
            ),
          )

    );
   }
}
