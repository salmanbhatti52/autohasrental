//
// import 'dart:convert';
//
// FavoriteCarModel favoriteCarModelFromJson(String str) => FavoriteCarModel.fromJson(json.decode(str));
//
// String favoriteCarModelToJson(FavoriteCarModel data) => json.encode(data.toJson());
//
// class FavoriteCarModel {
//   FavoriteCarModel({
//     this.status,
//     this.data,
//   });
//
//   String? status;
//   List<Datum>? data;
//
//   factory FavoriteCarModel.fromJson(Map<String, dynamic> json) => FavoriteCarModel(
//     status: json["status"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     this.carsId,
//     this.carsUsageType,
//     this.usersCompaniesId,
//     this.carsTypeId,
//     this.carsMakesId,
//     this.carsModelsId,
//     this.year,
//     this.vehicalName,
//     this.licensePlate,
//     this.discountPercentage,
//     this.description,
//     this.featuresSuv,
//     this.features2Doors,
//     this.features5Seats,
//     this.featuresAutomatic,
//     this.featuresAwd,
//     this.featuresElectric,
//     this.featuresTbd,
//     this.featuresNewCars,
//     this.rating,
//     this.image1,
//     this.image2,
//     this.image3,
//     this.image4,
//     this.image5,
//     this.dateAdded,
//     this.dateModified,
//     this.status,
//   });
//
//   int? carsId;
//   String? carsUsageType;
//   int? usersCompaniesId;
//   int? carsTypeId;
//   int? carsMakesId;
//   int? carsModelsId;
//   int? year;
//   String? vehicalName;
//   String? licensePlate;
//   String? discountPercentage;
//   String? description;
//   String? featuresSuv;
//   String? features2Doors;
//   String? features5Seats;
//   String? featuresAutomatic;
//   String? featuresAwd;
//   String? featuresElectric;
//   String? featuresTbd;
//   String? featuresNewCars;
//   String? rating;
//   String? image1;
//   String? image2;
//   String? image3;
//   String? image4;
//   String? image5;
//   DateTime? dateAdded;
//   DateTime? dateModified;
//   String? status;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     carsId: json["cars_id"],
//     carsUsageType: json["cars_usage_type"],
//     usersCompaniesId: json["users_companies_id"],
//     carsTypeId: json["cars_type_id"],
//     carsMakesId: json["cars_makes_id"],
//     carsModelsId: json["cars_models_id"],
//     year: json["year"],
//     vehicalName: json["vehical_name"],
//     licensePlate: json["license_plate"],
//     discountPercentage: json["discount_percentage"],
//     description: json["description"],
//     featuresSuv: json["features_suv"],
//     features2Doors: json["features_2doors"],
//     features5Seats: json["features_5seats"],
//     featuresAutomatic: json["features_automatic"],
//     featuresAwd: json["features_awd"],
//     featuresElectric: json["features_electric"],
//     featuresTbd: json["features_tbd"],
//     featuresNewCars: json["features_new_cars"],
//     rating: json["rating"],
//     image1: json["image1"],
//     image2: json["image2"],
//     image3: json["image3"],
//     image4: json["image4"],
//     image5: json["image5"],
//     dateAdded: DateTime.parse(json["date_added"]),
//     dateModified: DateTime.parse(json["date_modified"]),
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cars_id": carsId,
//     "cars_usage_type": carsUsageType,
//     "users_companies_id": usersCompaniesId,
//     "cars_type_id": carsTypeId,
//     "cars_makes_id": carsMakesId,
//     "cars_models_id": carsModelsId,
//     "year": year,
//     "vehical_name": vehicalName,
//     "license_plate": licensePlate,
//     "discount_percentage": discountPercentage,
//     "description": description,
//     "features_suv": featuresSuv,
//     "features_2doors": features2Doors,
//     "features_5seats": features5Seats,
//     "features_automatic": featuresAutomatic,
//     "features_awd": featuresAwd,
//     "features_electric": featuresElectric,
//     "features_tbd": featuresTbd,
//     "features_new_cars": featuresNewCars,
//     "rating": rating,
//     "image1": image1,
//     "image2": image2,
//     "image3": image3,
//     "image4": image4,
//     "image5": image5,
//     "date_added": dateAdded!.toIso8601String(),
//     "date_modified": dateModified!.toIso8601String(),
//     "status": status,
//   };
// }

