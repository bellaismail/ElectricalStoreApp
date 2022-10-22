import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/repositories/product_repositories/product_test_Repo.dart';
import 'package:store_app2/view_models/favorite_screen_view_moedel.dart';
import 'package:store_app2/view_models/product_view_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoriteScreenViewModel provider =
        Provider.of<FavoriteScreenViewModel>(context);
    return Scaffold(
      appBar: appBar(provider),
      body: provider.favoriteList.isEmpty
          ? const Center(child: Text("List  is Empty"))
          : FutureBuilder(
              future: provider.getProductsFromFavorites(),
              builder:
                  (context, AsyncSnapshot<List<ProductViewModel>> snapshot) {
                return ListView.builder(
                  itemCount: provider.favoriteList.length/*snapshot.data!.length*/,
                  itemBuilder: (context, index) {
                    return Text("**${provider.favoriteList[index].title}**");
                  },
                );
              },
            ),
    );
  }

  AppBar appBar(provider) {
    return AppBar(
      title: Text("${provider.appBarTitle}"),
    );
  }
}
