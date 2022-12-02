import 'package:auto_haus_rental_app/Widget/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Widget/colors.dart';
import '../HomePage/Drawer/drawer_screen.dart';
import '../HomePage/Notifications/notification_screen.dart';

Widget myHeaderDrawer(BuildContext context, backImage,titleText, rightImage ){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap:(){
            print("clicked");
            Navigator.push(context, MaterialPageRoute(builder: (context) => const DrawerScreen()));
          },
          child: Image.asset(
            backImage, height: 25, width: 25,),),

        Text(titleText, textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold', color: kBlack),),

        GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
            },
            child: Image.asset(rightImage)),
      ],
    ),
  );
}

Widget myHeaderNotification(BuildContext context, backImage,titleText, rightImage ){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap:(){
            print("clicked");
            Navigator.pop(context);
          },
          child: Image.asset(
            backImage, height: 25, width: 25,),),

        Text(titleText, textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold', color: kBlack),),

       Container(),
      ],
    ),
  );
}

class MyAppBarSingleImage extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final String? backImage;
  const MyAppBarSingleImage({Key? key,this.title="", this.backImage}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness: Brightness.light, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: GestureDetector(
        onTap:(){
          print("clicked");
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Image.asset(
            backImage!, height: 25, width: 25,),
        ),),
      leadingWidth: 80,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(title, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: 'Poppins-Bold', color: kBlack)),
      ),
      backgroundColor: homeBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarSettingsPage extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final String backImage;
  const MyAppBarSettingsPage({Key? key,this.title="", this.backImage = "",}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness: Brightness.light, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: GestureDetector(
        onTap:(){
          print("clicked");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const DrawerScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Image.asset(
            backImage, height: 25, width: 25,),
        ),),
      leadingWidth: 80,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(title, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kBlack)),
      ),
      backgroundColor: homeBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarAboutUsPage extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final String backImage;
  const MyAppBarAboutUsPage({Key? key,this.title="", this.backImage = "",}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness: Brightness.light, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      leading: GestureDetector(
        onTap:(){
          print("clicked");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const DrawerScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Image.asset(
            backImage, height: 25, width: 25, color: kWhite,),
        ),),
      leadingWidth: 80,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(title, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite)),
      ),
      backgroundColor: appBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

class MyAppBarSignUp extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const MyAppBarSignUp({Key? key,this.title=""}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness: Brightness.light, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      // leadingWidth: 80,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(title, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kWhite)),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: appBgColor,
      // backgroundColor: kRed,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}


class myAppBarDoubleImage extends StatelessWidget
    implements PreferredSizeWidget {
  final String? frontImage;
  final String title;
  final String? backImage;
  const myAppBarDoubleImage(
      {Key? key, this.frontImage, this.title = "", this.backImage})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // <-- SEE HERE
        statusBarIconBrightness:
        Brightness.light, //<-- For Android SEE HERE (dark icons)
        statusBarBrightness:
        Brightness.light, //<-- For iOS SEE HERE (dark icons)
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print("clicked");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Image.asset(
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
          padding: const EdgeInsets.only(top: 30),
          child: Image.asset(
            frontImage!,
            height: 25,
            width: 25,
          ),
        ),
      ),
      leadingWidth: 80,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Poppins-Bold', color: kBlack)),
      ),
      backgroundColor: homeBgColor,
      elevation: 0.0,
      centerTitle: true,
    );
  }
}

