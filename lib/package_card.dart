// package_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class PackageCard extends StatefulWidget {
  final String packageName;
  final List<String> includedTests;
  final String price;

  PackageCard({
    required this.packageName,
    required this.includedTests,
    required this.price,
  });

  @override
  _PackageCardState createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool isAddingToCart = false;
  bool isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ImageIcon(
                      Image.asset('assets/images/img.png').image, // Replace with your image path
                      color: Color(0xFF10217D),
                      size: 40,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF16C2D5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.verified_user,
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Safe',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    widget.packageName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Included Tests:'),
                  SizedBox(height: 4),
                  ...widget.includedTests.map(
                        (test) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.fiber_manual_record, size: 10),
                          SizedBox(width: 4),
                          Flexible(child: Text(test)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement the "View More" functionality.
                    },
                    child: Text(
                      'View More',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price: ${widget.price}',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (!isAddingToCart && !isAddedToCart) {
                            setState(() {
                              isAddingToCart = true;
                            });

                            Future.delayed(Duration(seconds: 2), () {
                              setState(() {
                                isAddingToCart = false;
                                isAddedToCart = true;
                              });

                              Provider.of<CartProvider>(context, listen: false)
                                  .addToCart();
                            });
                          }
                        },
                        child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(
                              isAddedToCart
                                  ? 'Added to Cart'
                                  : isAddingToCart
                                  ? 'Adding to Cart...'
                                  : 'Add to Cart',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: isAddedToCart
                              ? Colors.lightBlue
                              : isAddingToCart
                              ? Colors.grey
                              : Color(0xFF10217D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
