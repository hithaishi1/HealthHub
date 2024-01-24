// DateTimeSelectionScreen.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class DateTimeSelectionScreen extends StatefulWidget {
  final TextEditingController timeController;

  DateTimeSelectionScreen({required this.timeController});

  @override
  _DateTimeSelectionScreenState createState() => _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  List<String> timeSlots = [
    '08:00 AM', '09:00 AM', '10:00 AM',
    '11:00 AM', '12:00 PM', '01:00 PM',
    '02:00 PM', '03:00 PM', '04:00 PM',
    '05:00 PM', '06:00 PM', '07:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date and Time'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Calendar Widget
          TableCalendar(
            focusedDay: selectedDate,
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 365)),
            calendarFormat: CalendarFormat.month,
            onDaySelected: (date, _) {
              setState(() {
                selectedDate = date;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFF10217D),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          // Select Time Heading
          Text(
            'Select Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          // Time Picker
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              final time = timeSlots[index];
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedTime = _convertToTimeOfDay(time);
                    widget.timeController.text =
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} (${selectedTime!.format(context)})';
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: selectedTime == _convertToTimeOfDay(time) ? Color(0xFF10217D) : Colors.white,
                  side: BorderSide(color: Color(0xFF10217D), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: selectedTime == _convertToTimeOfDay(time) ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          // Confirm Button
          ElevatedButton(
            onPressed: selectedDate != null && selectedTime != null
                ? () {
              // TODO: Handle confirmation logic with selectedDate and selectedTime
              Navigator.pop(
                context,
                DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                ),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              primary: selectedDate != null && selectedTime != null ? Color(0xFF10217D) : Colors.grey,
            ),
            child: Text(
              'Confirm',
              style: TextStyle(
                color: selectedDate != null && selectedTime != null ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TimeOfDay _convertToTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1].substring(0, 2)));
  }
}
