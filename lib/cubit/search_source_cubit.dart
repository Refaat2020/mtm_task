import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'search_source_state.dart';

class SearchSourceCubit extends Cubit<SearchSourceState> {
  SearchSourceCubit() : super(SearchSourceInitial());
  int limit = 10;
  List<QueryDocumentSnapshot> places = [];
  TextEditingController sourceController = TextEditingController();

  FirebaseFirestore? fireStore;
  initialize() {
    fireStore = FirebaseFirestore.instance;
  }

  Future<List> searchSourcePlace(RefreshController refreshController) async {
    try {
      if (limit >= 10) {
        emit(SearchSourceLoading());
      }
      fireStore
          ?.collection('source')
          .limit(limit)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          places = querySnapshot.docs.toList();
          emit(SearchSourceFetched(places: places));
          refreshController.loadComplete();
          if (limit >= 50) {
            refreshController.loadNoData();
            limit = 10;
            return places;
          }
          limit = limit + 10;
        }
      });
    } catch (e) {
      print(e);
    }
    return places;
  }

  void selectPlace(BuildContext context, String placeName) {
    sourceController.text = placeName;
    Navigator.pop(context);
  }
}
