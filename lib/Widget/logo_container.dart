import 'package:flutter/material.dart';
import 'colors.dart';

class LogoContainer extends StatefulWidget {
  const LogoContainer({super.key});

  @override
  State<LogoContainer> createState() => _LogoContainerState();
}

class _LogoContainerState extends State<LogoContainer> {
  List<FilterRadioModel> filterData = <FilterRadioModel>[];

  @override
  void initState() {
    super.initState();

    filterData.add(FilterRadioModel(true, 'assets/filter_images/tesla.png'));
    filterData.add(FilterRadioModel(false, 'assets/filter_images/ferrari.png'));
    filterData
        .add(FilterRadioModel(false, 'assets/filter_images/mercedes.png'));
    filterData.add(FilterRadioModel(false, 'assets/filter_images/honda.png'));
    filterData
        .add(FilterRadioModel(false, 'assets/filter_images/lamborghini.png'));
    filterData.add(FilterRadioModel(false, 'assets/filter_images/mclaren.png'));
    filterData
        .add(FilterRadioModel(false, 'assets/filter_images/rangerover.png'));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filterData.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              filterData.forEach((element) => element.isSelectedFilter = false);
              filterData[index].isSelectedFilter = true;
            });
          },
          child: FilterRadioItem(filterData[index]),
        );
      },
    );
  }
}

class FilterRadioItem extends StatelessWidget {
  final FilterRadioModel _item;
  const FilterRadioItem(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _item.isSelectedFilter ? kWhite : const Color(0xff3f4555),
            border: Border.all(
                width: 1.0,
                color:
                    _item.isSelectedFilter ? borderColor : Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              _item.image,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class FilterRadioModel {
  bool isSelectedFilter;
  final String image;

  FilterRadioModel(
    this.isSelectedFilter,
    this.image,
  );
}
