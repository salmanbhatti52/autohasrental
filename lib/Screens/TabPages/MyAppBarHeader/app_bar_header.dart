import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Drawer/drawer_screen.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MessagePage/message_details_screen.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Notifications/notification_screen.dart';

Widget myHeaderDrawer(BuildContext context, backImage, titleText, rightImage) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            print("clicked");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  DrawerScreen()));
          },
          child: Image.asset(
            backImage,
            height: 25,
            width: 25,
          ),
        ),
        Text(
          titleText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontFamily: poppinBold, color: kBlack),
        ),
        GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  NotificationsScreen()));
            },
            child: SvgPicture.asset(rightImage),
        ),
      ],
    ),
  );
}

class MyAppBarSingleImage extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String? backImage;
   MyAppBarSingleImage({Key? key, this.title = "", this.backImage})
      : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: GestureDetector(
        onTap: () {
          print("clicked");
          Navigator.pop(context);
        },
        child: Padding(
          padding:  EdgeInsets.only(top: 30),
          child: Image.asset(backImage!,
            height: 25, width: 25),
        ),
      ),
      title: Padding(
        padding:  EdgeInsets.only(top: 30),
        child: Text(title, textAlign: TextAlign.center, style: TextStyle(
                fontSize: 20, fontFamily: poppinBold, color: kBlack)),
      ),
      backgroundColor: homeBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarSingleImageWithText extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String? backImage;
   MyAppBarSingleImageWithText(
      {Key? key, this.title = "", this.subtitle = "", this.backImage})
      : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: GestureDetector(
        onTap: () {
          print("clicked");
          Navigator.pop(context);
        },
        child: Padding(
          padding:  EdgeInsets.only(top: 30, right: 0),
          child: Image.asset(
            backImage!,
            height: 25,
            width: 25,
          ),
        ),
      ),
      // leadingWidth: 80,
      title: Padding(
        padding:  EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, fontFamily: poppinBold, color: kBlack),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, fontFamily: poppinRegular, color: kBlack),
            ),
          ],
        ),
      ),
      backgroundColor: homeBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarSettingsPage extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String backImage;
   MyAppBarSettingsPage({
    Key? key,
    this.title = "",
    this.backImage = "",
  }) : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.light, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: GestureDetector(
        onTap: () {
          print("clicked");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  DrawerScreen()));
        },
        child: Padding(
          padding:  EdgeInsets.only(top: 30),
          child: Image.asset(
            backImage,
            height: 25,
            width: 25,
          ),
        ),
      ),
      leadingWidth: 80,
      title: Padding(
        padding:  EdgeInsets.only(top: 30),
        child: Text(title,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 20, fontFamily: poppinBold, color: kBlack)),
      ),
      backgroundColor: homeBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarAboutUsPage extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String backImage;
   MyAppBarAboutUsPage({
    Key? key,
    this.title = "",
    this.backImage = "",
  }) : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.light, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: GestureDetector(
        onTap: () {
          print("clicked");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  DrawerScreen()));
        },
        child: Padding(
          padding:  EdgeInsets.only(top: 30),
          child: Image.asset(
            backImage,
            height: 25,
            width: 25,
            color: kWhite,
          ),
        ),
      ),
      leadingWidth: 80,
      title: Padding(
        padding:  EdgeInsets.only(top: 30),
        child: Text(title,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite)),
      ),
      backgroundColor: appBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarSignUp extends StatelessWidget implements PreferredSizeWidget {
  final String title;
   MyAppBarSignUp({Key? key, this.title = ""}) : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.light, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      // leadingWidth: 80,
      title: Padding(
        padding:  EdgeInsets.only(top: 30),
        child: Text(title,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite)),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: appBgColor,
      // backgroundColor: kRed,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarDoubleImage extends StatelessWidget
    implements PreferredSizeWidget {
  final String? frontImage;
  final String title;
  final String? backImage;
   MyAppBarDoubleImage(
      {Key? key, this.frontImage, this.title = "", this.backImage})
      : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print("clicked");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  NotificationsScreen()));
          },
          child: Padding(
            padding:  EdgeInsets.only(top: 30, right: 20),
            child: SvgPicture.asset(
              backImage!,
              height: 25,
              width: 25,
            ),
          ),
        ),
      ],
      leading: GestureDetector(
        onTap: () {
          print("clicked");
          Navigator.pop(context);
        },
        child: Padding(
          padding:  EdgeInsets.only(top: 30),
          child: Image.asset(
            frontImage!,
            height: 25,
            width: 25,
          ),
        ),
      ),
      title: Padding(
        padding:  EdgeInsets.only(top: 30),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontFamily: poppinBold, color: kBlack)),
      ),
      backgroundColor: homeBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarDoubleImageRichText extends StatelessWidget implements PreferredSizeWidget {
  final String? frontImage;
  final String title;
  final String year;
  final String? backImage;

   MyAppBarDoubleImageRichText({
    Key? key,
    this.frontImage,
    this.title = "",
    this.year = "",
    this.backImage,
  }) : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print("clicked");
            Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  NotificationsScreen()));
          },
          child: Padding(
            padding:  EdgeInsets.only(top: 30, right: 20),
            child: Image.asset(backImage!,
              height: 25, width: 25,
            ),
          ),
        ),
      ],
      leading: GestureDetector(
        onTap: () {
          print("clicked");
          Navigator.pop(context);
        },
        child: Padding(
          padding:  EdgeInsets.only(top: 30),
          child: Image.asset(frontImage!,
            color: kWhite, height: 25, width: 25,
          ),
        ),
      ),
      // leadingWidth: 80,
      title: Padding(
        padding:  EdgeInsets.only(top: 30, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite),
                ),
                Text(year, style: TextStyle(fontSize: 20, fontFamily: poppinRegular, color: kWhite),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: appBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class EvSubscriptionsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? frontImage;
  final String title;
  final String year;
  final String? backImage;

   EvSubscriptionsAppBar({
    Key? key,
    this.frontImage,
    this.title = "",
    this.year = "",
    this.backImage,
  }) : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print("clicked");
            Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>  MessageDetailsScreen()));
          },
          child: Padding(
            padding:  EdgeInsets.only(top: 30, right: 20),
            child: Image.asset(backImage!,
              height: 25, width: 25,
            ),
          ),
        ),
      ],
      leading: GestureDetector(
        onTap: () {
          print("clicked");
          Navigator.pop(context);
        },
        child: Padding(
          padding:  EdgeInsets.only(top: 30),
          child: Image.asset(frontImage!,
            color: kWhite, height: 25, width: 25,
          ),
        ),
      ),
      // leadingWidth: 80,
      title: Padding(
        padding:  EdgeInsets.only(top: 30, right: 0),
        child: Column(
          children: [
            Row(
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),),
                Text(year, style: TextStyle(fontSize: 16, fontFamily: poppinRegular, color: kWhite),),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: appBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarDoubleImageForChats extends StatelessWidget
    implements PreferredSizeWidget {
  final String? frontImage;
  final String title;
  final String? profileImage;
   MyAppBarDoubleImageForChats(
      {Key? key, this.frontImage, this.profileImage, this.title = ""})
      : super(key: key);

  @override
  Size get preferredSize =>  Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:  SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: GestureDetector(
        onTap: () {
          print("clicked");
          Navigator.pop(context);
        },
        child: Padding(
          padding:  EdgeInsets.only(top: 30),
          child: Image.asset(
            frontImage!,
            height: 25,
            width: 25,
          ),
        ),
      ),
      title: Padding(
        padding:  EdgeInsets.only(top: 30, left: 50),
        child: Row(
          children: [
            Image.asset(profileImage!, width: 24, height: 24),
             SizedBox(width: 5),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, fontFamily: poppinBold, color: kBlack)),
          ],
        ),
      ),
      backgroundColor: homeBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
