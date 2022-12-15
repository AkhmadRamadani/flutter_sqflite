import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/item.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.item,
    required this.delete,
    required this.onClick,
  });
  final Item item;
  final Function() delete;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.people),
        ),
        title: Text(
          item.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              child: Text(item.price.toString()),
            ),
            Text('Sisa: ${item.stock}'),
          ],
        ),
        trailing: GestureDetector(
          onTap: delete,
          child: const Icon(Icons.delete),
        ),
        onTap: onClick,
      ),
    );
  }
}
