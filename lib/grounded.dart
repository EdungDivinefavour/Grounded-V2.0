import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:grounded/constants/enums/online_presence.dart';
import 'package:grounded/screens/splash.dart';
import 'package:grounded/services/firebase/authentication_service.dart';
import 'package:grounded/services/firebase/database_service.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/services/firebase/messaging_service.dart';
import 'package:grounded/services/notification/notification_service.dart';

class Grounded extends StatefulWidget {
  @override
  State<Grounded> createState() => _GroundedState();
}

class _GroundedState extends State<Grounded> with WidgetsBindingObserver {
  final _notificationService = NotificationService.instance;
  final _firestoreService = FirestoreService.instance;
  final _messagingService = MessagingService.instance;
  final _databaseService = DatabaseService.instance;
  final _authenticationService = AuthenticationService.instance;
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    if (_authenticationService.currentUser != null) {
      _messagingService.getAndSetTokens();
      _databaseService.listenForAppDisconnected(
          userId: _authenticationService.currentUser?.uid);
      _databaseService.updateRealTimeDbPresence(
          onlinePresence: OnlinePresence.online,
          userId: _authenticationService.currentUser?.uid);
    }
    if (!kIsWeb) _notificationService.setupHandler(navigatorKey);
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_authenticationService.currentUser != null) {
      _databaseService.updateRealTimeDbPresence(
          userId: _authenticationService.currentUser!.uid,
          onlinePresence: state == AppLifecycleState.resumed
              ? OnlinePresence.online
              : OnlinePresence.away);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grounded',
      builder: EasyLoading.init(),
      home: _buildHome(),
    );
  }

  Widget _buildHome() {
    return StreamBuilder(
      stream: _authenticationService.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        if (user == null) {
          return Splash();
        }

        _firestoreService.storeParentInfo(
            userId: _authenticationService.currentUser!.uid);
        return Splash(
            displayName: _authenticationService.currentUser!.displayName);
      },
    );
  }
}
