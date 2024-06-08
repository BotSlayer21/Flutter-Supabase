import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
    
class LatihanUserPage extends StatefulWidget {
  const LatihanUserPage({Key? key}) : super(key: key);

  @override
  _LatihanUserPageState createState() => _LatihanUserPageState();
}

class _LatihanUserPageState extends State<LatihanUserPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  List listData = [];
  void getData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var respon = await http.get(url);
    var responJson = jsonDecode(respon.body);
    setState(() {
      listData = responJson;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data User'),
      ),
      body: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(),
            title: Text(listData[index]['name']),
            subtitle: Row(
              children: [
                Column(
                  //mengatur jarak antar widget
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(listData[index]["email"]),
                    Text(listData[index]["address"]["street"]),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}