import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/screens/home_screen.dart';
import 'package:store_app2/widgets/home/home_body_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBodyWidget(),
      builder: (context, child){
        return MaterialApp(
          title: "electrical store",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
            primaryColor: kPrimaryColor,
            accentColor: kPrimaryColor,
          ),
          localizationsDelegates: const[
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const[ Locale("ar", "AE")],
          locale: const Locale("ar", "AE"),
          home: const HomeScreen(),
        );
      },
    );
  }
}
