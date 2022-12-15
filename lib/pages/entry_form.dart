import 'package:flutter/material.dart';
import '../models/item.dart';

class EntryForm extends StatefulWidget {
  Item? item;

  EntryForm({Key? key, required this.item}) : super(key: key);

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  _EntryFormState();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (widget.item != null) {
      nameController.text = widget.item?.name ?? '';
      priceController.text = (widget.item?.price ?? 0).toString();
      stockController.text = (widget.item?.stock ?? 0).toString();
    }
    return Scaffold(
        appBar: AppBar(
            title:
                widget.item == null ? const Text('Tambah') : const Text('Ubah'),
            leading: const Icon(Icons.keyboard_arrow_left)),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: [
              // nama
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // harga
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: stockController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Stok',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: const Text(
                          "Save",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (widget.item == null) {
                            // Tambah Data
                            widget.item = Item(
                              nameController.text,
                              int.parse(priceController.text),
                              int.parse(stockController.text),
                            );
                          } else {
                            widget.item!.name = nameController.text;
                            widget.item!.price =
                                int.parse(priceController.text);
                            widget.item!.stock =
                                int.parse(stockController.text);
                          }
                          Navigator.pop(context, widget.item);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    //tombol batal
                    Expanded(
                        child: ElevatedButton(
                      child: const Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
