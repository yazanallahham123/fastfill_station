import 'package:flutter/material.dart';

import '../../helper/size_config.dart';

class FavoriteButtonWidget extends StatefulWidget{

  final bool isAddedToFavorite;
  final VoidCallback? onTap;
  const FavoriteButtonWidget({this.isAddedToFavorite=false, this.onTap});

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
          height: SizeConfig().h(40),
          width: SizeConfig().w(40),
          child: Image(image: AssetImage((widget.isAddedToFavorite) ? "assets/favorite.png" : "assets/not_favorite.png"),
            width: SizeConfig().w(40),
          )),
    );
  }
}