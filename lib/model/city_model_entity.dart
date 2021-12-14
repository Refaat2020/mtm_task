import 'dart:convert';
import 'package:mtm_task/generated/json/base/json_field.dart';
import 'package:mtm_task/generated/json/city_model_entity.g.dart';

@JsonSerializable()
class CityModelEntity {

	 String ?country;
	 String ?name;
	 String ?lat;
	 String ?lng;
  
  CityModelEntity({this.name, this.country, this.lng, this.lat});

  factory CityModelEntity.fromJson(Map<String, dynamic> json) => $CityModelEntityFromJson(json);

  Map<String, dynamic> toJson() => $CityModelEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}