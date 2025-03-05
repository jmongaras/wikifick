import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/wikipedia_response_model.dart';
import '../../repository/get_all_post_repository.dart';

part 'get_all_post_data_event.dart';
part 'get_all_post_data_state.dart';

class GetAllPostDataBloc extends Bloc<GetAllPostDataEvent, GetAllPostDataState> {
  final GetAllPostRepository getAllPostRepository = GetAllPostRepository();
  List<WikiPageModel> allPosts = []; // Stores all fetched posts
  bool isFetching = false; // Prevents duplicate API calls

  GetAllPostDataBloc() : super(GetAllPostDataStateInitial()) {
    on<GetAllPostData>((event, emit) async {
      if (isFetching) return; // Prevent duplicate calls
      isFetching = true;

      if (allPosts.isEmpty) {
        emit(GetAllPostDataStateLoading());
      }

      final getAllPostData = await getAllPostRepository.getAllPost(event.languagesController);

      isFetching = false;

      if (getAllPostData.success) {
        allPosts.addAll(getAllPostData.pages); // Append new data
        emit(GetAllPostDataStateSuccess(
          wikipediaResponse: WikipediaResponseModel(success: true, pages: List.from(allPosts)),
        ));
      } else {
        emit(GetAllPostDataStateError(wikipediaResponse: getAllPostData));
      }
    });
  }
}
