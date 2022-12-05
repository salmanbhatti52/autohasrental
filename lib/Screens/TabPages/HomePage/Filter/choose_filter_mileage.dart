import 'package:auto_haus_rental_app/Widget/fontFamily.dart';
import 'package:flutter/material.dart';
import '../../../../Widget/colors.dart';

class ChooseFilterMileage extends StatefulWidget {
  const ChooseFilterMileage({Key? key}) : super(key: key);

  @override
  State<ChooseFilterMileage> createState() => _ChooseFilterMileageState();
}

class _ChooseFilterMileageState extends State<ChooseFilterMileage> {
  List<MileageModel> filterMileageData = <MileageModel>[];

  @override
  void initState() {
    super.initState();
    filterMileageData.add(MileageModel(false, 'High to Low'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListView.builder(
        itemCount: filterMileageData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                filterMileageData.forEach((element) => element.isSelected = false);
                filterMileageData[index].isSelected = true;
              });
            },
            child: MileageItem(filterMileageData[index]),
          );
        },
      ),
    );
  }
}

class MileageItem extends StatelessWidget {
  final MileageModel _item;
  const MileageItem(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.28,
            decoration: BoxDecoration(
              color: _item.isSelected ? borderColor : Colors.transparent,
              border: Border.all(
                  width: 1.0,
                  color: _item.isSelected ? kWhite : const Color(0xff8d8d8d)),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(_item.buttonText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: poppinRegular,
                      fontSize: 12,
                      color: _item.isSelected ? kWhite : textLabelColor)),
            ),
          ),
        ],
      ),
    );
  }
}

class MileageModel {
  bool isSelected;
  final String buttonText;

  MileageModel(
    this.isSelected,
    this.buttonText,
  );
}
