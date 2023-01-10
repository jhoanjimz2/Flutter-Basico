import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificacionService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream = StreamController.broadcast();

  static Stream<String> get messageStream => _messageStream.stream;

  static Future _onBackgroundHandler( RemoteMessage message ) async {
    _messageStream.add( message.data['product'] ?? 'No data' );
  }

  static Future _onMessageHandler( RemoteMessage message ) async {
    _messageStream.add( message.data['product'] ?? 'No data' );
  }

  static Future _onMessageOpenApp( RemoteMessage message ) async {
    _messageStream.add( message.data['product'] ?? 'No data' );
  }


  static Future initializeApp() async {

    await Firebase.initializeApp();
    await requestPermission();
    token = await FirebaseMessaging.instance.getToken();
    print(token);


    FirebaseMessaging.onBackgroundMessage( _onBackgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

  }

  static requestPermission () async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
    );
    print('User push notification status ${ settings.authorizationStatus }');
  }

  static closeStream() {
    _messageStream.close();
  }

}