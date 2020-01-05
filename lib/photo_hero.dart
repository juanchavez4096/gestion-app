
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero({ Key key, this.tagId, this.onTap, this.width, this.radius, this.imageUrl, this.name }) : super(key: key);

  final String tagId;
  final VoidCallback onTap;
  final double width;
  final double radius;
  final String imageUrl;
  final String name;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: tagId,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: CircleAvatar(
              radius: radius,
              backgroundColor: Theme.of(context).primaryColor,
              child: imageUrl != null ? CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: imageUrl,
                errorWidget: (context, url, error) => Text(getInitials()),
              ) : Text(getInitials())
              //child: FadeInImage.memoryNetwork( image: 'https://juanjchavez.com/img/questions-suit-guy.png', placeholder: ,),
            )/*Image.asset(
              photo,
              fit: BoxFit.contain,
            )*/,
          ),
        ),
      ),
    );
  }

  String getInitials(){
    if(name != null && name.isNotEmpty){
      return name.length > 1 ? name.substring(0,2).toUpperCase() : name[0].toUpperCase();
    }
    return 'KLK';
  }
}