import 'package:flutter/material.dart';
import '../../../../../Utils/colors.dart';

class DaySlotContainer extends StatefulWidget {
  const DaySlotContainer({super.key});

  @override
  State<DaySlotContainer> createState() => _DaySlotContainerState();
}

class _DaySlotContainerState extends State<DaySlotContainer> {
  List<DaySlotRadioModel> dayslotData = <DaySlotRadioModel>[];

  @override
  void initState() {
    super.initState();

    dayslotData.add(DaySlotRadioModel(true, 'Mon'));
    dayslotData.add(DaySlotRadioModel(false, 'Tue'));
    dayslotData.add(DaySlotRadioModel(false, 'Wed'));
    dayslotData.add(DaySlotRadioModel(false, 'Thu'));
    dayslotData.add(DaySlotRadioModel(false, 'Fri'));
    dayslotData.add(DaySlotRadioModel(false, 'Sat'));
    dayslotData.add(DaySlotRadioModel(false, 'Sun'));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dayslotData.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              dayslotData
                  .forEach((element) => element.isSelectedDaySlot = false);
              dayslotData[index].isSelectedDaySlot = true;
            });
          },
          child: DaySlotRadioItem(dayslotData[index]),
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
