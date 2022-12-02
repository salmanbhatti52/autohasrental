import 'package:flutter/material.dart';
import '../../../Widget/colors.dart';
import '../HomePage/Drawer/drawer_screen.dart';
import 'BookingTabs/tabbar_bookings_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DrawerScreen()));
                    },
                    child: Image.asset(
                        'assets/car_bookings_images/side_menu.png',
                        width: 18,
                        height: 15),
                  ),
                  const SizedBox(width: 100),
                  Text(
                    "Bookings",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appBgColor),
                  ),
                ],
              ),
            ),
            const TabbarCarBooings(),
          ],
        ),
      ),
    );
  }
}
