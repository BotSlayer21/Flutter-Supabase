import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_supabase_8040210115/home_page.dart';
import 'mahasiswa_form_page.dart';
import 'package:flutter_supabase_8040210115/mahasiswa_list_page.dart';
import 'package:flutter_supabase_8040210115/latihan_user_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_supabase_8040210115/mahasiswa_detail_page.dart';
import 'package:flutter_supabase_8040210115/mahasiswa_edit_page.dart';
import 'package:flutter_supabase_8040210115/register_page.dart';
import 'package:flutter_supabase_8040210115/login_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://dperqbzoyiovfdkqmctf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRwZXJxYnpveWlvdmZka3FtY3RmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwMzUyOTYsImV4cCI6MjAxODYxMTI5Nn0.Hj_bd2lwrZkP8AiLKJj-Yvv4wZPH-WAOhoIqH26g9MQ',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Supabase.instance.client.auth.currentUser == null
          ? LoginPage()
          : HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/mahasiswa-form': (context) => MahasiswaFormPage(),
        '/mahasiswa-list': (context) => MahasiswaListPage(),
        '/user-list': (context) => LatihanUserPage(),
        '/mahasiswa-detail': (context) => MahasiswaDetailPage(),
        '/mahasiswa-edit': (context) => MahasiswaEditPage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
