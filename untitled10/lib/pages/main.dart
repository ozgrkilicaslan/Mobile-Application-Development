import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled10/pages/words_card.dart';
import 'package:untitled10/pages/multiple_choice.dart'; // multiple_choice.dart'ı import et

import '../global_widget/app_bar.dart';
import 'lists.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

enum Lang { eng, tr }

class _MainPageState extends State<MainPage> {
  Lang? _chooseLang = Lang.eng;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset("assets/images/logo.png", height: 80),
                  Text("Quezy", style: TextStyle(fontFamily: "RobotoLight", fontSize: 16)),
                  Text("İstediğni Öğren", style: TextStyle(fontFamily: "RobotoLight", fontSize: 16)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.35, child: Divider(color: Colors.black)),
                  Container(
                      margin: EdgeInsets.only(top: 50, right: 8, left: 8),
                      child: Text("Ezberlerken Öğren, Öğrenirken Ezberle",
                          style: TextStyle(fontFamily: "RobotoLight", fontSize: 16), textAlign: TextAlign.center)),
                ],
              )
            ],
          ),
        ),
      ),
      appBar: appBar(
        context,
        left: const FaIcon(FontAwesomeIcons.bars, color: Colors.black, size: 20),
        center: Image.asset("assets/images/logo.png"),
        leftWidgetOnClick: () => _scaffoldkey.currentState!.openDrawer(),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                langRadioButton(
                  text: "İngilizce-Türkçe",
                  group: _chooseLang,
                  value: Lang.tr,
                ),
                langRadioButton(
                  text: "Türkçe-İngilizce",
                  group: _chooseLang,
                  value: Lang.eng,
                ),
                SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ListsPage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xFFDCA9B6), // İlk renk: #DCA9B6
                          Color(0xFFFFD3DE), // İkinci renk: #FFD3DE
                        ],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    child: Text(
                      "Listelerim",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Carter",
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MultipleChoicePage()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.37,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(0xFFFFD3DE),
                                Color(0xFFC4E1E4), // İkinci renk: #FFD3DE
                              ],
                              tileMode: TileMode.repeated,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/images/secmeli.png", // Resim yolunu kontrol edin
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const WordCardsPage()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 200,
                          width: MediaQuery.of(context).size.width * 0.37,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(0xFFFFD3DE),
                                Color(0xFFC4E1E4), // İkinci renk: #FFD3DE
                              ],
                              tileMode: TileMode.repeated,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/images/kelimekartları.png", // Resim yolunu kontrol edin
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // GIF'i ilk konumundan 10 piksel yukarı kaydırmak için margin kullanıyoruz
                Container(
                  child: Image.asset(
                    "assets/videos/anasayfa.gif",
                    width: 430,
                    height: 430,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox langRadioButton({
    required String? text,
    required Lang? value,
    required Lang? group,
  }) {
    return SizedBox(
      width: 250,
      height: 30,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text(
          text!,
          style: TextStyle(fontFamily: "carter", fontSize: 15),
        ),
        leading: Radio<Lang>(
          value: value!,
          groupValue: group,
          onChanged: (Lang? value) {
            setState(() {
              _chooseLang = value;
            });
          },
        ),
      ),
    );
  }
}
