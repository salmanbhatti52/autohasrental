import 'package:flutter/material.dart';
import '../../../../../../../Utils/colors.dart';
import '../../../../../../../Utils/fontFamily.dart';

class MonthSlotContainer extends StatefulWidget {
  const MonthSlotContainer({super.key});

  @override
  State<MonthSlotContainer> createState() => _MonthSlotContainerState();
}

class _MonthSlotContainerState extends State<MonthSlotContainer> {
  List<MonthSlotRadioModel> monthslotData = <MonthSlotRadioModel>[];

  @override
  void initState() {
    super.initState();

    monthslotData.add(MonthSlotRadioModel(
        true,
        // 'assets/car_description_images/white_tick.png',
        '48 Months',
        'RM 6,365'));
    monthslotData.add(MonthSlotRadioModel(
      false,
      // 'assets/car_description_images/grey_tick.png',
      '60 Months',
      'RM 5,225',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: monthslotData.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              monthslotData
                  .forEach((element) => element.isSelectedMonthSlot = false);
              monthslotData[index].isSelectedMonthSlot = true;
            });
          },
          child: MonthSlotRadioItem(monthslotData[index]),
        );
      },
    );
  }
}

class MonthSlotRadioItem extends StatelessWidget {
  final MonthSlotRadioModel _item;
  const MonthSlotRadioItem(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 70,
        width: 165,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: _item.isSelectedMonthSlot ? borderColor : kWhite,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 22,
              color:
                  _item.isSelectedMonthSlot ? kWhite : const Color(0xffd4dce1),
            ),
            // Image.asset(
            //   _item.imageurl,
            //   width: 22,
            //   height: 22,
            // ),
            const SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.6),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      _item.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: poppinMedium,
                        color: _item.isSelectedMonthSlot ? kWhite : kBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      _item.subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: poppinRegular,
                        color: _item.isSelectedMonthSlot
                            ? kWhite
                            : const Color(0xffd4dce1),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MonthSlotRadioModel {
  bool isSelectedMonthSlot;
  // final String imageurl;
  final String title;
  final String subtitle;

  MonthSlotRadioModel(
    this.isSelectedMonthSlot,
    // this.imageurl,
    this.title,
    this.subtitle,
  );
}
