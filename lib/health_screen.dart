// health_screen.dart
import 'package:flutter/material.dart';
import 'package:health_hub/lab_test_card.dart';
import 'package_card.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'cart_screen.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('HealthHub')), // Centered title
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) => Stack(
              alignment: Alignment.centerLeft,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: Color(0xFF10217D),
                  onPressed: () {
                    // Open cart screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),
                if (cartProvider.cartCount > 0)
                  Positioned(
                    right: 32,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.lightBlue.shade300,
                      child: Text(
                        cartProvider.cartCount.toString(),
                        style: TextStyle(color: Color(0xFF10217D), fontSize: 8),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle('Popular Lab Tests', showDetailsLink: true), // Added showDetailsLink parameter
              buildLabTestGrid(),
              SizedBox(height: 20),
              SizedBox(height: 8),
              buildSectionTitle('Popular Packages'),
              buildPackageGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, {bool showDetailsLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF10217D)),
          ),
          if (showDetailsLink)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      'View more',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF10217D),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 16, color: Color(0xFF10217D)),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildLabTestGrid() {
    return Container(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            height: double.infinity,
            child: LabTestCard(
              testName: 'Lab Test $index',
              description: 'Get reports in 24 hours',
              numTests: 5,
              turnaroundTime: '24 hours',
              discountedPrice: '1000',
              originalPrice: '1400',
            ),
          );
        },
      ),
    );
  }

  Widget buildPackageGrid() {
    return Container(
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 2,
        itemBuilder: (context, index) {
          return PackageCard(
            packageName: 'Package $index',
            includedTests: ['Test 1', 'Test 2'],
            price: '₹2000',
          );
        },
      ),
    );
  }
}
