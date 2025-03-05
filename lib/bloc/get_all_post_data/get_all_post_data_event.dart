part of 'get_all_post_data_bloc.dart';

@immutable
sealed class GetAllPostDataEvent {}

class GetAllPostData extends GetAllPostDataEvent {
  final String languagesController;

  GetAllPostData(
      this.languagesController,
      );

  List<Object> get props => [
    languagesController,
  ];

}
