import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'reading_event.dart';
part 'reading_state.dart';

@injectable
class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  ReadingBloc() : super(const ReadingState()) {
    on<OpenReadingModal>(_onOpenReadingModal);
    on<CloseReadingModal>(_onCloseReadingModal);
    on<NextPage>(_onNextPage);
    on<PreviousPage>(_onPreviousPage);
    on<GoToPage>(_onGoToPage);
  }

  void _onOpenReadingModal(OpenReadingModal event, Emitter<ReadingState> emit) {
    emit(state.copyWith(
      isModalOpen: true,
      status: ReadingStatus.success,
      pages: event.pages,
      currentPageIndex: 0,
    ));
  }

  void _onCloseReadingModal(
      CloseReadingModal event, Emitter<ReadingState> emit) {
    emit(state.copyWith(
      isModalOpen: false,
      currentPageIndex: 0,
    ));
  }

  void _onNextPage(NextPage event, Emitter<ReadingState> emit) {
    if (state.currentPageIndex < state.pages.length - 1) {
      emit(state.copyWith(currentPageIndex: state.currentPageIndex + 1));
    }
  }

  void _onPreviousPage(PreviousPage event, Emitter<ReadingState> emit) {
    if (state.currentPageIndex > 0) {
      emit(state.copyWith(currentPageIndex: state.currentPageIndex - 1));
    }
  }

  void _onGoToPage(GoToPage event, Emitter<ReadingState> emit) {
    if (event.pageIndex >= 0 && event.pageIndex < state.pages.length) {
      emit(state.copyWith(currentPageIndex: event.pageIndex));
    }
  }
}
