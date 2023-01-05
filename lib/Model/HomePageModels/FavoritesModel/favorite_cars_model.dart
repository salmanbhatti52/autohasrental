
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cars_id'] = carsId;
    data['cars_usage_type'] = carsUsageType;
    data['users_companies_id'] = usersCompaniesId;
    data['cars_type_id'] = carsTypeId;
    data['cars_makes_id'] = carsMakesId;
    data['cars_models_id'] = carsModelsId;
    data['year'] = year;
    data['vehical_name'] = vehicalName;
    data['license_plate'] = licensePlate;
    data['discount_percentage'] = discountPercentage;
    data['description'] = description;
    data['features_suv'] = featuresSuv;
    data['features_2doors'] = features2doors;
    data['features_5seats'] = features5seats;
    data['features_automatic'] = featuresAutomatic;
    data['features_awd'] = featuresAwd;
    data['features_electric'] = featuresElectric;
    data['features_tbd'] = featuresTbd;
    data['features_new_cars'] = featuresNewCars;
    data['rating'] = rating;
    data['image1'] = image1;
    data['image2'] = image2;
    data['image3'] = image3;
    data['image4'] = image4;
    data['image5'] = image5;
    data['date_added'] = dateAdded;
    data['date_modified'] = dateModified;
    data['status'] = status;
    return data;
  }
}