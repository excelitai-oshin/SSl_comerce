import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:provider/provider.dart';
import 'package:ssl_comerce/provider/drawer_provider.dart';
import 'package:ssl_comerce/provider/internet_connectivity_status.dart';
import 'package:ssl_comerce/provider/theme_provider.dart';
import 'package:ssl_comerce/service/db_service.dart';
import 'package:ssl_comerce/service/local_storage.dart';
import 'package:ssl_comerce/view/log_in_screen.dart';
import 'package:ssl_comerce/view/profile_Screen.dart';

String? token;
bool? isSession;
String? memberId;
String? id;
String? receiptNumber;
String? memberName;
bool? isInternet;
String platformID = 'Unknown';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final tokentemp=await LocalStorageStore().getUserToken();
  token=tokentemp.toString();
  isSession=await DBService().isSession(token!);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {



  List? k;

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  bool switchValue = false;
  ThemeProvider themeProvider = ThemeProvider();

  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }
  // This widget is the root of your application.
  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }
  ThemeMode _themeMode = ThemeMode.system;


  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(seconds: 30),
        invalidateSessionForUserInactiviity: const Duration(seconds:60)
    );
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) async{
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        // handle user  inactive timeout
        await LocalStorageStore().userDeleteToken();
        memberId=null;
        receiptNumber=null;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LogInScreen()),
                (route) => false);
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle user  app lost focus timeout
        await LocalStorageStore().userDeleteToken();
        memberId=null;
        receiptNumber=null;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LogInScreen()),
                (route) => false);
      }
    });
    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ThemeProvider()),
          ChangeNotifierProvider.value(value: InternetConnectivityStatus()),
          ChangeNotifierProvider.value(value: DrawerProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, value, child){
            return MaterialApp(
                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(),
                //Style.themeData(value.darkTheme),
                darkTheme: ThemeData.dark(),

                themeMode: _themeMode,
                // ThemeData(
                //   primarySwatch: Colors.blue,
                // ), //log_in_screen(),//PayNowPage(),//
                //home: LogInScreen(),
                home:ProfilePage()
              // isSession==true?HomeScreen():SplashScreen(),//SplashScreen(),//
            );
          },

        ),
      ),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
