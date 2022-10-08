import 'package:flutter/material.dart';
import 'package:store_app2/constant.dart';
import 'package:store_app2/repositories/test_Repo.dart';
import 'package:store_app2/screens/details_screen.dart';
import 'package:store_app2/view_models/body_view_model.dart';
import 'package:store_app2/view_models/product_view_model.dart';
import 'package:store_app2/widgets/home/product_card_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  HomeBodyViewModel homeBodyViewModel =
      HomeBodyViewModel(repository: TestRepo());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding / 2.0),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 90.0,
                  ),
                  decoration: const BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultPadding),
                      topRight: Radius.circular(kDefaultPadding),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: homeBodyViewModel.getAllProductList(),
                  builder: (context,
                      AsyncSnapshot<List<ProductViewModel>> snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ProductCardWidget(
                            itemIndex: index,
                            productModel: snapshot.data![index],
                            onTapFun: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(productViewModel: snapshot.data![index]),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
