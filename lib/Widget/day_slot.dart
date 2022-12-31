import 'package:flutter/material.dart';
import '../../../../../Utils/colors.dart';

class DaySlotContainer extends StatefulWidget {
  const DaySlotContainer({super.key});

  @override
  State<DaySlotContainer> createState() => _DaySlotContainerState();
}

class _DaySlotContainerState extends State<DaySlotContainer> {
  List<DaySlotRadioModel> daySlotData = <DaySlotRadioModel>[];

  @override
  void initState() {
    super.initState();

    daySlotData.add(DaySlotRadioModel(true, 'Mon'));
    daySlotData.add(DaySlotRadioModel(false, 'Tue'));
    daySlotData.add(DaySlotRadioModel(false, 'Wed'));
    daySlotData.add(DaySlotRadioModel(false, 'Thu'));
    daySlotData.add(DaySlotRadioModel(false, 'Fri'));
    daySlotData.add(DaySlotRadioModel(false, 'Sat'));
    daySlotData.add(DaySlotRadioModel(false, 'Sun'));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: daySlotData.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              daySlotData.forEach((element) => element.isSelectedDaySlot = false);
              daySlotData[index].isSelectedDaySlot = true;
            });
          },
          child: DaySlotRadioItem(daySlotData[index]),
        );
      },
    );
  }
}

class DaySlotRadioItem extends StatelessWidget {
  final DaySlotRadioModel _item;
  const DaySlotRadioItem(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _item.isSelectedDaySlot ? borderColor : kWhite,
            // border: Border.all(
            //     width: 1.0,
            //     color:
            //         _item.isSelectedDaySlot ? borderColor : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              _item.text,
              style: TextStyle(
                fontSize: 11,
                fontFamily: _item.isSelectedDaySlot
                    ? 'Poppins-Medium'
                    : 'Poppins-Regular',
                color:
                    _item.isSelectedDaySlot ? kWhite : const Color(0xffd4dce1),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class DaySlotRadioModel {
  bool isSelectedDaySlot;
  final String text;

  DaySlotRadioModel(
    this.isSelectedDaySlot,
    this.text,
  );
}
