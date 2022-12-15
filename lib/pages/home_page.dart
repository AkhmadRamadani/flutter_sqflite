import 'package:flutter/material.dart';
import 'package:flutter_sqflite/widget/custom_card.dart';
import '../helpers/dbhelper.dart';
import 'entry_form.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../models/item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item>? itemList;

  @override
  Widget build(BuildContext context) {
    itemList ??= <Item>[];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambahkan Item - Akhmad Ramadani | 2041720002',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text("Tambah Item"),
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Item?> navigateToEntryForm(BuildContext context, Item? item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item: item);
    }));
    return result;
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return CustomCard(
          item: itemList?[index] ?? Item('', 0, 0),
          delete: () async {
            int result = await dbHelper.delete(itemList?[index].id ?? 0);
            if (result > 0) {
              updateListView();
            }
          },
          onClick: () async {
            var item = await navigateToEntryForm(context, itemList?[index]);
            if (item != null) {
              int result = await dbHelper.update(item);
              if (result > 0) {
                updateListView();
              }
            }
          },
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Item>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          count = itemList.length;
        });
      });
    });
  }
}
