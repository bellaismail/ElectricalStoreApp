import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/product_repositories/product_test_Repo.dart';
import 'package:store_app2/view_models/favorite_screen_view_model.dart';
import 'package:store_app2/view_models/home_body_view_model.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  double? _pointOne = 20.0;
  double? _pointTwo = 10.0;
  double? _pointThree = 10.0;

  bool loopEnd = false;

  @override
  void initState() {
    fontSizeFun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var provider = Provider.of<FavoriteScreenViewModel>(context);
    HomeBodyViewModel homeBodyViewModel =
        HomeBodyViewModel(repository: ProductTestRepo());

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: appBar(provider),
      body: provider.favoriteList.isEmpty
          ? loopEnd
              ? const Center(
                  child: Text(
                    "فارغه",
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 25.0,
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.circle, size: _pointOne, color: Colors.white),
                        Icon(Icons.circle, size: _pointTwo, color: Colors.white),
                        Icon(Icons.circle, size: _pointThree, color: Colors.white),
                      ],
                    ),
                  ),
                )
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
                    return Dismissible(
                      key: Key(provider.favoriteList[index].id.toString()),
                      onDismissed: (direction) async{
                        await provider.removeFromFavorite(
                          context: context,
                          productViewModel: provider.favoriteList[index],
                          repo: ProductTestRepo(),
                        );
                      },
                      confirmDismiss: (DismissDirection dm) async {
                        if (dm == DismissDirection.startToEnd) {
                          return true;
                        }
                        return false;
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
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceEvenly,
                                    //   children: [
                                    //     favoriteAndAddIcon(
                                    //       iconData: Icons.favorite_border,
                                    //       onPressedFun: () {
                                    //         favoriteProvider.addProductToFavorite(
                                    //           productViewModel: productModel,
                                    //         );
                                    //       },
                                    //     ),
                                    //     favoriteAndAddIcon(
                                    //       iconData: Icons.add,
                                    //       onPressedFun: () {
                                    //         print("****add icon****");
                                    //       },
                                    //     ),
                                    //   ],
                                    // ),
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
                                        style:
                                            Theme.of(context).textTheme.caption,
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
                    );
                  },
                ),
              ],
            ),
    );
  }

  Future<void> fontSizeFun() async {
    for (int x = 1; x < 15; x++) {
      if (x == 0 || x == 3 || x == 6 || x == 9 || x == 12 || x == 15) {
        await pointOne();
      } else if (x == 1 || x == 4 || x == 7 || x == 10 || x == 13) {
        await pointTwo();
      } else {
        await pointThree();
      }
      setState(() {
        _pointOne;
        _pointTwo;
        _pointThree;
      });
    }
    setState(() {
      loopEnd = true;
    });
  }

  Future<void> pointOne() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) => {
          _pointOne = 20.0,
          _pointTwo = 10.0,
          _pointThree = 10.0,
        });
  }
  Future<void> pointTwo() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) => {
          _pointOne = 10.0,
          _pointTwo = 20.0,
          _pointThree = 10.0,
        });
  }
  Future<void> pointThree() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) => {
          _pointOne = 10.0,
          _pointTwo = 10.0,
          _pointThree = 20.0,
        });
  }

  AppBar appBar(FavoriteScreenViewModel provider) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0.0,
      title: Text(provider.appBarString),
    );
  }
}
