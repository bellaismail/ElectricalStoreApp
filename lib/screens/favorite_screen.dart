import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/product_repositories/product_test_Repo.dart';
import 'package:store_app2/screens/cart_screen.dart';
import 'package:store_app2/screens/details_screen.dart';
import 'package:store_app2/view_models/favorite_screen_view_model.dart';
import 'package:store_app2/view_models/home_body_view_model.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    var provider = Provider.of<FavoriteScreenViewModel>(context, listen: false);
    provider.getFavoriteList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var provider = Provider.of<FavoriteScreenViewModel>(context);
    HomeBodyViewModel homeBodyViewModel =
        HomeBodyViewModel(repository: ProductTestRepo());
    return Scaffold(
      backgroundColor: provider.favoriteList.isEmpty? kBackgroundColor:kPrimaryColor,
      appBar: appBar(provider),
      body: provider.favoriteList.isEmpty
          ? const EmptyCartWidget()
          : Stack(
              children: [
                Container(
                  height: size.height,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 100.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      topLeft: Radius.circular(25.0),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: provider.favoriteList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          DetailsScreen(
                            productViewModel: provider.favoriteList[index],
                            dataConnectionEnum:
                                homeBodyViewModel.getDataConnectionEnum(),
                          ),
                        );
                      },
                      child: Dismissible(
                        key: Key(provider.favoriteList[index].id.toString()),
                        movementDuration: const Duration(milliseconds: 600),
                        onDismissed: (direction) async {
                          await provider.removeFromFavorite(
                            context: context,
                            productViewModel: provider.favoriteList[index],
                            repo: ProductTestRepo(),
                          );
                        },
                        confirmDismiss: (DismissDirection dm) async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return dialog(provider, context);
                              });
                          if (provider.confirmDelete == true) {
                            return true;
                          }else{
                            return false;
                          }
                        },
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  width: 200.0,
                                  height: 160.0,
                                  child: Column(
                                    children: [
                                      (homeBodyViewModel
                                                  .getDataConnectionEnum() ==
                                              DataConnectionEnum.localData)
                                          ? Expanded(
                                              child: Image.asset(
                                                  "${provider.favoriteList[index].image}"),
                                            )
                                          : Expanded(
                                              child: Image.network(
                                                  "${provider.favoriteList[index].image}"),
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
                                          "${provider.favoriteList[index].title}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding),
                                        child: Text(
                                          "${provider.favoriteList[index].subTitle}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: kDefaultPadding),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              kDefaultPadding * 1.5, //30 px
                                          vertical: kDefaultPadding / 4, //5 px
                                        ),
                                        decoration: BoxDecoration(
                                          color: kSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(22.0),
                                        ),
                                        child: Text(
                                            "السعر \$${provider.favoriteList[index].price}"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
  AppBar appBar(FavoriteScreenViewModel provider) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0.0,
      title: Text(provider.appBarString),
    );
  }

  AlertDialog dialog(FavoriteScreenViewModel provider, context) {
    return AlertDialog(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide.none,
      ),
      elevation: 50,
      title: const Text("هل حقا تريد حزف المنتج"),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              provider.confirmDeleteFun();
              Get.back();
            },
            child: const Text(
              "تأكيد",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          TextButton(
            onPressed: () {
              provider.rejectDeleteFun();
              Get.back();
            },
            child: const Text(
              "لا",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
