import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MahasiswaEditPage extends StatefulWidget {
  const MahasiswaEditPage({Key? key}) : super(key: key);

  @override
  _MahasiswaEditPageState createState() => _MahasiswaEditPageState();
}

class _MahasiswaEditPageState extends State<MahasiswaEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  String? _selectedProgramStudi;
  final TextEditingController _tanggalLahirController = TextEditingController();
  DateTime? _selectedDate;
  // final TextEditingController _programStudiController = TextEditingController();
  // final TextEditingController _tanggalLahirController = TextEditingController();

  List<String> programStudiOptions = [
    "Sistem Informasi",
    "Teknik Informatika",
    "Sistem Komputer",
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != _selectedDate) {
      setState(() {
        _selectedDate = picked ?? DateTime.now();
        _tanggalLahirController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  void _simpanForm(context, id) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();
      // var url = Uri.parse('http://belajar-api.unama.ac.id/api/mahasiswa/$id');
      // String nama = _namaController.text;
      // int? nim = int.tryParse(_nimController.text);
      // String tanggalLahir = _tanggalLahirController.text;
      // String programStudi = _programStudiController.text;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text('Welcome $nama, $nim, $tanggalLahir, $programStudi')),
      // );
      var data = {
        'nama': _namaController.text,
        'nim': _nimController.text,
        'tanggal_lahir': _tanggalLahirController.text,
        'program_studi': _selectedProgramStudi ?? "",
      };
      try {
        final supabase = Supabase.instance.client;
        await supabase.from('mahasiswa').update(data).match({'id': id});
        EasyLoading.showSuccess('Data Berhasil Diupdate');
        Navigator.pop(context);
      } catch (e) {
        EasyLoading.showError('Ops there is something wrong$e');
      }
      EasyLoading.dismiss();
      // var response = await http.put(url, body: data, headers: {
      //   'Accept': 'application/json',
      // });
      // EasyLoading.dismiss();
      // if (response.statusCode == 200) {
      //   EasyLoading.showSuccess('Data berhasil disimpan');
      //   // Navigator.of(context).pushNamed('/mahasiswa-list');
      //   Navigator.pop(context);
      // } else {
      //   var responJson = jsonDecode(response.body);
      //   EasyLoading.showError(
      //       'Ooops... there is something wrong' + responJson['message']);
      // }
    }
  }

  var listProgramStudi = [];
  @override
  void initState() {
    super.initState();
    getProgramStudi();
  }

  void getProgramStudi() async {
    var data = await Supabase.instance.client.from('program_studi').select();
    setState(() {
      listProgramStudi = data;
    });
  }


  @override
  Widget build(BuildContext context) {
    final dataMhs = ModalRoute.of(context)!.settings.arguments as Map;
    _namaController.text = dataMhs['nama'];
    _nimController.text = dataMhs['nim'];
    _tanggalLahirController.text = dataMhs['tanggal_lahir'];
    _selectedProgramStudi = dataMhs['program_studi'];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Data Mahasiswa'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nimController,
                  decoration: InputDecoration(
                    labelText: 'NIM',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nim tidak boleh kosong';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Nim harus berupa angka';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _tanggalLahirController,
                      decoration: InputDecoration(
                        labelText: "Tanggal Lahir",
                      ),
                    ),
                  ),
                ),

                DropdownButton<String>(
                  value: _selectedProgramStudi,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedProgramStudi = newValue;
                    });
                  },
                  items: programStudiOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text("Pilih Program Studi"),
                ),

                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: () => _simpanForm(context, dataMhs['id']),
                    child: Text('Simpan'))
              ],
            ),
          ),
        ));
  }
}
