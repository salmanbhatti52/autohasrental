import 'package:flutter/material.dart';
import '../../../../../Utils/colors.dart';

class HourSlotContainer extends StatefulWidget {
  const HourSlotContainer({super.key});

  @override
  State<HourSlotContainer> createState() => _HourSlotContainerState();
}

class _HourSlotContainerState extends State<HourSlotContainer> {
  List<HourSlotRadioModel> hourslotData = <HourSlotRadioModel>[];

  @override
  void initState() {
    super.initState();

    hourslotData.add(HourSlotRadioModel(true, '4 hours'));
    hourslotData.add(HourSlotRadioModel(false, '8 hours'));
    hourslotData.add(HourSlotRadioModel(false, '12 hours'));
    hourslotData.add(HourSlotRadioModel(false, '16 hours'));
    hourslotData.add(HourSlotRadioModel(false, '24 hours'));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 0.45,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: hourslotData.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(
              () {
                hourslotData
                    .forEach((element) => element.isSelectedHourSlot = false);
                hourslotData[index].isSelectedHourSlot = true;
              },
            );
          },
          child: HourSlotRadioItem(hourslotData[index]),
        );
      },
    );
  }
}

class HourSlotRadioItem extends StatelessWidget {
  final HourSlotRadioModel _item;
  const HourSlotRadioItem(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 45,
      decoration: BoxDecoration(
        color: kWhite,
        border: Border.all(
            width: 1.0,
            color: _item.isSelectedHourSlot ? borderColor : Colors.transparent),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(
              Icons.check_circle,
              size: 22,
              color: _item.isSelectedHourSlot
                  ? borderColor
                  : const Color(0xffd4dce1),
            ),
          ),
          // Image.asset(
          //   _item.image,
          // ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          Text(
            _item.text,
            style: TextStyle(
              fontSize: 10,
              fontFamily: _item.isSelectedHourSlot
                  ? 'Poppins-Medium'
                  : 'Poppins-Regular',
              color: _item.isSelectedHourSlot
                  ? unSelectedTabColor
                  : const Color(0xffd4dce1),
            ),
          ),
        ],
      ),
    );
  }
}

class HourSlotRadioModel {
  bool isSelectedHourSlot;
  final String text;

  HourSlotRadioModel(
    this.isSelectedHourSlot,
    this.text,
  );
}
