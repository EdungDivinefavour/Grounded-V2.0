import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/constants/enums/online_presence.dart';
import 'package:grounded/screens/splash.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/services/firebase/database_service.dart';
import 'package:grounded/services/firebase/messaging_service.dart';
import 'package:grounded/services/notification/notification_service.dart';

class Grounded extends StatefulWidget {
  @override
  State<Grounded> createState() => _GroundedState();
}

class _GroundedState extends State<Grounded> with WidgetsBindingObserver {
  final _notificationService = NotificationService.instance;
  final _messagingService = MessagingService.instance;
  final _databaseService = DatabaseService.instance;
  final _authService = AuthenticationService.instance;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    if (_authService.currentUser != null) {
      _messagingService.getAndSetTokens();
      _databaseService.listenForAppDisconnected(
          userId: _authService.currentUser!.uid);
      _databaseService.updateRealTimeDbPresence(
          onlinePresence: OnlinePresence.online,
          userId: _authService.currentUser!.uid);
    }

    _notificationService.setupHandler(_navigatorKey);
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_authService.currentUser != null) {
      _databaseService.updateRealTimeDbPresence(
        userId: _authService.currentUser!.uid,
        onlinePresence: state == AppLifecycleState.resumed
            ? OnlinePresence.online
            : OnlinePresence.away,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grounded',
      builder: EasyLoading.init(),
      home: _buildHome(),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildHome() {
    return StreamBuilder(
      stream: _authService.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        }

        final firebaseUser = snapshot.data;
        if (firebaseUser == null) return Splash();

        return Splash(firebaseUser: firebaseUser as User);
      },
    );
  }
}
