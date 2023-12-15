import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Drawer/drawer_screen.dart';

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
        padding:  EdgeInsets.only(top: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // width: Get.width * 0.5,
              child: Text(
                title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20, fontFamily: poppinBold, color: kBlack),
              ),
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
