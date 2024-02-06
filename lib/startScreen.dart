import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taskagitmakas/theme_data.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void dispose() {
    _textEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  String name = "";
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String isim = "";
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SwitchListTile(
            inactiveTrackColor: Colors.red.shade500,
            contentPadding: EdgeInsets.fromLTRB(mWidth * 0.65, 10, 0, 65),
            value: Provider.of<ThemeColorData>(
              context,
            ).isGreen,
            onChanged: (_) {
              Provider.of<ThemeColorData>(context, listen: false).toggleTheme();
            },
            title: Provider.of<ThemeColorData>(
              context,
            ).isGreen
                ? Text(
                    "Yeşil Tema:",
                    style: TextStyle(fontSize: mWidth * 0.03),
                  )
                : Text(
                    "Kırmızı Tema",
                    style: TextStyle(fontSize: mWidth * 0.03),
                  ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(mWidth * 0.3, 0, mWidth * 0.3, 0),
            height: mHeight * 0.075,
            child: TextFormField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Adınız',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                name == value;
                ;
              },
            ),
          ),
          Text(
            "Taş Kağıt Makas",
            style: TextStyle(fontSize: 25),
          ),
          Image.asset("images/TasKagitMakas.png"),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  name = _textEditingController.text;
                  Navigator.pushNamed(context, "/tas", arguments: name);
                },
                child: Text(
                  "Oyna",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(200, 40)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(color: Colors.red, width: 2))),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  "Çık",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(150, 40)),
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 62, 53, 192)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(
                              color: Color.fromARGB(255, 62, 53, 192),
                              width: 2))),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
