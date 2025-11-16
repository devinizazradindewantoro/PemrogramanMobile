import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profil_page.dart';
import 'gallery_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => HomePage(),
  '/profile': (context) => ProfilePage(),
  '/gallery': (context) => GalleryPage(),
};
