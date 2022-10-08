import 'package:flutter/material.dart';
import 'package:store_app2/models/product_model.dart';
import 'package:store_app2/repositories/abstract_repo.dart';

class APIRepo extends Repository{
  @override
  Future<List<ProductModel>> getProductList() {
    // TODO: implement getProductList
    throw UnimplementedError();
  }

}