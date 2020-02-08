import 'package:costos_operativos/widget/photo_hero.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget{
  const MyListTile(
      {Key key,
        @required this.id,
        @required this.onTap,
        @required this.imageUrl,
        @required this.name,
        @required this.description,
        this.onDelete,
        })
      : super(key: key);

  final int id;
  final VoidCallback onTap;
  final String imageUrl;
  final String name;
  final String description;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: PhotoHero(
            id: id,
            name: name,
            imageUrl: imageUrl,
            onTap: onTap,),
        title: Text(name),
        subtitle: Text(description),
        enabled: true,
        trailing: onDelete != null ? IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ) : null,
        onTap: onTap);//onTap);
  }

}