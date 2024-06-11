import 'package:flutter/material.dart';
import '../db/db/db.dart';
import '../db/models/words.dart';
import '../global_widget/text_field_Builder.dart';
import '../global_widget/toast.dart';
import '../sipsak_metod.dart';

class AddWordPage extends StatefulWidget {
  final int? listID;
  final String? listName;
  const AddWordPage(this.listID, this.listName, {Key? key}) : super(key: key);

  @override
  State<AddWordPage> createState() => _AddWordPageState(listID: listID, listName: listName);
}

class _AddWordPageState extends State<AddWordPage> {
  int? listID;
  String? listName;
  _AddWordPageState({required this.listID, required this.listName});

  List<TextEditingController> wordTextEditingList = [];
  List<Row> wordListField = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; ++i) {
      wordTextEditingList.add(TextEditingController());
    }

    for (int i = 0; i < 3; ++i) {
      wordListField.add(
        Row(
          children: [
            Expanded(child: textFieldBuilder(textEditingController: wordTextEditingList[2 * i])),
            Expanded(child: textFieldBuilder(textEditingController: wordTextEditingList[2 * i + 1])),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        left: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22),
        center: Text(listName!,
            style: const TextStyle(
                fontFamily: "carter", fontSize: 22, color: Colors.black)),
        right: const Icon(Icons.add, color: Colors.black, size: 22),
        leftWidgetOnClick: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "İngilizce",
                      style: TextStyle(fontSize: 20, fontFamily: "RobotoRegular"),
                    ),
                    Text(
                      "Türkçe",
                      style: TextStyle(fontSize: 20, fontFamily: "RobotoRegular"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: wordListField,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  actionBtn(addRow, Icons.add),
                  actionBtn(save, Icons.save),
                  actionBtn(deleteRow, Icons.remove),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addRow() {
    wordTextEditingList.add(TextEditingController());
    wordTextEditingList.add(TextEditingController());

    wordListField.add(
      Row(
        children: [
          Expanded(child: textFieldBuilder(textEditingController: wordTextEditingList[wordTextEditingList.length - 2])),
          Expanded(child: textFieldBuilder(textEditingController: wordTextEditingList[wordTextEditingList.length - 1])),
        ],
      ),
    );
    setState(() {});
  }

  Future<void> save() async {
    int counter = 0;
    bool notEmptyPair = false;
    for (int i = 0; i < wordTextEditingList.length / 2; ++i) {
      String eng = wordTextEditingList[2 * i].text;
      String tr = wordTextEditingList[2 * i + 1].text;
      if (eng.isNotEmpty && tr.isNotEmpty) {
        counter++;
      } else {
        notEmptyPair = true;
      }
    }
    if (counter >= 1) {
      if (!notEmptyPair) {
        for (int i = 0; i < wordTextEditingList.length / 2; ++i) {
          String eng = wordTextEditingList[2 * i].text;
          String tr = wordTextEditingList[2 * i + 1].text;

          Word word = await DB.instance.insertWord(Word(list_id: listID, word_eng: eng, word_tr: tr, status: false));
          debugPrint(
              "${word.id} ${word.list_id} ${word.word_eng} ${word.word_tr} ${word.status}");
        }
        toastMessage("Kelimeler Eklendi.");
        wordTextEditingList.forEach((element) {
          element.clear();
        });
      } else {
        toastMessage("Boş alanları doldurun veya silin");
      }
    } else {
      toastMessage("Minimum 1 çift dolu olmalıdır");
    }
  }

  void deleteRow() {
    if (wordListField.length > 1) {
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);

      wordListField.removeAt(wordListField.length - 1);
      setState(() {});
    } else {
      toastMessage("Minimum 1 çift gereklidir.");
    }
  }

  InkWell actionBtn(Function() click, IconData icon) {
    return InkWell(
      onTap: click,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(bottom: 10, top: 5),
        child: Icon(icon, size: 28),
        decoration: BoxDecoration(
          color: Color(SipsakMetod.HexaColorConverter("#C4E1E4")),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(
      BuildContext context, {
        required Widget left,
        required Widget center,
        required Widget right,
        required void Function() leftWidgetOnClick,
      }) {
    return AppBar(
      leading: GestureDetector(
        onTap: leftWidgetOnClick,
        child: left,
      ),
      title: center,
      actions: [right],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
