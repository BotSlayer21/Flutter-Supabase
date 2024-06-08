import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(context) async {
    if (_formKey.currentState!.validate()) {
      final supabase = Supabase.instance.client;
      try {
        await supabase.auth.signInWithPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        EasyLoading.dismiss();
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        EasyLoading.showInfo("Ooops....$e");
      }
      // EasyLoading.show();
      // var url = Uri.parse('http://belajar-api.unama.ac.id/api/login');
      // var data = {
      //   'email': _emailController.text,
      //   'password': _passwordController.text,
      // };
      // var response = await http.post(url, body: data, headers: {
      //   'Accept': 'application/json',
      // });
      // EasyLoading.dismiss();
      // if (response.statusCode == 200) {
      //   Navigator.pushReplacementNamed(context, '/home');
      //   // EasyLoading.showSuccess("Login Berhasil");
      // } else {
      //   var responJson = jsonDecode(response.body);
      //   EasyLoading.showError("Opsss...${responJson['message']}");
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LOGIN'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text("Login"),
                SizedBox(height: 20),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Masukkan Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Masukkan Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => login(context),
                          child: Text('L O G I N'),
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(double.maxFinite, 50)),
                        ),
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('atau'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text('Klik Untuk Register'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
  }
}
