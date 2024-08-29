import 'package:freezed_annotation/freezed_annotation.dart';
part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
factory CategoryModel({
 final int? id,
 final String? name,
 final String? image,
 final String? creationAt,
 final String? updatedAt,
}) = _CategoryModel;
factory CategoryModel.fromJson(Map<String, dynamic> json) =>_$CategoryModelFromJson(json); 
}