import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zaha/core/routes/routes_name.dart';
import 'package:zaha/features/home/presentation/pages/home_page.dart';
import 'package:zaha/features/login/presentation/pages/login_page.dart';
import 'package:zaha/features/on_broad_feat/presentation/pages/on_broad_page.dart';
import 'package:zaha/features/signin_with_otp/presentation/bloc/bloc.dart';
import 'package:zaha/features/signin_with_otp/presentation/pages/signin_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RoutesName.taskFormScreen:
      //    final args = settings.arguments as Map<String, dynamic>?;
      //   final taskId = args?['taskId'] as String?;
      //   return MaterialPageRoute(
      //     builder: (_) => TaskFormScreen(taskId: taskId),
      //   );
      case RoutesName.onBoardScren:
        return MaterialPageRoute(builder: (context) => const OnboardingPage());
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case RoutesName.signInScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => GetIt.instance<SignInBloc>(),
            child: SignInPage(),
          ),
        );
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(body: Center(child: Text('no screen found')));
        });
    }
  }
}
