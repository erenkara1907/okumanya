part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBooks extends HomeEvent {}

class SearchBooks extends HomeEvent {
  final String query;

  SearchBooks({required this.query});

  @override
  List<Object?> get props => [query];
}

class FilterBooks extends HomeEvent {
  final String category;

  FilterBooks({required this.category});

  @override
  List<Object?> get props => [category];
}
