
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../widgets/List_view_widget.dart';

class wishlish extends StatelessWidget {
  const wishlish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listviewwidget(
      collection: "userFavorite",
      subcollection: "Favorite",
      id:FirebaseAuth.instance.currentUser!.uid ,
    );
  }
}
