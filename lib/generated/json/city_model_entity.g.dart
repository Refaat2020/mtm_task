import 'package:mtm_task/generated/json/base/json_convert_content.dart';
import 'package:mtm_task/model/city_model_entity.dart';

CityModelEntity $CityModelEntityFromJson(Map<String, dynamic> json) {
	final CityModelEntity cityModelEntity = CityModelEntity();
	final String? country = jsonConvert.convert<String>(json['country']);
	if (country != null) {
		cityModelEntity.country = country;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		cityModelEntity.name = name;
	}
	final String? lat = jsonConvert.convert<String>(json['lat']);
	if (lat != null) {
		cityModelEntity.lat = lat;
	}
	final String? lng = jsonConvert.convert<String>(json['lng']);
	if (lng != null) {
		cityModelEntity.lng = lng;
	}
	return cityModelEntity;
}

Map<String, dynamic> $CityModelEntityToJson(CityModelEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['country'] = entity.country;
	data['name'] = entity.name;
	data['lat'] = entity.lat;
	data['lng'] = entity.lng;
	return data;
}