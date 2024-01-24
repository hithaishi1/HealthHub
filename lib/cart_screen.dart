import 'package:flutter/material.dart';
import 'DateTimeSelectionScreen.dart';
import 'SuccessScreen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DateTime? selectedDateTime;
  bool hardCopyChecked = false;
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Review',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              LabTestCards(
                testName: 'Pathology Tests',
                numTests: 1,
                discountedPrice: '₹1000',
                originalPrice: '₹1400',
                isPathologyTests: true,
              ),
              SizedBox(height: 16),
              // Second Section: Date Selection Card
              CardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display selected date and time using the timeController
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            // Navigate to the DateTimeSelectionScreen
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DateTimeSelectionScreen(timeController: timeController),
                              ),
                            );

                            // Handle the result if it's a DateTime
                            if (result != null && result is DateTime) {
                              setState(() {
                                selectedDateTime = result;
                                String formattedDateTime =
                                    '${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} (${_formatTime(selectedDateTime!)})';
                                timeController.text = formattedDateTime;
                              });
                            }
                          },
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: timeController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Select Date and Time',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            onTap: () async {
                              // Navigate to the DateTimeSelectionScreen
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DateTimeSelectionScreen(timeController: timeController),
                                ),
                              );

                              // Handle the result if it's a DateTime
                              if (result != null && result is DateTime) {
                                setState(() {
                                  selectedDateTime = result;
                                  String formattedDateTime =
                                      '${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} (${_formatTime(selectedDateTime!)})';
                                  timeController.text = formattedDateTime;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                timeController: timeController,
              ),
              SizedBox(height: 16),
              // Third Section: Order Summary
              CardWidget(
                showSelectDateButton: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildOrderRow('M.R.P Total', '₹1400'),
                    buildOrderRow('Discount', '₹400'),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount to be paid',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF10217D)),
                        ),
                        Text(
                          '₹1000',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF10217D)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    buildOrderRow('Total Savings', '₹400'),
                  ],
                ),
                timeController: timeController,
              ),
              SizedBox(height: 16),
              // Fourth Section: Hard Copy of Reports
              CardWidget(
                showSelectDateButton: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: hardCopyChecked,
                          onChanged: (value) {
                            setState(() {
                              hardCopyChecked = value ?? false;
                            });
                          },
                          activeColor: Color(0xFF10217D),
                          checkColor: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text('Hard copy of reports'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Reports will be delivered in 3-4 working days. Hard copy charges are non-refundable once the reports have been dispatched.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text('₹150 per person'),
                  ],
                ),
                timeController: timeController,
              ),
              SizedBox(height: 16),
              // Schedule Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedDateTime != null
                      ? () {
                    DateTime scheduledDateTime = DateTime.now();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => SuccessScreen(scheduledDateTime: scheduledDateTime),
                    ),
                    );
                    // TODO: Implement schedule button logic
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: selectedDateTime != null ? Color(0xFF10217D) : Colors.grey,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16), // Add padding as needed
                  ),
                  child: Text(
                    'Schedule',
                    style: TextStyle(
                      fontSize: 16, // Adjust font size as needed
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }

  // Utility function to format time as am/pm
  String _formatTime(DateTime dateTime) {
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    String minute = dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}';
    return '$hour:$minute $period';
  }
}

class LabTestCards extends StatelessWidget {
  final String testName;
  final int numTests;
  final String discountedPrice;
  final String originalPrice;
  final bool isPathologyTests;

  LabTestCards({
    required this.testName,
    required this.numTests,
    required this.discountedPrice,
    required this.originalPrice,
    required this.isPathologyTests,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF217DCC),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            isPathologyTests ? testName : 'Test Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 1; i <= numTests; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (i > 1) SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Test 1',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              discountedPrice,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1BA9B5),
                              ),
                            ),
                            Text(
                              originalPrice,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement remove test logic
                      },
                      icon: Icon(Icons.delete, color: Color(0xFF10217D)),
                      label: Text('Remove'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement remove test logic
                      },
                      icon: Icon(Icons.upload, color: Color(0xFF10217D)),
                      label: Text('Upload Prescription (optional)'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  final Widget child;
  final bool showSelectDateButton;
  final Function()? onDateSelect;
  final TextEditingController timeController;

  CardWidget({required this.child, this.showSelectDateButton = true, this.onDateSelect, required this.timeController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            if (showSelectDateButton)
              Row(
                children: [
                  Text('Date and Time')
                ],
              ),
            SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
