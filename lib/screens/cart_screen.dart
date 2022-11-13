import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/product_repositories/product_test_Repo.dart';
import 'package:store_app2/screens/details_screen.dart';
import 'package:store_app2/view_models/cart_screen_view_model.dart';
import 'package:store_app2/view_models/home_body_view_model.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CartScreenViewModel provider = Provider.of<CartScreenViewModel>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _appBar(provider),
      body: provider.cartList.isEmpty
          ? const EmptyCartWidget()
          : Stack(
              children: [
                //top
                Positioned(
                  top: 0,
                  child: CustomPaint(
                    painter: _painter(),
                    child: Container(
                      width: size.width,
                      height: 200,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            "قمت باضافه ${provider.cartList.length} من المنتجات",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: kBackgroundColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //bottom
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    height: size.height * .25,
                    color: kTextColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 13.0),
                                child: Text(
                                  "ادفع",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kBackgroundColor),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                const Text(
                                  "الاجمالي",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: kBackgroundColor,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    "${provider.getPrice()}\$",
                                    style: const TextStyle(
                                      color: kSecondaryColor,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //center
                Positioned(
                  top: 100,
                  child: Container(
                    width: size.width,
                    height: size.height * .65,
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemCount: provider.cartList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(
                                DetailsScreen(
                                  productViewModel: provider.cartList[index],
                                  dataConnectionEnum:
                                      provider.getDataConnectionEnum(
                                    productRepository: ProductTestRepo(),
                                  ),
                                ),
                              );
                            },
                            child: Dismissible(
                              key: Key("${provider.cartList[index].id}"),
                              onDismissed: (dir) {
                                provider.removeProductFromCart(
                                  productRepository: ProductTestRepo(),
                                  context: context,
                                  productViewModel: provider.cartList[index],
                                );
                              },
                              confirmDismiss: (dir) async {
                                if (dir == DismissDirection.startToEnd) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              child: Card(
                                color: kBackgroundColor,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 7.0, vertical: 10.0),
                                elevation: 0.0,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 110,
                                      height: 140,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.lightGreen.withOpacity(0.4),
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "${provider.cartList[index].image}"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            "${provider.cartList[index].title}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Text(
                                              "${provider.cartList[index].price}\$",
                                              style: const TextStyle(
                                                color: kSecondaryColor,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: const BoxDecoration(
                                        color: kTextColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Text(
                                        "x1",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  AppBar _appBar(CartScreenViewModel provider) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: Text(
        provider.title,
        style: const TextStyle(
          fontSize: 15.0,
        ),
      ),
    );
  }
}

class _painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path
      ..moveTo(0, 0)
      ..lineTo(0, 15)
      ..quadraticBezierTo(20, h - 100, w * .35, h - 100)
      ..lineTo(w, h)
      ..lineTo(w, 0);

    Paint paint = Paint()..color = kPrimaryColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CustomPaint(
          painter: EmptyCartWidgetPainter(color: kSecondaryColor),
          child: Container(
            height: size.height * .705,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
          ),
        ),
        CustomPaint(
          painter: EmptyCartWidgetPainter(color: kPrimaryColor),
          child: Container(
            height: size.height * .70,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.inkDrop(
                  color: kSecondaryColor,
                  size: 50.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    "لا توجد عناصر",
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EmptyCartWidgetPainter extends CustomPainter {
  EmptyCartWidgetPainter({this.color});

  final Color? color;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    double w = size.width;
    double h = size.height;

    path
      ..moveTo(0, 0)
      ..lineTo(0, h * .75)
      ..quadraticBezierTo(w / 2, h, w, h * .75)
      ..lineTo(w, 0)
      ..close();

    Paint paint = Paint()..color = color!;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
