import 'package:flutter/material.dart';
import 'package:grounded/components/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_notification.dart';
import 'package:grounded/services/local_storage/local_storage.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:grounded/utils/int_utils.dart';

class ViewNotifications extends StatefulWidget {
  @override
  State<ViewNotifications> createState() => _ViewNotificationsState();
}

class _ViewNotificationsState extends State<ViewNotifications> {
  final _localStorage = LocalStorage.instance;
  final _notifications = <GroundedNotification>[];

  @override
  void initState() {
    super.initState();

    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: "All Notifications"),
      bubblePosition: BackgroundBubblePosition.topRight,
      body: _notifications.isEmpty
          ? Center(
              child: Text(
                  "No notifications yet!. When you child uses the app, you will get notifications from their activities"))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (_, index) {
                  final notification = _notifications[index];

                  return _buildEachNotification(notification);
                },
              ),
            ),
    );
  }

  Widget _buildEachNotification(GroundedNotification notification) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(notification.title, style: TextStyles.semiBold),
              Spacer(),
              Text(notification.creationTimeStamp.toFormattedDate),
            ],
          ),
          SizedBox(height: 20),
          Text(notification.body),
          SizedBox(height: 10),
          Divider(height: 1, thickness: 0.7),
        ],
      ),
    );
  }

  void _getNotifications() async {
    final result = await _localStorage.getNotificationsFromLocal();
    if (result == null) return;

    setState(() {
      _notifications.addAll(result);
    });
  }
}
