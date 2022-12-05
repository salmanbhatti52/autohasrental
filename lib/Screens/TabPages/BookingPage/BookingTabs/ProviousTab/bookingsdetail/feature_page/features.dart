import 'package:flutter/cupertino.dart';
import 'feature_image_widget.dart';
import 'features_text_widget.dart';

class FeaturesBookingsDetails extends StatelessWidget {
  const FeaturesBookingsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          featuretext("\u2022", "Drive this car up to 1,250 KM/month", context),
          featuretext("\u2022", "Comprehensive insurance", context),
          featuretext("\u2022", "Road tax", context),
          featuretext("\u2022", "Regularly scheduled maintenance", context),
          featuretext("\u2022", "Concierge service", context),
          featuretext("\u2022", "24/7 nationwide roadside assistance", context),
          featuretext("\u2022", "Ability to swap a car", context),
          featuretext("\u2022", "Anti-theft system", context),
          featuretext("\u2022", "Independently rated car inspection", context),
          const SizedBox(height: 10),
          myHorizontalCard3(context),
        ],
      ),
    );
  }
}
