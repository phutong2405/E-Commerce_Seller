import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:ecom_seller_1512/bloc/app_bloc.dart';
import 'package:ecom_seller_1512/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false;
    // bool isDarkMode = true;

    return BackGestureWidthTheme(
      backGestureWidth: BackGestureWidth.fixed(20),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.iOS:
                    CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
              },
            ),
            colorScheme: isDarkMode == false
                ? const ColorScheme(
                    brightness: Brightness.dark,
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    secondary: Colors.white,
                    onSecondary: Colors.black,
                    error: Colors.red,
                    onError: Colors.white,
                    background: Colors.white,
                    onBackground: Colors.black,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  )
                : const ColorScheme(
                    brightness: Brightness.light,
                    primary: Colors.white,
                    onPrimary: Colors.black87,
                    secondary: Colors.black87,
                    onSecondary: Colors.white,
                    error: Colors.red,
                    onError: Colors.black87,
                    background: Colors.black87,
                    onBackground: Colors.white,
                    surface: Colors.black87,
                    onSurface: Colors.white,
                  ),
            useMaterial3: true,
          ),
          home: BlocProvider(
              create: (context) => AppBloc(), child: const MainView())),
    );
  }
}
