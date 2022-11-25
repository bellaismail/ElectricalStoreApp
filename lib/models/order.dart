import 'package:store_app2/models/product_model.dart';
import 'package:equatable/equatable.dart';

class OrderModel implements Equatable{
  ProductModel productModel;
  int? count;
  OrderModel({required this.productModel, this.count = 1});

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}