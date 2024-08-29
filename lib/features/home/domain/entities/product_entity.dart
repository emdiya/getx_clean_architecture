import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_entity.freezed.dart';
part 'product_entity.g.dart';

@freezed
class ProductEntity with _$ProductEntity {
  factory ProductEntity({
    final int? id,
    final String? title,
    final int? price,
    final String? description,
    final List<String>? images,
    final String? creationAt,
    final String? updatedAt,
    final CategoryModel? category,
  }) = _ProductEntity;
  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);
}

@freezed
class CategoryModel with _$CategoryModel {
  factory CategoryModel({
    final int? id,
    final String? name,
    final String? image,
    final String? creationAt,
    final String? updatedAt,
  }) = _CategoryModel;
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
