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

}