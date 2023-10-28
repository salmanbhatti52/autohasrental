import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';

class KYCSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KYC Verification'),
        centerTitle: true,
        backgroundColor: borderColor,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Choose Your Verification Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the ID document verification screen
                // You can replace this with the actual navigation logic
                // for starting ID document verification.
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(200, 50),
              ),
              child: Text(
                'Face Verification',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the ID document verification screen
                // You can replace this with the actual navigation logic
                // for starting ID document verification.
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(200, 50),
              ),
              child: Text(
                'ID Document Verification',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}