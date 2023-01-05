import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/hour_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../../Utils/colors.dart';
import '../../../../../../Widget/day_slot.dart';
import '../../../../../../Widget/time_slot.dart';

class BFWChooseSubscriptionPlan extends StatefulWidget {
  const BFWChooseSubscriptionPlan({Key? key}) : super(key: key);

  @override
  State<BFWChooseSubscriptionPlan> createState() => _BFWChooseSubscriptionPlanState();
}

class _BFWChooseSubscriptionPlanState extends State<BFWChooseSubscriptionPlan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 30.0,
            // width: 220.0,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('3 days 26 Dec 2022 - 28 Dec 2022',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: poppinRegular,
                        fontSize: 12.0,
                        color: kWhite)),
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          GestureDetector(
              onTap: () {
                showMaterialModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      controller: ModalScrollController.of(context),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: homeBgColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Select Booking Day and Time',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins-Bold',
                                      color: appBgColor),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            Text(
                              'December 2022',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-SemiBold',
                                  color: borderColor),
                              textAlign: TextAlign.left,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: const DaySlotContainer()),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Select Hours',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins-Bold',
                                      color: appBgColor),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                  child: const HourSlotContainer()),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'Select Available Time',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins-Bold',
                                      color: appBgColor),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                  child: const TimeSlotContainer()),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: loginButton('Update', context)),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          width: 1, color: borderColor),
                                    ),
                                    child: Center(
                                      child: Text('Cancel',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: borderColor,
                                              fontFamily: poppinRegular,
                                              fontSize: 18)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: SvgPicture.asset('assets/icon/edit_booking_icoon.svg')),
        ],
      ),
    );
  }
}
