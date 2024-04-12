import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchHomestay extends SearchEvent {
  final int? capacity;
  final String location;

  const SearchHomestay({this.capacity, required this.location});
}