class FavoriteCarModel {
  int? carsId;
  String? carsUsageType;
  int? usersCompaniesId;
  int? carsTypeId;
  int? carsMakesId;
  int? carsModelsId;
  int? year;
  String? vehicalName;
  String? licensePlate;
  String? discountPercentage;
  String? description;
  String? featuresSuv;
  String? features2doors;
  String? features5seats;
  String? featuresAutomatic;
  String? featuresAwd;
  String? featuresElectric;
  String? featuresTbd;
  String? featuresNewCars;
  String? rating;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? image5;
  String? dateAdded;
  String? dateModified;
  String? status;

  FavoriteCarModel(
      {this.carsId,
        this.carsUsageType,
        this.usersCompaniesId,
        this.carsTypeId,
        this.carsMakesId,
        this.carsModelsId,
        this.year,
        this.vehicalName,
        this.licensePlate,
        this.discountPercentage,
        this.description,
        this.featuresSuv,
        this.features2doors,
        this.features5seats,
        this.featuresAutomatic,
        this.featuresAwd,
        this.featuresElectric,
        this.featuresTbd,
        this.featuresNewCars,
        this.rating,
        this.image1,
        this.image2,
        this.image3,
        this.image4,
        this.image5,
        this.dateAdded,
        this.dateModified,
        this.status});

  FavoriteCarModel.fromJson(Map<String, dynamic> json) {
    carsId = json['cars_id'];
    carsUsageType = json['cars_usage_type'];
    usersCompaniesId = json['users_companies_id'];
    carsTypeId = json['cars_type_id'];
    carsMakesId = json['cars_makes_id'];
    carsModelsId = json['cars_models_id'];
    year = json['year'];
    vehicalName = json['vehical_name'];
    licensePlate = json['license_plate'];
    discountPercentage = json['discount_percentage'];
    description = json['description'];
    featuresSuv = json['features_suv'];
    features2doors = json['features_2doors'];
    features5seats = json['features_5seats'];
    featuresAutomatic = json['features_automatic'];
    featuresAwd = json['features_awd'];
    featuresElectric = json['features_electric'];
    featuresTbd = json['features_tbd'];
    featuresNewCars = json['features_new_cars'];
    rating = json['rating'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    image5 = json['image5'];
    dateAdded = json['date_added'];
    dateModified = json['date_modified'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cars_id'] = this.carsId;
    data['cars_usage_type'] = this.carsUsageType;
    data['users_companies_id'] = this.usersCompaniesId;
    data['cars_type_id'] = this.carsTypeId;
    data['cars_makes_id'] = this.carsMakesId;
    data['cars_models_id'] = this.carsModelsId;
    data['year'] = this.year;
    data['vehical_name'] = this.vehicalName;
    data['license_plate'] = this.licensePlate;
    data['discount_percentage'] = this.discountPercentage;
    data['description'] = this.description;
    data['features_suv'] = this.featuresSuv;
    data['features_2doors'] = this.features2doors;
    data['features_5seats'] = this.features5seats;
    data['features_automatic'] = this.featuresAutomatic;
    data['features_awd'] = this.featuresAwd;
    data['features_electric'] = this.featuresElectric;
    data['features_tbd'] = this.featuresTbd;
    data['features_new_cars'] = this.featuresNewCars;
    data['rating'] = this.rating;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['image4'] = this.image4;
    data['image5'] = this.image5;
    data['date_added'] = this.dateAdded;
    data['date_modified'] = this.dateModified;
    data['status'] = this.status;
    return data;
  }
}