import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taskagitmakas/theme_data.dart';

class TasKagitMakas extends StatefulWidget {
  const TasKagitMakas({super.key});

  @override
  State<TasKagitMakas> createState() => _TasKagitMakasState();
}

class _TasKagitMakasState extends State<TasKagitMakas>
    with SingleTickerProviderStateMixin {
  String ad = "Arif";
  String randomEleman = "Taş";
  int life = 3;
  int lifeSlider = 3;
  int Point = 0;
  String selectedElement = "Taş";
  String durum = "";

  Map<String, String> imageMap = {
    "Taş": 'images/tas.png',
    "Kağıt": 'images/kagit.png',
    "Makas": 'images/makas.png',
  };
  void Randomm() {
    List<String> liste = ['Taş', 'Kağıt', 'Makas'];
    Random random = Random();
    int index = random.nextInt(liste.length);
    randomEleman = liste[index];
  }

  int currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 3).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? name = ModalRoute.of(context)!.settings.arguments as String?;

    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tas Kagit Makas"),
        actions: [
          IconButton(
            onPressed: () {
              showDialogg(context);
            },
            icon: Icon(Icons.menu),
          )
        ],
      ),
      body: Stack(children: [
        SwitchListTile(
          inactiveTrackColor: Colors.red.shade500,
          contentPadding: EdgeInsets.fromLTRB(mWidth * 0.65, 10, 0, 100),
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
        SizedBox(
          width: mWidth * 0.6,
        ),
        Column(
          children: [
            SizedBox(
              height: mHeight * 0.4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Puan: $Point", style: const TextStyle(fontSize: 20)),
                    Text(" $durum", style: const TextStyle(fontSize: 20)),
                  ],
                ),
                Text("Can: $life", style: const TextStyle(fontSize: 20))
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(children: [
              const Text(
                "Mr. Robot",
                style: TextStyle(fontSize: 20),
              ),
              Transform.rotate(
                angle: 3.1,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 1500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    imageMap[randomEleman]!,
                    key: ValueKey<String>(imageMap[randomEleman]!),
                    height: mHeight * 0.20,
                    width: mWidth * 0.40,
                  ),
                ),
              ),
              SizedBox(
                height: mHeight * 0.28,
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Image.asset(
                  imageMap[selectedElement]!,
                  key: ValueKey<String>(imageMap[selectedElement]!),
                  height: mHeight * 0.20,
                  width: mWidth * 0.40,
                ),
              ),
              Text(
                "${name == "" ? "Human" : name}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: mHeight * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: mHeight * 0.015,
                              horizontal: mWidth * 0.05)),
                      onPressed: () {
                        setState(() {
                          Randomm();
                          selectedElement = "Taş";
                          PointandHeal();
                        });
                      },
                      child: const Text("Taş")),
                  SizedBox(
                    width: mWidth * 0.1,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: mHeight * 0.015,
                            horizontal: mWidth * 0.05)),
                    onPressed: () {
                      setState(() {
                        Randomm();
                        selectedElement = "Kağıt";
                        PointandHeal();
                      });
                    },
                    child: const Text("Kağıt"),
                  ),
                  SizedBox(
                    width: mWidth * 0.1,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: mHeight * 0.015,
                            horizontal: mWidth * 0.05)),
                    onPressed: () {
                      setState(() {
                        Randomm();
                        selectedElement = "Makas";
                        PointandHeal();
                      });
                    },
                    child: const Text("Makas"),
                  ),
                ],
              )
            ]),
          ],
        ),
      ]),
    );
  }

  Future<dynamic> showDialogg(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Text("Can"),
                  Slider(
                    value: lifeSlider.toDouble(),
                    min: 3,
                    max: 5,
                    onChanged: (newValue) {
                      setState(() {
                        lifeSlider = newValue.round();
                      });
                    },
                  ),
                  Text(lifeSlider.toString()),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState() {
                      life = lifeSlider;
                    }

                    Navigator.of(context).pop();
                  },
                  child: Text("Geri Dön"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void PointandHeal() {
    if (life != 0) {
      if (randomEleman == selectedElement) {
        setState(() {
          durum = "Berabere";
        });
      } else if (randomEleman == "Taş" && selectedElement == "Kağıt") {
        //taş kağıt
        setState(() {
          durum = "Kazandın";
          Point += 10;
        });
      } else if (randomEleman == "Taş" && selectedElement == "Makas") {
        //taş makas
        setState(() {
          durum = "Kaybettin";
          life -= 1;
        });
      } else if (randomEleman == "Kağıt" && selectedElement == "Taş") {
        //kağıt taş
        setState(() {
          durum = "Kaybettin";
          life -= 1;
        });
      } else if (randomEleman == "Kağıt" && selectedElement == "Makas") {
        //kağıt makas
        setState(() {
          durum = "Kazandın";
          Point += 10;
        });
      } else if (randomEleman == "Makas" && selectedElement == "Taş") {
        //makas taş
        setState(() {
          durum = "Kazandın";
          Point += 10;
        });
      } else if (randomEleman == "Makas" && selectedElement == "Kağıt") {
        //makas kağıt
        setState(() {
          durum = "Kaybettin";
          life -= 1;
        });
      } else {}
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Canınız Kalmadı"),
              content: Text("Puanınız= $Point"),
              actions: [
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.of(context).pop();
                      life = lifeSlider;
                      Point = 0;
                    },
                    child: Text("Tekrar Oyna")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      SystemNavigator.pop();
                    },
                    child: Text("Çıkış Yap"))
              ],
            );
          });
    }
  }
}
