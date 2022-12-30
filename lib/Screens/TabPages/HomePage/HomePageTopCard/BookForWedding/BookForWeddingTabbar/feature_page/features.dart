import 'package:flutter/cupertino.dart';
import 'feature_image_widget.dart';
import 'features_text_widget.dart';

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          featureTextWidget("\u2022", "Drive this car up to 1,250 KM/month", context),
          featureTextWidget("\u2022", "Comprehensive insurance", context),
          featureTextWidget("\u2022", "Road tax", context),
          featureTextWidget("\u2022", "Regularly scheduled maintenance", context),
          featureTextWidget("\u2022", "Concierge service", context),
          featureTextWidget("\u2022", "24/7 nationwide roadside assistance", context),
          featureTextWidget("\u2022", "Ability to swap a car", context),
          featureTextWidget("\u2022", "Anti-theft system", context),
          featureTextWidget("\u2022", "Independently rated car inspection", context),
          const SizedBox(height: 10),
          myHorizontalCard3(context),
        ],
      ),
    );
  }
}
