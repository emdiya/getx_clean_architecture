import 'package:freezed_annotation/freezed_annotation.dart';

import '../category_model/category_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    final int? id,
    final String? title,
    final int? price,
    final String? description,
    final List<String>? images,
    final String? creationAt,
    final String? updatedAt,
    final CategoryModel? category,
  }) = _ProductModel;
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
