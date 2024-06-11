import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/global_widget/app_bar.dart';
import 'package:untitled10/global_widget/toast.dart';
import 'package:untitled10/pages/create_list.dart';
import 'package:untitled10/db/db/db.dart';
import 'package:untitled10/pages/words.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  List<Map<String, Object?>> _lists = [];

  bool pressController = false;
  List<bool> deleteIndexList = [];

  @override
  void initState() {
    // TODO: Implement initState
    super.initState();
    getLists();
  }

  void getLists() async {
    _lists = await DB.instance.readListsAll();
    for (int i = 0; i < _lists.length; ++i)
      deleteIndexList.add(false);

    setState(() {
      _lists;
    });
  }

  void delete() async {
    List<int> removeIndexList = [];

    for (int i = 0; i < _lists.length; ++i)
      if (deleteIndexList[i] == true) removeIndexList.add(i);

    for (int i = removeIndexList.length - 1; i >= 0; --i) {
      await DB.instance
          .deleteListsAndWordByList(_lists[removeIndexList[i]]['list_id'] as int);
      _lists.removeAt(removeIndexList[i]);
      deleteIndexList.removeAt(removeIndexList[i]);
    }

  for (int i =0;i<deleteIndexList.length; ++i)
    deleteIndexList[i]=false;
  setState(() {
    _lists;
    deleteIndexList;
    pressController=false;
  });

  toastMessage("Seçili Listeler Silindi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        left: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22),
        center: pressController != true
            ? Image.asset("assets/images/Listeler.png")
            : InkWell(
          onTap: delete,
          child: Icon(
            Icons.delete,
            color: Colors.black,
            size: 24,
          ),
        ),
        leftWidgetOnClick: () => {Navigator.pop(context)},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (Context) => const CreateList()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFFFFC4E1E4), // Buton rengini güncelledik
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return listItem(
              _lists[index]['list_id'] as int,
              index,
              listName: _lists[index]['name'].toString(),
              sumWords: _lists[index]['sum_word'].toString(),
              sumUnlearned: _lists[index]['sum_unlearned'].toString(),
            );
          },
          itemCount: _lists.length,
        ),
      ),
    );
  }

  InkWell listItem(int id, int index,
      {String? listName, String? sumWords, String? sumUnlearned}) {
    // Null kontrolü ve default değerler ekledik
    int sumWordsInt = int.tryParse(sumWords ?? '0') ?? 0;
    int sumUnlearnedInt = int.tryParse(sumUnlearned ?? '0') ?? 0;

    return InkWell(
      onTap: () {
        debugPrint(id.toString());
        Navigator.push(context,MaterialPageRoute(builder: (context)=>WordsPage(id, listName))).then((value){
          getLists();
        });
      },
      onLongPress: () {
        setState(() {
          pressController = true;
          deleteIndexList[index] = true;
        });
      },
      child:Center(
      child: Container(
        width: double.infinity,
        child: Card(
          color: Color(0xFFFFD3DE), // Kart rengini güncelledik
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin:
          const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      listName ?? '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      "$sumWords Terim",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      "${sumWordsInt - sumUnlearnedInt} Öğrenildi",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, bottom: 5),
                    child: Text(
                      "$sumUnlearned Öğrenilmedi",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),

                ],
              ),

              pressController == true
                  ? Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.orangeAccent,
                hoverColor: Colors.amberAccent,
                value: deleteIndexList[index],
                onChanged: (bool? value) {
                  setState(() {
                    deleteIndexList[index] = value!;
                    bool deleteProcessController = false;

                    deleteIndexList.forEach((element) {
                      if (element == true)
                        deleteProcessController = true;
                    });
                    if (!deleteProcessController)
                      pressController = false;
                  });
                },
              )
                  : Container()
            ],
          ),
        ),
      ),
      )
    );
  }
}
