import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';

import '../../../../Utils/colors.dart';

class ChooseSubscriptionPlan extends StatefulWidget {
  const ChooseSubscriptionPlan({Key? key}) : super(key: key);

  @override
  State<ChooseSubscriptionPlan> createState() => _ChooseSubscriptionPlanState();
}

class _ChooseSubscriptionPlanState extends State<ChooseSubscriptionPlan> {
  List<SubscriptionRadioModel> sampleData = <SubscriptionRadioModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(SubscriptionRadioModel(false, '12 Months'));
    sampleData.add(SubscriptionRadioModel(false, '24 Months'));
    sampleData.add(SubscriptionRadioModel(false, '36 Months'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 50,
      child: ListView.builder(
        itemCount: sampleData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            //highlightColor: Colors.red,
            // splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;

                // for (var element in sampleData) {
                //   element.isSelected = false;
                // }
                // sampleData[index].isSelected = true;

              });
            },
            child: SubscriptionRadioItem(sampleData[index]),
          );
        },
      ),
    );
  }
}
class SubscriptionRadioItem extends StatelessWidget {
  final SubscriptionRadioModel _item;
  const SubscriptionRadioItem(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 30.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: _item.isSelected ? borderColor : kWhite,
              border: Border.all(width: 1.0,
                  color: _item.isSelected ? borderColor : kWhite),
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(color: borderColor)
            ),
            child: Center(
              child: Text(_item.buttonText,
                      textAlign: TextAlign.left, style: TextStyle(
                      fontFamily: poppinRegular, fontSize: 12.0,
                      color: _item.isSelected ? kWhite : textLabelColor)),
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionRadioModel {
  bool isSelected;
  final String buttonText;

  SubscriptionRadioModel(this.isSelected, this.buttonText,);
}

