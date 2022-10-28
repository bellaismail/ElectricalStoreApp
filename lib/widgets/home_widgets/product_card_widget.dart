import 'package:flutter/material.dart';
import 'package:store_app2/view_models/product_view_model.dart';

import '../../constant.dart';

class ProductCardWidget extends StatelessWidget {
  ProductCardWidget({
    this.itemIndex,
    this.productModel,
    this.onTapFun,
    this.dataConnectionEnum,
    this.favorite,
    this.favoriteOnPressedFun,
  });

  final int? itemIndex;
  final ProductViewModel? productModel;
  final Function()? onTapFun;
  final DataConnectionEnum? dataConnectionEnum;
  final Function()? favoriteOnPressedFun;
  final bool? favorite;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTapFun,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 2,
        ),
        height: 190.0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 166.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15.0,
                    offset: Offset(0, 15),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              bottom: 0.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                width: 200.0,
                height: 160.0,
                child: Column(
                  children: [
                    (dataConnectionEnum == DataConnectionEnum.localData)
                        ? Expanded(
                            child: Image.asset("${productModel!.image}"),
                          )
                        : Expanded(
                            child: Image.network("${productModel!.image}"),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        favoriteAndAddIcon(
                          iconData: favorite!
                              ? Icons.favorite
                              : Icons.favorite_border,
                          onPressedFun: favoriteOnPressedFun,
                        ),
                        favoriteAndAddIcon(
                          iconData: Icons.add,
                          onPressedFun: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: 0.0,
              child: SizedBox(
                height: 136.0,
                width: size.width - 200.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "${productModel!.title}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        " ${productModel!.subTitle}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Container(
                      margin: const EdgeInsets.only(bottom: kDefaultPadding),
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, //30 px
                        vertical: kDefaultPadding / 4, //5 px
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      child: Text("السعر \$${productModel!.price}"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class favoriteAndAddIcon extends StatelessWidget {
  favoriteAndAddIcon({
    this.iconData,
    this.onPressedFun,
  });

  Function()? onPressedFun;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressedFun,
      icon: Icon(
        iconData,
        color: kPrimaryColor,
        size: 26.0,
      ),
    );
  }
}
