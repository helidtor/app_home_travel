import 'package:equatable/equatable.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<HomestayModel> list;
  const SearchSuccess({required this.list});
  @override
  List<Object> get props => [list];
}

class SearchError extends SearchState {
  final String error;

  const SearchError({required this.error});

  @override
  List<Object> get props => [error];
}

class SearchEmpty extends SearchState {
  final String noti;

  const SearchEmpty({required this.noti});

  @override
  List<Object> get props => [noti];
}