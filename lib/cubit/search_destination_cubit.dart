import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mtm_task/constant/k_urls.dart';
import 'package:mtm_task/model/city_model_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'search_destination_state.dart';

class SearchDestinationCubit extends Cubit<SearchDestinationState> {
  SearchDestinationCubit() : super(SearchDestinationInitial());
List<CityModelEntity>city=[];
  TextEditingController destinationController = TextEditingController();
  int page = 10;
  ///get list of cities using restApi
  Future<List<CityModelEntity>>getCity(RefreshController refreshController)async{
    emit(SearchDestinationLoading());
    http.Response response;
    response = await http.get(
      Uri.parse(kDestinationUrl),
      headers: {},
    );
    if (response.statusCode == 200) {
      final List map = json.decode(response.body);
      city = (map)
          .map((stations) => CityModelEntity.fromJson(stations as Map<String,dynamic>))
          .toList();

      paginateLocalList(refreshController);
    }else{
     print(response.statusCode);
    }
    return city;
  }


  void selectPlace(BuildContext context,String placeName){
    destinationController.text  = placeName;
    Navigator.pop(context);
  }
  /// paginate list
  Future<List<CityModelEntity>> paginateLocalList(RefreshController refreshController) async {
    emit(SearchDestinationLoading());
    final List<CityModelEntity> nextUsersList = List.generate(
      page,
          (int index) => CityModelEntity(
            name: city[index].name!,
            country: city[index].country!,
            lat: city[index].lat!,
            lng: city[index].lng!
      ),
    );
    Future.delayed(const Duration(seconds: 1)).then((value) {
      emit(SearchDestinationFetched(city: nextUsersList));
      refreshController.loadComplete();
    });


    if (city.length == nextUsersList.length) {
      refreshController.loadNoData();
      page = 10;
      return city;
    }
    page = page +10;

    return  nextUsersList;
  }
}
