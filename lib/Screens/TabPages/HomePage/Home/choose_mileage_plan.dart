import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';

class ChooseMileagePlan extends StatefulWidget {
  const ChooseMileagePlan({Key? key}) : super(key: key);

  @override
  State<ChooseMileagePlan> createState() => _ChooseMileagePlanState();
}

class _ChooseMileagePlanState extends State<ChooseMileagePlan> {
  List<MileageRadioModel> mileageData = <MileageRadioModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mileageData.add(MileageRadioModel(false, 'Lite - 1250km'));
    mileageData.add(MileageRadioModel(false, 'Standard - 1,250km'));
    mileageData.add(MileageRadioModel(false, 'Unlimited'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1/0.2,
              mainAxisSpacing: 02,
              crossAxisSpacing: 0,
            ),
            itemCount: mileageData.length,
            itemBuilder: (BuildContext context, int index){
              return InkWell(
                onTap: () {
                  setState(() {
                    mileageData.forEach((element) => element.isSelectedMileage = false);
                    mileageData[index].isSelectedMileage = true;
                  });
                },
                child: MileageRadioItem(mileageData[index]),
              );
            }),
      ),
    );
  }
}
class MileageRadioItem extends StatelessWidget {
  final MileageRadioModel _item;
  const MileageRadioItem(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 05, top: 05),
      // height: MediaQuery.of(context).size.height * 0.02,
      // width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        color: _item.isSelectedMileage ? borderColor : kWhite,
        border: Border.all(width: 1.0, color: _item.isSelectedMileage ? borderColor : kWhite),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Text(_item.buttonText,
                  textAlign: TextAlign.left, style: TextStyle(
                  fontFamily: poppinRegular, fontSize: 12.0,
                  color: _item.isSelectedMileage ? kWhite : textLabelColor)),
        ),
      ),
    );
  }
}

class MileageRadioModel {
  bool isSelectedMileage;
  final String buttonText;

  MileageRadioModel(this.isSelectedMileage, this.buttonText,);
}

