import 'package:flutter/material.dart';

class MahasiswaDetailPage extends StatefulWidget {
  const MahasiswaDetailPage({Key? key}) : super(key: key);

  @override
  _MahasiswaDetailPageState createState() => _MahasiswaDetailPageState();
}

class _MahasiswaDetailPageState extends State<MahasiswaDetailPage> {
  @override
  Widget build(BuildContext context) {
    final dataMhs = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(dataMhs['nama']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(dataMhs['foto']),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NIM : ' + dataMhs['nim']),
                Text('Nama : ' + dataMhs['nama']),
                Text('Tanggal Lahir : ' + dataMhs['tanggal_lahir']),
                Text('Program Studi : ' + dataMhs['program_studi']),
              ],
            ),
          )
        ],
      )
    );
  }
}
