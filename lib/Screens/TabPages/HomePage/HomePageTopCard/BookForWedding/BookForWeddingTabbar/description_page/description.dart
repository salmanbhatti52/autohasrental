import 'package:flutter/material.dart';
import '../../../../../../../Model/HomePageModels/HomePageTopWidgetModels/car_photography_model.dart';
import '../../../../../../../Utils/api_urls.dart';
import '../../../../../../../Utils/colors.dart';
import '../../../../../../../Utils/constants.dart';
import '../../../../../../../Utils/fontFamily.dart';
import 'package:http/http.dart'as http;

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {

  CarsPhotoGraphyModel carsPhotoGraphyModelObject = CarsPhotoGraphyModel();
  bool loadingP = true;
  @override
  void initState() {
    super.initState();
    getCarsPhotoGraphyWidget();
  }

  getCarsPhotoGraphyWidget() async {
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = carsPhotoGraphyApiUrl;
      print("carsPhotographyApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id" : userId
          },
          headers: {'Accept': 'application/json'});
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("carsPhotoGraphyResponse: ${responseString.toString()}");
        carsPhotoGraphyModelObject = carsPhotoGraphyModelFromJson(responseString);
        print("carsPhotoGraphyObjectLength: ${carsPhotoGraphyModelObject.status}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Text(
            "${carsPhotoGraphyModelObject.data![0].description}",
            style: TextStyle(
                fontSize: 12,
                fontFamily: poppinRegular,
                color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
