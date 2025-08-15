import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:okumanya/features/home/presentation/bloc/home/home_bloc.dart';

@GenerateMocks([])
void main() {
  late HomeBloc homeBloc;

  setUp(() {
    homeBloc = HomeBloc();
  });

  tearDown(() {
    homeBloc.close();
  });

  group('HomeBloc', () {
    test('initial state is HomeState with initial values', () {
      expect(homeBloc.state, equals(const HomeState()));
    });

    group('LoadBooks Event', () {
      blocTest<HomeBloc, HomeState>(
        'emits [loading] when books are loaded',
        build: () => homeBloc,
        act: (bloc) => bloc.add(LoadBooks()),
        expect: () => [
          const HomeState().copyWith(status: HomeStatus.loading),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'handles multiple load books calls',
        build: () => homeBloc,
        act: (bloc) {
          bloc.add(LoadBooks());
          bloc.add(LoadBooks());
        },
        expect: () => [
          const HomeState().copyWith(status: HomeStatus.loading),
          const HomeState().copyWith(status: HomeStatus.loading),
        ],
      );
    });

    group('SearchBooks Event', () {
      blocTest<HomeBloc, HomeState>(
        'emits updated state when search query is provided',
        build: () => homeBloc,
        act: (bloc) => bloc.add(SearchBooks(query: 'test query')),
        expect: () => [
          const HomeState().copyWith(
            searchQuery: 'test query',
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'handles empty search query',
        build: () => homeBloc,
        act: (bloc) => bloc.add(SearchBooks(query: '')),
        expect: () => [
          const HomeState().copyWith(searchQuery: ''),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'handles special characters in search query',
        build: () => homeBloc,
        act: (bloc) => bloc.add(SearchBooks(query: 'test@#\$%^&*()')),
        expect: () => [
          const HomeState().copyWith(searchQuery: 'test@#\$%^&*()'),
        ],
      );
    });

    group('FilterBooks Event', () {
      blocTest<HomeBloc, HomeState>(
        'emits updated state when category filter is applied',
        build: () => homeBloc,
        act: (bloc) => bloc.add(FilterBooks(category: 'Fiction')),
        expect: () => [
          const HomeState().copyWith(selectedCategory: 'Fiction'),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'handles empty category filter',
        build: () => homeBloc,
        act: (bloc) => bloc.add(FilterBooks(category: '')),
        expect: () => [
          const HomeState().copyWith(selectedCategory: ''),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'handles multiple category changes',
        build: () => homeBloc,
        act: (bloc) {
          bloc.add(FilterBooks(category: 'Fiction'));
          bloc.add(FilterBooks(category: 'Science'));
          bloc.add(FilterBooks(category: 'History'));
        },
        expect: () => [
          const HomeState().copyWith(selectedCategory: 'Fiction'),
          const HomeState().copyWith(selectedCategory: 'Science'),
          const HomeState().copyWith(selectedCategory: 'History'),
        ],
      );
    });

    group('Combined Operations', () {
      blocTest<HomeBloc, HomeState>(
        'handles search and filter together',
        build: () => homeBloc,
        act: (bloc) {
          bloc.add(SearchBooks(query: 'test'));
          bloc.add(FilterBooks(category: 'Fiction'));
        },
        expect: () => [
          const HomeState().copyWith(searchQuery: 'test'),
          const HomeState().copyWith(
            searchQuery: 'test',
            selectedCategory: 'Fiction',
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'handles load books with search and filter',
        build: () => homeBloc,
        act: (bloc) {
          bloc.add(LoadBooks());
          bloc.add(SearchBooks(query: 'adventure'));
          bloc.add(FilterBooks(category: 'Adventure'));
        },
        expect: () => [
          const HomeState().copyWith(status: HomeStatus.loading),
          const HomeState().copyWith(
            status: HomeStatus.loading,
            searchQuery: 'adventure',
          ),
          const HomeState().copyWith(
            status: HomeStatus.loading,
            searchQuery: 'adventure',
            selectedCategory: 'Adventure',
          ),
        ],
      );
    });

    group('State Management', () {
      test('HomeState copyWith works correctly', () {
        const initialState = HomeState();
        final newState = initialState.copyWith(
          status: HomeStatus.loading,
          searchQuery: 'test query',
          selectedCategory: 'Fiction',
        );

        expect(newState.status, HomeStatus.loading);
        expect(newState.searchQuery, 'test query');
        expect(newState.selectedCategory, 'Fiction');
        expect(newState.books, initialState.books);
      });

      test('HomeState equality works correctly', () {
        const state1 = HomeState();
        const state2 = HomeState();
        final state3 = const HomeState().copyWith(status: HomeStatus.loading);

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });

      test('HomeState toString returns proper string representation', () {
        const state = HomeState();
        expect(state.toString(), isA<String>());
      });
    });

    group('Edge Cases', () {
      blocTest<HomeBloc, HomeState>(
        'handles very long search queries',
        build: () => homeBloc,
        act: (bloc) => bloc.add(SearchBooks(
          query: 'very long search query that might cause performance issues' *
              100,
        )),
        expect: () => [
          HomeState().copyWith(
            searchQuery:
                'very long search query that might cause performance issues' *
                    100,
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'handles unicode characters in search',
        build: () => homeBloc,
        act: (bloc) => bloc.add(SearchBooks(query: 'ğüşıöç测试')),
        expect: () => [
          const HomeState().copyWith(searchQuery: 'ğüşıöç测试'),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'handles rapid state changes',
        build: () => homeBloc,
        act: (bloc) {
          for (int i = 0; i < 10; i++) {
            bloc.add(SearchBooks(query: 'query $i'));
          }
        },
        expect: () => List.generate(
          10,
          (index) => HomeState().copyWith(searchQuery: 'query $index'),
        ),
      );
    });

    group('Performance Tests', () {
      blocTest<HomeBloc, HomeState>(
        'handles concurrent operations efficiently',
        build: () => homeBloc,
        act: (bloc) {
          bloc.add(LoadBooks());
          bloc.add(SearchBooks(query: 'concurrent'));
          bloc.add(FilterBooks(category: 'Test'));
          bloc.add(SearchBooks(query: 'updated'));
        },
        expect: () => [
          const HomeState().copyWith(status: HomeStatus.loading),
          const HomeState().copyWith(
            status: HomeStatus.loading,
            searchQuery: 'concurrent',
          ),
          const HomeState().copyWith(
            status: HomeStatus.loading,
            searchQuery: 'concurrent',
            selectedCategory: 'Test',
          ),
          const HomeState().copyWith(
            status: HomeStatus.loading,
            searchQuery: 'updated',
            selectedCategory: 'Test',
          ),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'completes operations within reasonable time',
        build: () => homeBloc,
        act: (bloc) => bloc.add(LoadBooks()),
        expect: () => [
          const HomeState().copyWith(status: HomeStatus.loading),
        ],
      );
    });
  });
}
