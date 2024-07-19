import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zaha/features/signin_with_otp/presentation/bloc/auth_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaha/core/routes/routes.dart';
import 'package:zaha/core/routes/routes_name.dart';
import 'package:zaha/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.onBoardScren,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
