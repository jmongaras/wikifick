part of 'get_all_post_data_bloc.dart';

@immutable
sealed class GetAllPostDataState {}

class GetAllPostDataStateInitial extends GetAllPostDataState {}

class GetAllPostDataStateLoading extends GetAllPostDataState {}

class GetAllPostDataStateLoaded extends GetAllPostDataState {
  final WikipediaResponseModel wikipediaResponse;
  GetAllPostDataStateLoaded({required this.wikipediaResponse});
}

class GetAllPostDataStateSuccess extends GetAllPostDataState {
  final WikipediaResponseModel wikipediaResponse;
  GetAllPostDataStateSuccess({required this.wikipediaResponse});
}

class GetAllPostDataStateError extends GetAllPostDataState {
  final WikipediaResponseModel wikipediaResponse;
  GetAllPostDataStateError({required this.wikipediaResponse});
}