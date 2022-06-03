import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_appcare/configs/config.dart';
import 'package:flutter_appcare/views/carddetail.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sidemenu.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key, data}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  dynamic data;

  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    final prefs =
        await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
    int? idUser = prefs.getInt('idm');
    var item = await getdata(idUser);
    print(item?.first);
    setState(() {
      data = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 227, 227),
      appBar: AppBar(
        title: Text('รับงาน'),
        backgroundColor: Color.fromARGB(255, 160, 42, 207),
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: RefreshIndicator(
            onRefresh: () async {
              startApi();
            },
            child: ListView.builder(
              itemCount: data?.length ?? 0,
              itemBuilder: (context, i) => InkWell(
                // onTap: () => Navigator.pushNamed(context, "/CDT"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              Carddetail(data: data[i])));
                },
                child: Card(
                  elevation: 10,
                  color: Color.fromARGB(255, 229, 179, 249),
                  shadowColor: Color.fromARGB(255, 10, 91, 111),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 55.0,
                                height: 55.0,
                                // color: Color.fromARGB(255, 150, 217, 234),
                                // ignore: prefer_const_constructors
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 211, 211, 211),
                                  foregroundColor:
                                      Color.fromARGB(255, 211, 211, 211),
                                  // ignore: prefer_const_constructors
                                  // backgroundImage:
                                  //     AssetImage('assets/image/$i.jpeg'),

                                  // backgroundImage:
                                  //     NetworkImage('${data[i]['image']}'),
                                  // backgroundImage: NetworkImage(
                                  //     "https://obs.line-scdn.net/0ho7Hx9FjJMBh1ARpkc9xPT09XM3dGbSMbETdhGylvbiwKMSRPGm4vLVlVO3oNOXdGG297dlEAKylQNXFMSmEv/w644"),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.all(22),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data[i]['title']} ${data[i]['fname']} ${data[i]['lname']}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text('Rate/hr: ${data[i]['rate']}'),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      '${data[i]['phone']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ])
                      ]),
                ),
              ),
            ),
          )),
      drawer: SideMenu(),
    );
  }
}

Future<dynamic> getdata(dynamic idUser) async {
  Uri url = Uri.parse(
      'http://206.189.92.71:3200/api/booking/men/71/$idUser'); //server
  return await http
      .get(
    url,
    headers: headers,
  )
      .then((req) async {
    print(req.statusCode);
    if (req.statusCode == 200) {
      var data = jsonDecode(req.body);
      return data;
    } else {
      print('error');
      return null;
    }
  });
}
