import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/screens/auth_screens/login_screen.dart';
import 'package:store_app2/screens/home_screen.dart';
import 'package:store_app2/view_models/favorite_screen_view_moedel.dart';
import 'package:store_app2/view_models/login_views_models/login_screen_view_model.dart';
import 'package:store_app2/view_models/login_views_models/login_text_field_view_model.dart';
import 'package:store_app2/view_models/product_card_widget_view_model.dart';
import 'package:store_app2/view_models/register_views_models/register_screen_view_model.dart';
import 'package:store_app2/view_models/register_views_models/register_text_field_view_model.dart';
import 'package:store_app2/widgets/home_widgets/home_body_widget.dart';

import 'constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeBodyWidget()),
        ChangeNotifierProvider(create: (context) => ProductCardWidgetViewModel()),
        ChangeNotifierProvider(create: (context) => LoginTextFieldViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterTextFieldViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterScreenViewModel()),
        ChangeNotifierProvider(create: (context) => LoginScreenViewModel()),
        ChangeNotifierProvider(create: (context) => FavoriteScreenViewModel()),
      ],
      builder: (context, child) {
        return GetMaterialApp(
          title: "electrical store",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme:
                GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
            primaryColor: kPrimaryColor,
            accentColor: kPrimaryColor,
          ),
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [Locale("ar", "AE")],
          locale: const Locale("ar", "AE"),
          home: FirebaseAuth.instance.currentUser == null
              ? LoginScreen()
              : const HomeScreen(),
        );
      },
    );
  }
}
