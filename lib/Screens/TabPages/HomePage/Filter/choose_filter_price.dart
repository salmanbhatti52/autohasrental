import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import '../../../../Utils/colors.dart';

class ChooseFilterPrice extends StatefulWidget {
  const ChooseFilterPrice({Key? key}) : super(key: key);

  @override
  State<ChooseFilterPrice> createState() => _ChooseFilterPriceState();
}

class _ChooseFilterPriceState extends State<ChooseFilterPrice> {
  List<PriceModel> priceData = <PriceModel>[];

  @override
  void initState() {
    super.initState();
    priceData.add(PriceModel(false, 'High to Low'));
    priceData.add(PriceModel(true, 'Low to High'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListView.builder(
        itemCount: priceData.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                priceData.forEach((element) => element.isSelected = false);
                priceData[index].isSelected = true;
              });
            },
            child: PriceItem(priceData[index]),
          );
        },
      ),
    );
  }
}

class PriceItem extends StatelessWidget {
  final PriceModel _item;
  const PriceItem(this._item, {super.key});
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

class PriceModel {
  bool isSelected;
  final String buttonText;

  PriceModel(
    this.isSelected,
    this.buttonText,
  );
}
