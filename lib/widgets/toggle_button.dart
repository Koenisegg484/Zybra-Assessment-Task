import 'package:flutter/material.dart';

class NotificationToggleButton extends StatefulWidget {
  @override
  _NotificationToggleButtonState createState() => _NotificationToggleButtonState();
}

class _NotificationToggleButtonState extends State<NotificationToggleButton> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _notificationsEnabled = !_notificationsEnabled;
        });

        //Todo: Add logic to enable/disable notifications here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _notificationsEnabled ? Colors.green : Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _notificationsEnabled ? Icons.notifications_active : Icons.notifications_off,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            _notificationsEnabled ? 'On' : 'Off',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
