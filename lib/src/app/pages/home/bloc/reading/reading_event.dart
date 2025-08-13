part of 'reading_bloc.dart';

abstract class ReadingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OpenReadingModal extends ReadingEvent {
  final List<ReadingPage> pages;

  OpenReadingModal({required this.pages});

  @override
  List<Object?> get props => [pages];
}

class CloseReadingModal extends ReadingEvent {}

class NextPage extends ReadingEvent {}

class PreviousPage extends ReadingEvent {}

class GoToPage extends ReadingEvent {
  final int pageIndex;

  GoToPage({required this.pageIndex});

  @override
  List<Object?> get props => [pageIndex];
}
