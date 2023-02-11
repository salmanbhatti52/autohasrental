import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../Utils/colors.dart';
import '../Utils/fontFamily.dart';

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

    getToday();
  }

  String? currentDay;
  DateTime? pickDate;
  String valueDate = "Select Date";
  String? valueDay;

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // firstDate: DateTime(1980),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != pickDate) {
      valueDate = DateFormat('MMMM yyyy').format(picked);
      valueDay = DateFormat('EE, d').format(picked);
      setState(() {
        print("Selected Date is : $valueDate");
        print("Selected Day is : $valueDay");
      });
    }
  }

  getToday() {
    currentDay = DateFormat('EEEE d').format(DateTime.now());
    print('currentDay = $currentDay');

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            selectDate(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.keyboard_arrow_left, color: Color(0xffa5a5a5)),
              Text(valueDate,  textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14,
                  fontFamily: poppinSemiBold, color: borderColor),
              ),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xffa5a5a5),
              ),
            ],
          ),
        ),
       SizedBox(height: MediaQuery.of(context).size.height* 0.02),

       valueDay == null?
       Container(
         width: 120,
         height: 40,
         decoration: BoxDecoration(
           color: kWhite,
           borderRadius: BorderRadius.circular(15),
         ),
         child: Center(
           child: Text("$currentDay",
             style: TextStyle(fontSize: 14,
               fontFamily: poppinMedium, color: kBlack),
           ),
         ),
       ):
        Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color:  borderColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text("$valueDay",
              style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: kWhite ),
            ),
          ),
        ),

        // Container(
        //   height: MediaQuery.of(context).size.height *0.1,
        //   color: Colors.transparent,
        //   child: ListView.builder(
        //     itemCount: daySlotData.length,
        //     scrollDirection: Axis.horizontal,
        //     physics: const BouncingScrollPhysics(),
        //     itemBuilder: (BuildContext context, int index) {
        //       return InkWell(
        //         onTap: () {
        //           setState(() {
        //             daySlotData.forEach((element) => element.isSelectedDaySlot = false);
        //             daySlotData[index].isSelectedDaySlot = true;
        //           });
        //         },
        //         child: DaySlotRadioItem(daySlotData[index]),
        //       );
        //     },
        //   ),
        // ),

      ],
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
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(_item.text,
              style: TextStyle(fontSize: 11,
                fontFamily: _item.isSelectedDaySlot ? poppinMedium : poppinRegular,
                color: _item.isSelectedDaySlot ? kWhite : const Color(0xffd4dce1),
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
