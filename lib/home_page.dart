import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        leadingWidth:250,
        leading: Container(
          margin: EdgeInsets.all(8),
          child: Row(
            children: [
              Image.asset(
                "images/logo.png",
                color : Colors.pink,
                colorBlendMode: BlendMode.modulate,
                ),
              Text(
                'Siakad Unama',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await Supabase.instance.client.auth.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  EasyLoading.showInfo("Oooopsss...$e");
                }
              },
              icon: Icon(Icons.logout_outlined)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'Selamat Datang, ${Supabase.instance.client.auth.currentUser!.email!}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mahasiswa-list');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(140, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.switch_account_rounded, size: 40),
                      Text('Data Mahasiswa'),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mahasiswa-form');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(160, 100),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_library_add, size: 40),
                      Text('Tambah Mahasiswa'),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user-list');
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(160, 100),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.my_library_add, size: 40),
                  Text('Data User'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
