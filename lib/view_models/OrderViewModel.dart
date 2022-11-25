
import 'package:store_app2/models/product_model.dart';

import '../models/order.dart';

class OrderViewModel{
  final OrderModel orderModel;
  OrderViewModel({required this.orderModel});

  int? get count => orderModel.count;
  ProductModel get productModel => orderModel.productModel;
}