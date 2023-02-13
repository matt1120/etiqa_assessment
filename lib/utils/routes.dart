import 'package:flutter/material.dart';

import '../ui/ui.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    Page1Screen.routeName: (context) => const Page1Screen(),
    Page2Screen.routeName: (context) =>  Page2Screen(),
  };
}
