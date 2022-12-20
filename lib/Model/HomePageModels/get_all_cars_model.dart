// class Data {
//   int? carsId;
//   int? usersCompaniesId;
//   int? carsTypeId;
//   int? carsMakesId;
//   int? carsModelsId;
//   int? year;
//   String? vehicalName;
//   String? licensePlate;
//   String? rentCostDay;
//   String? rentCostMonth;
//   String? oldRentCostDay;
//   String? oldRentCostMonth;
//   String? discountPercentage;
//   String? image1;
//   String? image2;
//   String? image3;
//   String? image4;
//   String? image5;
//   String? description;
//   String? features;
//   String? rating;
//   String? dateAdded;
//   String? dateModified;
//   String? status;
//   CarsMakes? carsMakes;
//   CarsModels? carsModels;
//   List<Null>? carsRatings;
//
//   Data(
//       {this.carsId,
//         this.usersCompaniesId,
//         this.carsTypeId,
//         this.carsMakesId,
//         this.carsModelsId,
//         this.year,
//         this.vehicalName,
//         this.licensePlate,
//         this.rentCostDay,
//         this.rentCostMonth,
//         this.oldRentCostDay,
//         this.oldRentCostMonth,
//         this.discountPercentage,
//         this.image1,
//         this.image2,
//         this.image3,
//         this.image4,
//         this.image5,
//         this.description,
//         this.features,
//         this.rating,
//         this.dateAdded,
//         this.dateModified,
//         this.status,
//         this.carsMakes,
//         this.carsModels,
//         this.carsRatings});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     carsId = json['cars_id'];
//     usersCompaniesId = json['users_companies_id'];
//     carsTypeId = json['cars_type_id'];
//     carsMakesId = json['cars_makes_id'];
//     carsModelsId = json['cars_models_id'];
//     year = json['year'];
//     vehicalName = json['vehical_name'];
//     licensePlate = json['license_plate'];
//     rentCostDay = json['rent_cost_day'];
//     rentCostMonth = json['rent_cost_month'];
//     oldRentCostDay = json['old_rent_cost_day'];
//     oldRentCostMonth = json['old_rent_cost_month'];
//     discountPercentage = json['discount_percentage'];
//     image1 = json['image1'];
//     image2 = json['image2'];
//     image3 = json['image3'];
//     image4 = json['image4'];
//     image5 = json['image5'];
//     description = json['description'];
//     features = json['features'];
//     rating = json['rating'];
//     dateAdded = json['date_added'];
//     dateModified = json['date_modified'];
//     status = json['status'];
//     carsMakes = json['cars_makes'] != null
//         ? CarsMakes.fromJson(json['cars_makes'])
//         : null;
//     carsModels = json['cars_models'] != null
//         ? CarsModels.fromJson(json['cars_models'])
//         : null;
//     if (json['cars_ratings'] != null) {
//       carsRatings = <Null>[];
//       json['cars_ratings'].forEach((v) {
//         carsRatings!.add(Null.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['cars_id'] = carsId;
//     data['users_companies_id'] = usersCompaniesId;
//     data['cars_type_id'] = carsTypeId;
//     data['cars_makes_id'] = carsMakesId;
//     data['cars_models_id'] = carsModelsId;
//     data['year'] = year;
//     data['vehical_name'] = vehicalName;
//     data['license_plate'] = licensePlate;
//     data['rent_cost_day'] = rentCostDay;
//     data['rent_cost_month'] = rentCostMonth;
//     data['old_rent_cost_day'] = oldRentCostDay;
//     data['old_rent_cost_month'] = oldRentCostMonth;
//     data['discount_percentage'] = discountPercentage;
//     data['image1'] = image1;
//     data['image2'] = image2;
//     data['image3'] = image3;
//     data['image4'] = image4;
//     data['image5'] = image5;
//     data['description'] = description;
//     data['features'] = features;
//     data['rating'] = rating;
//     data['date_added'] = dateAdded;
//     data['date_modified'] = dateModified;
//     data['status'] = status;
//     if (carsMakes != null) {
//       data['cars_makes'] = carsMakes!.toJson();
//     }
//     if (carsModels != null) {
//       data['cars_models'] = carsModels!.toJson();
//     }
//     if (carsRatings != null) {
//       data['cars_ratings'] = carsRatings!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class CarsMakes {
//   int? carsMakesId;
//   String? name;
//   String? status;
//
//   CarsMakes({this.carsMakesId, this.name, this.status});
//
//   CarsMakes.fromJson(Map<String, dynamic> json) {
//     carsMakesId = json['cars_makes_id'];
//     name = json['name'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cars_makes_id'] = carsMakesId;
//     data['name'] = name;
//     data['status'] = status;
//     return data;
//   }
// }
//
// class CarsModels {
//   int? carsModelsId;
//   int? carsMakesId;
//   String? name;
//   String? status;
//
//   CarsModels({this.carsModelsId, this.carsMakesId, this.name, this.status});
//
//   CarsModels.fromJson(Map<String, dynamic> json) {
//     carsModelsId = json['cars_models_id'];
//     carsMakesId = json['cars_makes_id'];
//     name = json['name'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cars_models_id'] = carsModelsId;
//     data['cars_makes_id'] = carsMakesId;
//     data['name'] = name;
//     data['status'] = status;
//     return data;
//   }
// }