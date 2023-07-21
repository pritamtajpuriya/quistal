import 'dart:async';
// import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/screens/SubscriptionPlansScreen.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';
import 'package:singleclinic/screens/home/HomeScreen.dart';
import 'package:singleclinic/screens/SplashScreen.dart';
import 'package:singleclinic/screens/hospital/hospital_list_screen.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/routes/routes.dart';

import 'notificationTesting/notificationHelper.dart';

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
String SERVER_ADDRESS = "https://questal.in";

MyNotificationHelper notificationHelper = MyNotificationHelper();
final String serverToken =
    "AAAA5IiV7UE:APA91bHpzvwwynI3ABgMKoLPlbEqDGbAIJIte4AoEixc2_xmHb8SjuKPJXFurD0q7K4_6ptEK7o1tbsTABcP73kjYWiHocvtZaXh-uyaW_L17q80FYOZmjYovMS6pZ6hVbDo_KiPPZNp";

const String TOKENIZATION_KEY = 'sandbox_v2fzhc6d_qpj7hhj994nbzy5q';
const String CURRENCY_CODE = 'USD';
const String DISPLAY_NAME = 'Mhealth';

Color LIME = Color.fromRGBO(9, 77, 85, 1);
// Color LIME = Color.fromRGBO(231, 208, 69, 1);
Color WHITE = Colors.white;
Color BLACK = Colors.black;
Color NAVY_BLUE = Color(0xFF094D55); //Color.fromRGBO(53, 99, 128, 1);
Color LIGHT_GREY = Color.fromRGBO(230, 230, 230, 1);
Color LIGHT_GREY_SCREEN_BG = Color.fromRGBO(240, 240, 240, 1);
Color LIGHT_GREY_TEXT = Colors.grey.shade700;
String CURRENCY = "Rs ";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  notificationHelper.initialize();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: "Avir",
          ),
          headline2: TextStyle(
            fontFamily: "Avir",
          ),
          headline3: TextStyle(
            fontFamily: "Avir",
          ),
          headline4: TextStyle(
            fontFamily: "Avir",
          ),
          headline5: TextStyle(
            fontFamily: "Avir",
          ),
          headline6: TextStyle(
            fontFamily: "Avir",
          ),
          subtitle1: TextStyle(
            fontFamily: "Avir",
          ),
          subtitle2: TextStyle(
            fontFamily: "Avir",
          ),
          caption: TextStyle(
            fontFamily: "Avir",
          ),
          bodyText1: TextStyle(
            fontFamily: "Avir",
          ),
          bodyText2: TextStyle(
            fontFamily: "Avir",
          ),
          button: TextStyle(
            fontFamily: "Avir",
          ),
        ),
        primaryColor: NAVY_BLUE,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: LIME, primary: NAVY_BLUE)),
    routes: Routes.routes,
    initialRoute: SplashScreen.routeName,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ''),
      const Locale('he', ''),
      const Locale('ar', ''),
      const Locale.fromSubtags(languageCode: 'zh'),
    ],
  ));
}

class RootScreen extends StatefulWidget {
  static const routeName = '/rootScreen';

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LIGHT_GREY,
      body: Stack(
        children: [
          currentTab == 0 ? HomeScreen() : Container(),
          currentTab > 0 ? ShopScreen() : Container(),
          currentTab > 1 ? DoctorsListScreen() : Container(),
          currentTab > 2 ? HospitalListScreen() : Container(),
          currentTab > 3 ? SubscriptionPlansScreen() : Container(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.green,
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              currentIndex: currentTab,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    currentTab == 0
                        ? "assets/tabBar/home_active.png"
                        : "assets/tabBar/home.png",
                    color: currentTab == 0 ? NAVY_BLUE : LIGHT_GREY_TEXT,
                    height: 23,
                    width: 23,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      currentTab == 1
                          ? "assets/shop_icon.png"
                          : "assets/shop_icon.png",
                      color: currentTab == 1 ? NAVY_BLUE : LIGHT_GREY_TEXT,
                      height: 23,
                      width: 23,
                    ),
                    label: "Shop"),
                BottomNavigationBarItem(
                    icon: Icon(
                      currentTab == 2
                          ? CupertinoIcons.person
                          : CupertinoIcons.person,
                      color: currentTab == 2 ? NAVY_BLUE : LIGHT_GREY_TEXT,
                    ),
                    label: "Doctors"),
                BottomNavigationBarItem(
                    icon: Icon(
                      currentTab == 3
                          ? Icons.health_and_safety_outlined
                          : Icons.health_and_safety_outlined,
                      color: currentTab == 3 ? NAVY_BLUE : LIGHT_GREY_TEXT,
                    ),
                    label: "Hospitals"),
                BottomNavigationBarItem(
                  icon: Icon(
                    currentTab == 3
                        ? Icons.workspaces_outline
                        : Icons.workspaces_outline,
                    color: currentTab == 3 ? NAVY_BLUE : LIGHT_GREY_TEXT,
                  ),
                  label: "Packages",
                ),
              ],
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 10,
              showSelectedLabels: true,
              unselectedFontSize: 10,
              selectedLabelStyle: TextStyle(
                color: LIGHT_GREY_TEXT,
              ),
              onTap: (val) {
                setState(() {
                  currentTab = val;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SignInDemo extends StatefulWidget {
  @override
  _SignInDemoState createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _googleSignIn.signIn().then((value) {
              value.authentication.then((googleKey) {
                print(googleKey.idToken);
                print(googleKey.accessToken);
                print(value.email);
                print(value.displayName);
                print(value.photoUrl);
              }).catchError((e) {
                print(e.toString());
              });
            }).catchError((e) {
              print(e.toString());
            });
          },
          child: Container(),
        ),
      ),
    );
  }
}

class AppleLogin extends StatefulWidget {
  @override
  _AppleLoginState createState() => _AppleLoginState();
}

class _AppleLoginState extends State<AppleLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app: Sign in with Apple'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(),
        ),
      ),
    );
  }
}

Future myBackgroundMessageHandler(RemoteMessage event) async {
  await Firebase.initializeApp();
  print("\n\nbackground: " + event.toString());

  notificationHelper.showMessagingNotification(data: event.data);
}

doesSendNotification(String userUid, bool doesSend) async {
  await SharedPreferences.getInstance().then((value) {
    value.setBool(userUid, doesSend);
    print("\n\n ------------------> " +
        value.getBool(userUid).toString() +
        "\n\n");
  });
}
