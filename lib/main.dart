import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zaha/core/routes/routes.dart';
import 'package:zaha/core/routes/routes_name.dart';
import 'package:zaha/injection_container.dart' as di;

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.onBoardScren,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
