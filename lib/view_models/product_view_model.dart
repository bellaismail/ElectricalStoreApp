import 'package:store_app2/models/product_model.dart';

class ProductViewModel{
  ProductViewModel({this.productModel});
  final ProductModel? productModel;

  int? get id => productModel!.id;
  int? get price => productModel!.price;
  String? get title => productModel!.title;
  String? get subTitle => productModel!.subTitle;
  String? get description => productModel!.description;
  String? get image => productModel!.image;
  bool? get favorite => productModel!.favorite;
  bool? get addedToCart => productModel!.addToCart;
  int? get productTotalNum => productModel!.productTotalNum;

  set setFavorite(bool fav) => productModel!.favorite = fav;
  set addToCart(bool add) => productModel!.addToCart = add;
  set productTotalNumFun(int num) => productModel!.productTotalNum = num;
  void incrementProductTotalNum(){
    productModel!.productTotalNum = productModel!.productTotalNum! + 1;
  }
  void decrementProductTotalNum(){
    if(productModel!.productTotalNum! > 1){
      productModel!.productTotalNum = productModel!.productTotalNum! - 1;
    }
  }

}