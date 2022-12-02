import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:flutter/material.dart';
import '../../../../../../Widget/colors.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSingleImage(
        title: "Payment", backImage: "assets/messages_images/Back.png",),
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       GestureDetector(
            //         onTap:(){
            //           Navigator.pop(context);
            //         },
            //         child: Image.asset("assets/messages_images/Back.png", height: 25, width: 25,),),
            //
            //       Text("Payment",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kBlack),),
            //
            //       Container(),
            //     ],
            //   ),
            // ),
            //
            // SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

            Image.asset("assets/drawer_images/payment_page.png"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Saved Payment Methods", style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: kBlack),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                  paymentWidget("Owner name", "4162 **** **** ****", "assets/payment_card_images/mastercard_icon.png"),
                  paymentWidget("Owner name", "4162 **** **** ****", "assets/payment_card_images/294654_visa_icon.png"),
                  paymentWidget("PayPal", "Arslan********mail.com", "assets/payment_card_images/paypal_icon.png"),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

            loginButton("Add New Payment Method", context),
          ],
        ),
      ),
    );
  }

  Widget paymentWidget(titleText, subTitleText, paymentImage){
    return
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 05),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(titleText, textAlign: TextAlign.left, style: TextStyle(color: kBlack,
                      fontFamily: 'Urbanist', fontWeight: FontWeight.w500, fontSize: 17)),
                  const SizedBox(height: 05,),
                  Text(subTitleText,  textAlign: TextAlign.left, style: const TextStyle(color: Color(0xffB0B0B0),
                      fontFamily: 'Urbanist', fontWeight: FontWeight.w400, fontSize: 14)),
                ],
              ),
              // SizedBox(width: MediaQuery.of(context).size.width * 0.13),

              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      Image.asset("assets/payment_card_images/recycle_icon.png"),
                      // Image.asset("assets/payment_card_images/mastercard_icon.png"),
                      // Image.asset("assets/payment_card_images/paypal_icon.png"),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                      Text("Delete", textAlign: TextAlign.left, style: TextStyle(color: kRed,
                          fontFamily: 'Urbanist', fontWeight: FontWeight.w500, fontSize: 14)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Image.asset(paymentImage, width: 50,),
                ],
              ),

            ],
          ),
        ),
      );
  }

}
