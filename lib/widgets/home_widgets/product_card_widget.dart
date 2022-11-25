import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app2/repositories/user_repositories/abstract_user_repo.dart';
import 'package:store_app2/repositories/user_repositories/user_repo_firebase.dart';
import 'package:store_app2/view_models/home_body_view_model.dart';
import 'package:store_app2/view_models/product_card_widget_view_model.dart';
import 'package:store_app2/view_models/product_view_model.dart';

import '../../constant.dart';
import '../../repositories/product_repositories/product_test_Repo.dart';

class ProductCardWidget extends StatelessWidget {
  ProductCardWidget({
    this.itemIndex,
    this.productModel,
    this.onTapFun,
    this.dataConnectionEnum,
    this.favorite,
    this.addedToCart,
    required this.productViewModel,
  });

  final int? itemIndex;
  final ProductViewModel? productModel;
  final Function()? onTapFun;
  final DataConnectionEnum? dataConnectionEnum;
  final bool? favorite;
  final bool? addedToCart;
  final ProductViewModel productViewModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var provider = Provider.of<ProductCardWidgetViewModel>(context);
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
                        FavoriteAndAddIcon(
                          iconData: favorite!
                              ? Icons.favorite
                              : Icons.favorite_border,
                          addIconBackground: null,
                          productViewModel: productViewModel,
                        ),
                        FavoriteAndAddIcon(
                          iconData: Icons.add,
                          addIconBackground: addedToCart!? kBackgroundColor:Colors.white,
                          productViewModel: productViewModel,
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

class FavoriteAndAddIcon extends StatefulWidget with ChangeNotifier{
  FavoriteAndAddIcon({
    this.iconData,
    this.addIconBackground,
    required this.productViewModel,
  });

  final IconData? iconData;
  final Color? addIconBackground;
  final ProductViewModel productViewModel;

  @override
  State<FavoriteAndAddIcon> createState() => _FavoriteAndAddIconState();
}

class _FavoriteAndAddIconState extends State<FavoriteAndAddIcon>{

  bool? isFavorite = false;
  bool? isAddedToCart = false;
  UserRepository userRepository = UserRepoFirebase();

  getFavorite()async{
    SharedPreferences s = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = s.getBool("${userRepository.getCurrentUserId()}${widget.productViewModel.id}favorite")??false;
    });
  }
  setFavorite()async{
    SharedPreferences s = await SharedPreferences.getInstance();
    if (isFavorite!) {
      setState(() {
        isFavorite = false;
        s.setBool("${userRepository.getCurrentUserId()}${widget.productViewModel.id}favorite", false);
      });
    } else {
      setState(() {
        isFavorite = true;
        s.setBool("${userRepository.getCurrentUserId()}${widget.productViewModel.id}favorite", true);
      });
    }
  }
  getIsAddedToCart()async{
    SharedPreferences s = await SharedPreferences.getInstance();
    setState(() {
      isAddedToCart = s.getBool("${userRepository.getCurrentUserId()}${widget.productViewModel.id}cart")??false;
    });
  }
  setToCart()async{
    SharedPreferences s = await SharedPreferences.getInstance();
    if(isAddedToCart!){
      setState(() {
        isAddedToCart = false;
      });
      s.setBool("${userRepository.getCurrentUserId()}${widget.productViewModel.id}cart", false);
    }else{
      setState(() {
        isAddedToCart = true;
      });
      s.setBool("${userRepository.getCurrentUserId()}${widget.productViewModel.id}cart", true);
    }
  }

  @override
  void initState() {
    getFavorite();
    getIsAddedToCart();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductCardWidgetViewModel>(context);
    var homeProvider = Provider.of<HomeBodyViewModel>(context);
    return widget.iconData != Icons.add
        ? IconButton(
            onPressed: ()async{
              setFavorite();
              await homeProvider.favoriteFunction(
                context: context,
                productViewModel: widget.productViewModel,
                productRepository: ProductTestRepo(),
                favorite: isFavorite,
                userId: userRepository.getCurrentUserId(),
              );
            },
            icon: Icon(
              isFavorite!? Icons.favorite: Icons.favorite_border,
              color: kTextColor,
              size: 26.0,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isAddedToCart!? kBackgroundColor:Colors.white,
              ),
              child: IconButton(
                onPressed: ()async{
                  setToCart();
                  await homeProvider.addProductToCartFun(
                    context: context,
                    productViewModel: widget.productViewModel,
                    productRepository: ProductTestRepo(),
                    isAddedToCart: isAddedToCart,
                    userId: userRepository.getCurrentUserId(),
                  );
                },
                icon: Icon(
                  widget.iconData,
                  color: kTextColor,
                  size: 26.0,
                ),
              ),
            ),
          );
  }
}
