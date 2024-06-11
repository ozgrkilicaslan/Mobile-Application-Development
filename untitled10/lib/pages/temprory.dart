import 'package:flutter/material.dart';
import 'main.dart';

class TemproryPage extends StatefulWidget {
  const TemproryPage({super.key});

  @override
  _TemproryPageState createState() => _TemproryPageState();
}

class _TemproryPageState extends State<TemproryPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset("assets/images/logo.png"),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Quezy",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Luck",
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Ezberlerken Öğren",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Carter",
                    fontSize: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
