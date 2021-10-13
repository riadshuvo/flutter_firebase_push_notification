import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification/green_page.dart';
import 'package:push_notification/red_page.dart';

import 'notification_services/local_notification_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

///Receive messages when app is in background solution by
///[FirebaseMessaging.onBackgroundMessage]
Future<void> backgroundHandler(RemoteMessage message) async{
  print(message.notification?.title);
  print(message.notification?.body);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Push Notification',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Push Notification'),
      routes: {
        'red': (_) => RedPage(),
        'green': (_) => GreenPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    ///Gives you the message on which user taps
    ///and it opens when the app is closed or terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if(message != null){
        final routeMessage = message.data["route"];
        print('routeMessage: $routeMessage');

        Navigator.of(context).pushNamed(routeMessage);
      }
    });

    ///This will call when app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);

      ///This will create Notification channel and show HeadsUp Notification
      LocalNotificationService.display(message);

    });

    ///This will call When the app is running on background and user taps
    ///on Notification this section will [Navigate] to specific page
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeMessage = message.data["route"];
      print('routeMessage: $routeMessage');

      Navigator.of(context).pushNamed(routeMessage);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Will receive notification soon!', style: TextStyle(
            fontSize: 20,
            color: Colors.black
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
