import 'package:flutter/material.dart';
import '../Screens/TabPages/BookingPage/booking_page.dart';
import '../Screens/TabPages/FavouritePage/favourite_page.dart';
import '../Screens/TabPages/HomePage/home_page.dart';
import '../Screens/TabPages/MessagePage/message_page.dart';
import '../Screens/TabPages/tab_page.dart';
import '../Utils/colors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  @override
  void initState() {
    super.initState();
  }

  List pages = [
    const HomePage(),
    const MessagePage(),
    const BookingPage(),
    const FavoritePage(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  Future<bool> backPressed() async {
    print("currentIndex $currentIndex");
    if (currentIndex != 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const TabBarPage()));
      print("currentIndex1111 $currentIndex");
      return false;
    }

    if (currentIndex == 0) {
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => const TabBarPage()));
      print("currentIndex1111 $currentIndex");
      return false;
    }

    // if(currentIndex == 0){
    //   return (await showDialog(
    //     context: context,
    //     builder: (context) =>
    //     AlertDialog(
    //       title: const Text('Are you sure?'),
    //       content: const Text('Do you want to exit an App'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () => Navigator.of(context).pop(false),
    //           child: const Text('No'),
    //         ),
    //         TextButton(
    //           onPressed: () =>
    //            Navigator.of(context).popUntil((route) => route.isFirst),
    //               // Navigator.of(context).pop(true),
    //           child: const Text('Yes'),
    //         ),
    //       ],
    //     ),
    //   )) ?? false;
    // }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: backPressed,
      child: Scaffold(
        body: Container(
          child: pages[currentIndex],
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: appBgColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)
              ),
          ),
          child: BottomNavigationBar(
              selectedItemColor: borderColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: onTap,
              backgroundColor: Colors.transparent,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/tab_images/home_image.png',
                    color: currentIndex == 0 ? borderColor : unSelectedTabColor,
                    width: 30,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/tab_images/messages_image.png',
                      color: currentIndex == 1 ? borderColor : unSelectedTabColor,
                      width: 30,
                    ),
                    label: 'Messages'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/tab_images/calendar_image.png',
                      color: currentIndex == 2 ? borderColor : unSelectedTabColor,
                      width: 30,
                    ),
                    label: 'Booking'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/tab_images/heart_image.png',
                        color: currentIndex == 3 ? borderColor : unSelectedTabColor,
                        width: 30),
                    label: 'Favorities'),
              ]),
        ),
      ),
    );
  }
}