import 'package:flutter/material.dart';
import '../../../../../../Widget/colors.dart';
import '../../../../../../Widget/fontFamily.dart';
import 'CartDetails/cart_details_page.dart';

class BillingAddressPage extends StatefulWidget {
  const BillingAddressPage({Key? key}) : super(key: key);

  @override
  State<BillingAddressPage> createState() => _BillingAddressPageState();
}

class _BillingAddressPageState extends State<BillingAddressPage> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(unselectedWidgetColor: Color(0xffD4DCE1),),
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: kWhite,
                    checkColor: borderColor,
                    value: checkBoxValue,
                    onChanged: (bool? value) {
                      setState(() {
                        checkBoxValue = value!;
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.transparent,
                  child: Text('My billing address is different from my home address', textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(color: textLabelColor, fontSize: 12, fontFamily: poppinRegular,),
                  ),
                ), //Text
              ], //<Widget>[]
            ),
            // Theme(
            //   data: ThemeData(unselectedWidgetColor: const Color(0xffD4DCE1)),
            //   child: CheckboxListTile(
            //     title: Text("My billing address is different from my home address",
            //       style: TextStyle(color: textLabelColor, fontSize: 12,
            //         fontWeight: FontWeight.w400, fontFamily: 'Poppins',),),
            //     controlAffinity: ListTileControlAffinity.leading,
            //     contentPadding: EdgeInsets.zero,
            //     dense: true,
            //     value: checkBoxValue,
            //     // side: BorderSide(color: borderColor),
            //     activeColor: kWhite,
            //     checkColor: borderColor,
            //     onChanged: (bool? value) {
            //       setState(() {
            //         checkBoxValue = value!;
            //       });
            //     },
            //   ),
            // ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),

            Image.asset("assets/home_page/empty-cart.png",),

            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartDetailsPage()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    color: kRed,
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Text("Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
