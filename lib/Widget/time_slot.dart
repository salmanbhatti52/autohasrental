import 'package:flutter/material.dart';
import '../../../../../Utils/colors.dart';

class TimeSlotContainer extends StatefulWidget {
  TimeSlotContainer({super.key});

  @override
  State<TimeSlotContainer> createState() => _TimeSlotContainerState();
}

class _TimeSlotContainerState extends State<TimeSlotContainer> {
  List<TimeSlotRadioModel> timeslotData = <TimeSlotRadioModel>[];

  @override
  void initState() {
    super.initState();

    timeslotData.add(TimeSlotRadioModel(true, '09:00 to 10:00'));
    timeslotData.add(TimeSlotRadioModel(false, '12:00 to 13:00'));
    timeslotData.add(TimeSlotRadioModel(false, '14:00 to 15:00'));
    timeslotData.add(TimeSlotRadioModel(false, '17:00 to 18:00'));
    timeslotData.add(TimeSlotRadioModel(false, '19:00 to 20:00'));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1 / 0.45,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
        ),
        itemCount: timeslotData.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                timeslotData
                    .forEach((element) => element.isSelectedTimeSlot = false);
                timeslotData[index].isSelectedTimeSlot = true;
              });
            },
            child: TimeSlotRadioItem(timeslotData[index]),
          );
        });
  }
}

class TimeSlotRadioItem extends StatelessWidget {
  final TimeSlotRadioModel _item;
  TimeSlotRadioItem(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 45,
      decoration: BoxDecoration(
        color: kWhite,
        border: Border.all(
            width: 1.0,
            color: _item.isSelectedTimeSlot ? borderColor : Colors.transparent),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: 22,
            color: _item.isSelectedTimeSlot
                ? borderColor
                : Color(0xffd4dce1),
          ),
          // Image.asset(
          //   _item.image,
          // ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          Text(_item.text,
            style: TextStyle(
              fontSize: 10,
              fontFamily: _item.isSelectedTimeSlot
                  ? 'Poppins-Medium' : 'Poppins-Regular',
              color: _item.isSelectedTimeSlot
                  ? unSelectedTabColor : Color(0xffd4dce1),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeSlotRadioModel {
  bool isSelectedTimeSlot;
  final String text;

  TimeSlotRadioModel(
    this.isSelectedTimeSlot,
    this.text,
  );
}
