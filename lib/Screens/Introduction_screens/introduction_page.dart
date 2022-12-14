import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/colors.dart';
import '../Authentication/LoginPage/login_page.dart';
import '../TabPages/Homepage/home_page.dart';
import 'introduction_model.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  int currentIndex = 0;
  PageController? pageController;
  List<IntroductionModel> screens = <IntroductionModel>[
    IntroductionModel(
      img: 'assets/intro_images/intro_image_one.png',
      text: "Greater Accessibility",
      desc: "Eliminating the barriers to EV \nownership through simplified \ncomprehensive solutions.",
      bg: Colors.white,
      button: const Color(0xFF4756DF),
    ),
    IntroductionModel(
      img: 'assets/intro_images/intro_image_two.png',
      text: "Ultimate Flexibility",
      desc: "Providing multiple, easy-to-\nsubscribe package plans to \nsuite any requirements..",
      bg: const Color(0xFF4756DF),
      button: Colors.white,
    ),
    IntroductionModel(
      img: 'assets/intro_images/intro_image_three.png',
      text: "Total Convenience",
      desc: "We aim to take the hassle of \ncar ownership with concierge \nservices that is stress-free.",
      bg: Colors.white,
      button: const Color(0xFF4756DF),
    ),
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }

  storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      // appBar: AppBar(
      //   title: const Text("On boarding Screen"),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screens.length,
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
                  Container(
                    height: 130,
                    color: Colors.transparent,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(screens[index].text,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0,
                            fontFamily: poppinBold, color: kWhite),),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                        Text(screens[index].desc,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0,
                              fontFamily: poppinLight, color: kWhite),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Image.asset(screens[index].img,
                  height: MediaQuery.of(context).size.height* 0.2,
                    width: MediaQuery.of(context).size.width,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.23),
                  Container(
                    height: 10.0,
                    color: Colors.transparent,
                    child: ListView.builder(
                      itemCount: screens.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 20 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == index ? introColor : introColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ]);
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {

                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                          if (index == screens.length - 1) {
                            // await _storeOnboardInfo();
                            MaterialPageRoute(builder: (context) => const HomePage());
                            // Navigator.pop(context);
                          }
                          pageController!.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.bounceIn,
                          );

                        },

                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text("Skip", style: TextStyle(fontSize: 15.0, color: kWhite,
                              fontFamily: poppinMedium),),
                        ]),
                      ),
                      InkWell(
                        onTap: () async {
                          print(index);
                          if (index == screens.length - 1) {
                            // await storeOnboardInfo();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                          }
                          pageController!.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.bounceIn,
                          );
                        },
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text("Next", style: TextStyle(
                              fontSize: 15.0, color: kWhite, fontFamily: poppinMedium),
                          ),
                        ]),
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}