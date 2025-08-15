import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:okumanya/features/home/presentation/bloc/reading/reading_bloc.dart';

@GenerateMocks([])
void main() {
  late ReadingBloc readingBloc;

  setUp(() {
    readingBloc = ReadingBloc();
  });

  tearDown(() {
    readingBloc.close();
  });

  group('ReadingBloc', () {
    final mockPages = [
      ReadingPage(title: 'Page 1', content: 'Page 1 content'),
      ReadingPage(title: 'Page 2', content: 'Page 2 content'),
      ReadingPage(title: 'Page 3', content: 'Page 3 content'),
    ];

    test('initial state is ReadingState with default values', () {
      expect(readingBloc.state, equals(const ReadingState()));
      expect(readingBloc.state.isModalOpen, false);
      expect(readingBloc.state.currentPageIndex, 0);
      expect(readingBloc.state.pages, isEmpty);
      expect(readingBloc.state.status, ReadingStatus.initial);
    });

    group('OpenReadingModal Event', () {
      blocTest<ReadingBloc, ReadingState>(
        'opens reading modal with provided pages',
        build: () => readingBloc,
        act: (bloc) => bloc.add(OpenReadingModal(pages: mockPages)),
        expect: () => [
          const ReadingState().copyWith(
            isModalOpen: true,
            status: ReadingStatus.success,
            pages: mockPages,
            currentPageIndex: 0,
          ),
        ],
      );

      blocTest<ReadingBloc, ReadingState>(
        'opens reading modal with single page',
        build: () => readingBloc,
        act: (bloc) => bloc.add(OpenReadingModal(pages: [
          ReadingPage(title: 'Single page', content: 'Single page')
        ])),
        expect: () => [
          const ReadingState().copyWith(
            isModalOpen: true,
            status: ReadingStatus.success,
            pages: [ReadingPage(title: 'Single page', content: 'Single page')],
            currentPageIndex: 0,
          ),
        ],
      );

      blocTest<ReadingBloc, ReadingState>(
        'opens reading modal with empty pages list',
        build: () => readingBloc,
        act: (bloc) => bloc.add(OpenReadingModal(pages: [])),
        expect: () => [
          const ReadingState().copyWith(
            isModalOpen: true,
            status: ReadingStatus.success,
            pages: [],
            currentPageIndex: 0,
          ),
        ],
      );
    });

    group('CloseReadingModal Event', () {
      blocTest<ReadingBloc, ReadingState>(
        'closes reading modal and resets page index',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          isModalOpen: true,
          currentPageIndex: 2,
          pages: mockPages,
        ),
        act: (bloc) => bloc.add(CloseReadingModal()),
        expect: () => [
          const ReadingState().copyWith(
            isModalOpen: false,
            currentPageIndex: 0,
            pages: mockPages,
          ),
        ],
      );

      blocTest<ReadingBloc, ReadingState>(
        'closes reading modal when already closed',
        build: () => readingBloc,
        act: (bloc) => bloc.add(CloseReadingModal()),
        expect: () => [
          const ReadingState().copyWith(
            isModalOpen: false,
            currentPageIndex: 0,
          ),
        ],
      );
    });

    group('NextPage Event', () {
      blocTest<ReadingBloc, ReadingState>(
        'goes to next page when not at last page',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 0,
        ),
        act: (bloc) => bloc.add(NextPage()),
        expect: () => [
          const ReadingState().copyWith(
            pages: mockPages,
            currentPageIndex: 1,
          ),
        ],
      );

      blocTest<ReadingBloc, ReadingState>(
        'does not go beyond last page',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 2, // Last page (index 2 for 3 pages)
        ),
        act: (bloc) => bloc.add(NextPage()),
        expect: () => [],
      );

      blocTest<ReadingBloc, ReadingState>(
        'handles next page with empty pages list',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: [],
          currentPageIndex: 0,
        ),
        act: (bloc) => bloc.add(NextPage()),
        expect: () => [],
      );

      blocTest<ReadingBloc, ReadingState>(
        'navigates through all pages sequentially',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 0,
        ),
        act: (bloc) {
          bloc.add(NextPage()); // 0 -> 1
          bloc.add(NextPage()); // 1 -> 2
          bloc.add(NextPage()); // 2 -> 2 (no change)
        },
        expect: () => [
          const ReadingState().copyWith(
            pages: mockPages,
            currentPageIndex: 1,
          ),
          const ReadingState().copyWith(
            pages: mockPages,
            currentPageIndex: 2,
          ),
        ],
      );
    });

    group('PreviousPage Event', () {
      blocTest<ReadingBloc, ReadingState>(
        'goes to previous page when not at first page',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 2,
        ),
        act: (bloc) => bloc.add(PreviousPage()),
        expect: () => [
          const ReadingState().copyWith(
            pages: mockPages,
            currentPageIndex: 1,
          ),
        ],
      );

      blocTest<ReadingBloc, ReadingState>(
        'does not go before first page',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 0,
        ),
        act: (bloc) => bloc.add(PreviousPage()),
        expect: () => [],
      );

      blocTest<ReadingBloc, ReadingState>(
        'handles previous page with empty pages list',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: [],
          currentPageIndex: 0,
        ),
        act: (bloc) => bloc.add(PreviousPage()),
        expect: () => [],
      );

      blocTest<ReadingBloc, ReadingState>(
        'navigates backwards through all pages',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 2,
        ),
        act: (bloc) {
          bloc.add(PreviousPage()); // 2 -> 1
          bloc.add(PreviousPage()); // 1 -> 0
          bloc.add(PreviousPage()); // 0 -> 0 (no change)
        },
        expect: () => [
          const ReadingState().copyWith(
            pages: mockPages,
            currentPageIndex: 1,
          ),
          const ReadingState().copyWith(
            pages: mockPages,
            currentPageIndex: 0,
          ),
        ],
      );
    });

    group('GoToPage Event', () {
      blocTest<ReadingBloc, ReadingState>(
        'goes to valid page index',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 0,
        ),
        act: (bloc) => bloc.add(GoToPage(pageIndex: 2)),
        expect: () => [
          const ReadingState().copyWith(
            pages: mockPages,
            currentPageIndex: 2,
          ),
        ],
      );

      blocTest<ReadingBloc, ReadingState>(
        'does not go to invalid page index (negative)',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 1,
        ),
        act: (bloc) => bloc.add(GoToPage(pageIndex: -1)),
        expect: () => [],
      );

      blocTest<ReadingBloc, ReadingState>(
        'does not go to invalid page index (beyond pages)',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 1,
        ),
        act: (bloc) => bloc.add(GoToPage(pageIndex: 5)),
        expect: () => [],
      );

      blocTest<ReadingBloc, ReadingState>(
        'handles go to page with empty pages list',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: [],
          currentPageIndex: 0,
        ),
        act: (bloc) => bloc.add(GoToPage(pageIndex: 0)),
        expect: () => [],
      );

      blocTest<ReadingBloc, ReadingState>(
        'goes to first page',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 2,
        ),
        act: (bloc) => bloc.add(GoToPage(pageIndex: 0)),
        expect: () => [
          const ReadingState().copyWith(
            pages: mockPages,
            currentPageIndex: 0,
          ),
        ],
      );

      blocTest<ReadingBloc, ReadingState>(
        'stays on same page when going to current page',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: mockPages,
          currentPageIndex: 1,
        ),
        act: (bloc) => bloc.add(GoToPage(pageIndex: 1)),
        expect: () => [],
      );
    });

    group('Combined Operations', () {
      blocTest<ReadingBloc, ReadingState>(
        'handles complete reading session flow',
        build: () => readingBloc,
        act: (bloc) {
          // Open modal
          bloc.add(OpenReadingModal(pages: mockPages));
          // Navigate through pages
          bloc.add(NextPage());
          bloc.add(NextPage());
          // Go to specific page
          bloc.add(GoToPage(pageIndex: 0));
          // Close modal
          bloc.add(CloseReadingModal());
        },
        expect: () => [
          const ReadingState().copyWith(
            isModalOpen: true,
            status: ReadingStatus.success,
            pages: mockPages,
            currentPageIndex: 0,
          ),
          const ReadingState().copyWith(
            isModalOpen: true,
            status: ReadingStatus.success,
            pages: mockPages,
            currentPageIndex: 1,
          ),
          const ReadingState().copyWith(
            isModalOpen: true,
            status: ReadingStatus.success,
            pages: mockPages,
            currentPageIndex: 2,
          ),
          const ReadingState().copyWith(
            isModalOpen: true,
            status: ReadingStatus.success,
            pages: mockPages,
            currentPageIndex: 0,
          ),
          const ReadingState().copyWith(
            isModalOpen: false,
            status: ReadingStatus.success,
            pages: mockPages,
            currentPageIndex: 0,
          ),
        ],
      );

      blocTest<ReadingBloc, ReadingState>(
        'handles navigation without opening modal first',
        build: () => readingBloc,
        act: (bloc) {
          bloc.add(NextPage());
          bloc.add(PreviousPage());
          bloc.add(GoToPage(pageIndex: 5));
        },
        expect: () => [],
      );
    });

    group('State Management', () {
      test('ReadingState copyWith works correctly', () {
        const initialState = ReadingState();
        final newState = initialState.copyWith(
          isModalOpen: true,
          currentPageIndex: 5,
          pages: [
            ReadingPage(title: 'Page 1', content: 'Page 1'),
            ReadingPage(title: 'Page 2', content: 'Page 2')
          ],
        );

        expect(newState.isModalOpen, true);
        expect(newState.currentPageIndex, 5);
        expect(newState.pages, [
          ReadingPage(title: 'Page 1', content: 'Page 1'),
          ReadingPage(title: 'Page 2', content: 'Page 2')
        ]);
        expect(newState.status, initialState.status);
      });

      test('ReadingState equality works correctly', () {
        const state1 = ReadingState();
        const state2 = ReadingState();
        final state3 = const ReadingState().copyWith(isModalOpen: true);

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });
    });

    group('Edge Cases', () {
      blocTest<ReadingBloc, ReadingState>(
        'handles very large pages list',
        build: () => readingBloc,
        act: (bloc) {
          final largePagesData = List.generate(
              1000,
              (index) => ReadingPage(
                  title: 'Page ${index + 1}', content: 'Content ${index + 1}'));
          bloc.add(OpenReadingModal(pages: largePagesData));
          bloc.add(GoToPage(pageIndex: 999));
        },
        expect: () => [
          ReadingState().copyWith(
            isModalOpen: true,
            status: ReadingStatus.success,
            pages: List.generate(
                1000,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 0,
          ),
          ReadingState().copyWith(
            isModalOpen: true,
            status: ReadingStatus.success,
            pages: List.generate(
                1000,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 999,
          ),
        ],
      );

      blocTest<ReadingBloc, ReadingState>(
        'handles rapid page navigation',
        build: () => readingBloc,
        seed: () => const ReadingState().copyWith(
          pages: List.generate(
              20,
              (index) => ReadingPage(
                  title: 'Page ${index + 1}', content: 'Content ${index + 1}')),
          currentPageIndex: 10,
        ),
        act: (bloc) {
          for (int i = 0; i < 5; i++) {
            bloc.add(NextPage());
          }
          for (int i = 0; i < 10; i++) {
            bloc.add(PreviousPage());
          }
        },
        expect: () => [
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 11,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 12,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 13,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 14,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 15,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 14,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 13,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 12,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 11,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 10,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 9,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 8,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 7,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 6,
          ),
          ReadingState().copyWith(
            pages: List.generate(
                20,
                (index) => ReadingPage(
                    title: 'Page ${index + 1}',
                    content: 'Content ${index + 1}')),
            currentPageIndex: 5,
          ),
        ],
      );
    });
  });
}
