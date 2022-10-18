import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/view_models/product_view_model.dart';
import 'package:store_app2/widgets/details_widgets/selected_point_widget.dart';
import 'package:store_app2/widgets/home_widgets/home_body_widget.dart';

class DetailsBodyWidget extends StatelessWidget {
  DetailsBodyWidget({
    this.productViewModel,
    this.dataConnectionEnum,
  });

  final ProductViewModel? productViewModel;
  final DataConnectionEnum? dataConnectionEnum;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var provider = Provider.of<HomeBodyWidget>(context);
    return ListView(
      children: [
        Column(
          children: [
            Container(
              height: size.height * .60,
              width: size.width,
              decoration: const BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: kDefaultPadding * 1.5),
                    width: 300.0,
                    height: 300.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 280.0,
                          height: 280.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(150.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          child: (dataConnectionEnum ==
                                  DataConnectionEnum.localData)
                              ? Image.asset(
                                  "${productViewModel!.image}",
                                  fit: BoxFit.cover,
                                )
                              : Image.network("${productViewModel!.image}"),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: kDefaultPadding * 7,
                    child: Row(
                      children: [
                        ChoosePointWidget(
                            pointColor: kTextLightColor, isSelected: false),
                        ChoosePointWidget(
                            pointColor: kTextColor, isSelected: true),
                        ChoosePointWidget(
                            pointColor: kBlueColor, isSelected: false),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding * 3.5,
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(
                        "${productViewModel!.title}",
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding * 1.5,
                        horizontal: kDefaultPadding,
                      ),
                      child: Text(
                        "السعر: \$${productViewModel!.price}",
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text(
                "${productViewModel!.description}",
                style: const TextStyle(
                  color: kBackgroundColor,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
