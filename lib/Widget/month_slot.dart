import 'package:flutter/material.dart';
import '../../../../../../../Utils/colors.dart';
import '../../../../../../../Utils/fontFamily.dart';

class MonthSlotContainer extends StatefulWidget {
  const MonthSlotContainer({super.key});

  @override
  State<MonthSlotContainer> createState() => _MonthSlotContainerState();
}

class _MonthSlotContainerState extends State<MonthSlotContainer> {
  List<MonthSlotRadioModel> monthSlotData = <MonthSlotRadioModel>[];

  @override
  void initState() {
    super.initState();

    monthSlotData.add(MonthSlotRadioModel(true, '48 Months', 'RM 6,365'));
    monthSlotData.add(MonthSlotRadioModel(false, '60 Months', 'RM 5,225'));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: monthSlotData.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              monthSlotData
                  .forEach((element) => element.isSelectedMonthSlot = false);
              monthSlotData[index].isSelectedMonthSlot = true;
            });
          },
          child: MonthSlotRadioItem(monthSlotData[index]),
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
  final String title;
  final String subtitle;

  MonthSlotRadioModel(
    this.isSelectedMonthSlot,
    this.title,
    this.subtitle,
  );
}
