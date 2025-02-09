import 'package:first/local_notification_helper.dart';
import 'package:first/media_query_helper.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late NotificationService _notificationService;
  DateTime _scheduledTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _notificationService = NotificationService();
    _notificationService.init();
  }

  Future<void> _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _scheduledTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_scheduledTime),
      );

      if (pickedTime != null) {
        setState(() {
          _scheduledTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _notificationService.showSimpleNotification,
              child: const Text('Show Simple Notification'),
            ),
            const SizedBox(height: 20),
            // SizedBox(height: MediaQueryHelper.getScreenHeight(context) * 0.5),
            ElevatedButton(
              onPressed: _notificationService.showPeriodicNotification,
              child: const Text('Show Periodic Notification'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickDateTime,
              child: const Text('Pick Date and Time'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _notificationService
                  .scheduleDailyNotification(_scheduledTime),
              child: const Text('Schedule Daily Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
