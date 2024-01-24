// lab_test_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class LabTestCard extends StatefulWidget {
  final String testName;
  final String description;
  final int numTests;
  final String turnaroundTime;
  final String discountedPrice;
  final String originalPrice;

  LabTestCard({
    required this.testName,
    required this.description,
    required this.numTests,
    required this.turnaroundTime,
    required this.discountedPrice,
    required this.originalPrice,
  });

  @override
  _LabTestCardState createState() => _LabTestCardState();
}

class _LabTestCardState extends State<LabTestCard> {
  bool isAddingToCart = false;
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(width: 1, color: Colors.grey),
      ),
      child: Column(
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
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.testName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 1),
                    Row(
                      children: [
                        Text(
                          'Includes ${widget.numTests} tests',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.verified_user,
                          color: Color(0xFF16C2D5),
                          size: 18,
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(height: 0),
                    Row(
                      children: [
                        Text(
                          '₹${widget.discountedPrice}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF10217D),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '₹${widget.originalPrice}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0),
                    ElevatedButton(
                      onPressed: () {
                        if (!addedToCart) {
                          setState(() {
                            isAddingToCart = true;
                          });

                          Future.delayed(Duration(seconds: 2), () {
                            setState(() {
                              isAddingToCart = false;
                              addedToCart = true;
                            });

                            // TODO: Replace the following line with actual cart functionality
                            Provider.of<CartProvider>(context, listen: false)
                                .addToCart(); // Add the item to the cart
                          });
                        }
                      },
                      child: SizedBox(
                        height: 20,
                        child: Center(
                          child: Text(
                            isAddingToCart
                                ? 'Adding to Cart...'
                                : addedToCart
                                ? 'Added to Cart'
                                : 'Add to Cart',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: addedToCart
                            ? Colors.lightBlue
                            : isAddingToCart
                            ? Colors.grey
                            : Color(0xFF10217D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}