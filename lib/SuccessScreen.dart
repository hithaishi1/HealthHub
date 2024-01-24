// SuccessScreen.dart

import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final DateTime scheduledDateTime;

  SuccessScreen({required this.scheduledDateTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back when the back button is pressed
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                child: Image.asset(
                  'assets/images/img_1.png',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Lab tests have been scheduled successfully. You will receive a mail of the same.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                '${_formatDate(scheduledDateTime)} | ${_formatTime(scheduledDateTime)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);

                  // TODO: Implement navigation to home screen
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF10217D),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(16),
                  minimumSize: Size(double.infinity, 0),
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final monthNames = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December',
    ];
    return '${dateTime.day} ${monthNames[dateTime.month - 1]} ${dateTime.year}';
  }

  // Utility function to format time as hh:mm am/pm
  String _formatTime(DateTime dateTime) {
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    String minute = dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';
    return '$hour:$minute $period';
  }
}
