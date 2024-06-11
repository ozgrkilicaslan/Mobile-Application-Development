import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled10/global_widget/toast.dart';
import 'package:untitled10/pages/add_word.dart';

import '../db/db/db.dart';
import '../db/models/words.dart';
import '../global_widget/app_bar.dart';

class WordsPage extends StatefulWidget {
  final int? listID;
  final String? listName;
  const WordsPage(this.listID, this.listName, {Key? key}) : super(key: key);

  @override
  State<WordsPage> createState() =>
      _WordsPageState(listID: listID, listName: listName);
}

class _WordsPageState extends State<WordsPage> {
  int? listID;
  String? listName;
  _WordsPageState({@required this.listID, @required this.listName});
  List<Word> _wordList = [];

  bool pressController = false;
  List<bool> deleteIndexList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(listID.toString() + " " + listName!);
    getWordByList();
  }

  void getWordByList() async {
    _wordList = await DB.instance.readWordByList(listID);
    for (int i = 0; i < _wordList.length; ++i)
      deleteIndexList.add(false);
    setState(() => _wordList);
  }

  void delete() async {
    List<int> removeIndexList = [];

    // Silinecek öğelerin indekslerini toplamak
    for (int i = 0; i < deleteIndexList.length; ++i) {
      if (deleteIndexList[i] == true) {
        removeIndexList.add(i);
      }
    }

    // Silme işlemini tersten yapmak
    for (int i = removeIndexList.length - 1; i >= 0; --i) {
      DB.instance.deleteWord(_wordList[removeIndexList[i]].id!);
      _wordList.removeAt(removeIndexList[i]);
      deleteIndexList.removeAt(removeIndexList[i]);
    }

    setState(() {
      _wordList;
      deleteIndexList;
      pressController = false;
    });
    toastMessage("Seçili kelimeler silindi.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        left: pressController != true
            ? const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22)
            : InkWell(
          onTap: delete,
          child: Icon(Icons.delete, color: Colors.orangeAccent, size: 24),
        ),
        center: Text(listName!,
            style: TextStyle(
                fontFamily: "carter", fontSize: 22, color: Colors.black)),
        leftWidgetOnClick: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return wordItem(
              _wordList[index].id!,
              index,
              word_eng: _wordList[index].word_eng,
              word_tr: _wordList[index].word_tr,
              status: _wordList[index].status!,
            );
          }, itemCount: _wordList.length,
        ),),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (Context) =>  AddWordPage(listID, listName))).then((value){
             getWordByList();
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Color(0xFFFFC4E1E4), // Buton rengini güncelledik
        ),
    );
  }

  InkWell wordItem(int wordId, int index,
      {@required String? word_tr,
        @required String? word_eng,
        @required bool? status}) {
    return InkWell(
      onLongPress: () {
        setState(() {
          pressController = true;
          deleteIndexList[index] = true;
        });
      },
      child: Center(
        child: Container(
          width: double.infinity,
          child: Card(
            color: Color(0xFFFFD3DE), // Kart rengini güncelledik
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.only(
                left: 10, right: 10, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 18, top: 10),
                      child: Text(
                        word_tr!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "RobotoMedium"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(word_eng!),
                    ),
                  ],
                ),
                pressController != true
                    ? Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.orangeAccent,
                  tristate: false,
                  value: status,
                  onChanged: (bool? value) {
                    _wordList[index] =
                        _wordList[index].copy(status: value);
                    if (value == true) {
                      toastMessage("Öğrenildi olarak işaretlendi.");
                      DB.instance.markAsLearned(
                          true, _wordList[index].id as int);
                    } else {
                      toastMessage("Öğrenilmedi olarak işaretlendi.");
                      DB.instance.markAsLearned(
                          false, _wordList[index].id as int);
                    }
                    setState(() {
                      _wordList;
                    });
                  },
                )
                    : Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.orangeAccent,
                  tristate: false,
                  value: deleteIndexList[index],
                  onChanged: (bool? value) {
                    setState(() {
                      deleteIndexList[index] = value!;
                      bool deleteProcessController = false;

                      deleteIndexList.forEach((element) {
                        if (element == true)
                          deleteProcessController = true;
                      });
                      if (!deleteProcessController) {
                        pressController = false;
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
