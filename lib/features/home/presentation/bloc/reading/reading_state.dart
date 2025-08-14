part of 'reading_bloc.dart';

enum ReadingStatus { initial, loading, success, error }

extension ReadingStatusX on ReadingStatus {
  bool get isInitial => this == ReadingStatus.initial;
  bool get isLoading => this == ReadingStatus.loading;
  bool get isSuccess => this == ReadingStatus.success;
  bool get isError => this == ReadingStatus.error;
}

class ReadingPage extends Equatable {
  final String title;
  final String content;
  final String? imageUrl;

  const ReadingPage({
    required this.title,
    required this.content,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [title, content, imageUrl];
}

class ReadingState extends Equatable {
  const ReadingState({
    this.status = ReadingStatus.initial,
    this.isModalOpen = false,
    this.currentPageIndex = 0,
    this.pages = const [],
    this.errorMessage,
  });

  final ReadingStatus status;
  final bool isModalOpen;
  final int currentPageIndex;
  final List<ReadingPage> pages;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        status,
        isModalOpen,
        currentPageIndex,
        pages,
        errorMessage,
      ];

  ReadingState copyWith({
    ReadingStatus? status,
    bool? isModalOpen,
    int? currentPageIndex,
    List<ReadingPage>? pages,
    String? errorMessage,
  }) {
    return ReadingState(
      status: status ?? this.status,
      isModalOpen: isModalOpen ?? this.isModalOpen,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      pages: pages ?? this.pages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
