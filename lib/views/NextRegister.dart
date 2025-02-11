// ignore_for_file: prefer_const_constructors, unused_element, avoid_print, duplicate_ignore, dead_code

import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appcare/models/textformfieldmodel.dart';
import 'package:flutter_appcare/views/page1.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../configs/config.dart';
import 'nextRegister.dart';

class NextRegister extends StatefulWidget {
  NextRegister({Key? key}) : super(key: key);

  @override
  State<NextRegister> createState() => _Register();
}

class _Register extends State<NextRegister> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController picdate = TextEditingController();
  TextEditingController pictime = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  DateTime? datenow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    void newDate() async {
      DateTime? date = await showDatePicker(
          context: context,
          initialDate: datenow!,
          firstDate: DateTime(DateTime.now().year - 70),
          lastDate: DateTime(DateTime.now().year, DateTime.now().day));
      // firstDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
      // lastDate: DateTime(DateTime.now().year, DateTime.now().month, 30),
      // );
      print(date);

      if (date != null) {
        setState(() {
          datenow = date;
          picdate.text = date.toString();
          picdate.text = DateFormat("dd/MM/yyyy").format(date);
        });
      }
    }

    void newtime() async {
      TimeOfDay? time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        setState(() {
          // picdate.text = date.toString();
          pictime.text = '${time.hour}:${time.minute}';
        });
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 63, 217, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Register',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill you Usename in the blank';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    print(value);
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'เบอร์โทรศัพท์',
                    labelStyle: TextStyle(color: Colors.white),
                    helperText: 'Tyep you Usename for display',
                    hintText: 'เบอร์โทรศัพท์',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 62, 144, 202)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                // TextFormFieldModel(
                //   // key: _formkey,
                //   labeltext: 'Usename',
                //   controller: username,
                //   // as: 'ใส่ส่ะ',
                //   // validator:(String value){},
                // ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password More 6 Charactor';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    print(value);
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'หมายเลขบัตรประชาชน',
                    labelStyle: TextStyle(color: Colors.white),
                    helperText: 'Tyep you password more 6 Charactor',
                    hintText: 'หมายเลขบัตรประชาชน',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 62, 144, 202)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                // TextFormFieldModel(
                //   labeltext: 'password',
                //   controller: password,
                // ),
                SizedBox(
                  height: 20,
                ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Confirm Password More 6 Charactor';
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      print(value);
                    },
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      labelText: 'confirm password',
                      labelStyle: TextStyle(color: Colors.white),
                      helperText: 'Tyep confirm password for display',
                      hintText: 'confirm password',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 62, 144, 202)),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    ),
                  ),
                // TextFormFieldModel(
                //   labeltext: 'confirm password',
                //   controller: confirmpassword,
                // ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill you name in the blank';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    print(value);
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'name',
                    labelStyle: TextStyle(color: Colors.white),
                    helperText: 'Tyep you name for display',
                    hintText: 'name',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 62, 144, 202)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                // TextFormFieldModel(
                //   labeltext: 'name',
                //   controller: name,
                // ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill you surname in the blank';
                    } else {
                      return null;
                    }
                  },
                  // controller: surname,
                  // readOnly: true,
                  // onTap: () {
                  //   // newDate();
                  // },
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    print(value);
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'surname',
                    labelStyle: TextStyle(color: Colors.white),
                    helperText: 'Tyep you surname for display',
                    hintText: 'surname',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 62, 144, 202)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),

                // TextFormFieldModel(
                //   labeltext: 'surname',
                //   controller: surname,
                // ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill you date in the blank';
                    } else {
                      return null;
                    }
                  },
                  controller: picdate,
                  readOnly: true,
                  onTap: () {
                    newDate();
                  },
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    print(value);
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'date',
                    labelStyle: TextStyle(color: Colors.white),
                    helperText: 'Tyep you date for display',
                    hintText: 'date',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 62, 144, 202)),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 206, 6, 6)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // TextFormField(
                //   controller: pictime,

                //   readOnly: true,
                //   onTap: () {
                //     newtime();
                //   },
                //   style: TextStyle(
                //       color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                //   keyboardType: TextInputType.text,
                //   onChanged: (value) {
                //     print(value);
                //   },
                //   // ignore: prefer_const_constructors
                //   decoration: InputDecoration(
                //     labelText: 'time',
                //     labelStyle: TextStyle(color: Colors.white),
                //     hintText: 'time',
                //     hintStyle:
                //         TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Color.fromARGB(255, 62, 144, 202)),
                //       borderRadius: BorderRadius.all(Radius.circular(50)),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //         borderSide:
                //             BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                //         borderRadius: BorderRadius.all(Radius.circular(50))),
                //   ),
                // ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState?.save();
                    }

                    // Navigator.push(
                    // context,
                    // MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => NextRegister()));
                    
                    print('สมัครสมาชิก');

                    await CheckRegister(username.text, password.text, name.text,
                        surname.text, picdate.text, context);

                    // Navigator.pushNamedAndRemoveUntil(context,
                    //     "/Page1", (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                        color: Color.fromARGB(255, 45, 134, 156),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    primary: Color.fromARGB(255, 255, 255, 255),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

Future CheckRegister(String username, String password, String name,
    String surname, String picdate, context) async {
  EasyLoading.show(status: 'loading...');

  Uri url = Uri.parse('http://165.22.63.114:3200/api/customer');
  http
      .post(
    url,
    headers: headers,
    body: jsonEncode({
      "username": username,
      "password": password,
      "fname": name,
      "lname": surname,
    }),
  )
      .then((req) async {
    if (req.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      var data = jsonDecode(req.body);
      prefs.setString('token', data['token']);

      print('ข้อมูลid');
      print(prefs.get('idm'));
      headers?['Authorization'] = "bearer ${data['token']}";
      EasyLoading.showSuccess('Great Success!');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Page1()),
          (Route<dynamic> route) => false);
      prefs.setInt('idm', data['id']);
    } else {
      print('error');
      EasyLoading.showError('Failed with Error');
    }
  });
}
