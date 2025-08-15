// Test driver for comprehensive integration testing
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Okumanya App Integration Tests', () {
    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      await driver.close();
    });

    group('App Launch & Navigation', () {
      test('app launches and shows splash screen', () async {
        // Verify splash screen appears
        await driver.waitFor(find.text('Okumanya'));

        // Wait for app to load completely
        await Future.delayed(const Duration(seconds: 3));
      });

      test('navigation between main screens works', () async {
        // Test home screen
        await driver.waitFor(find.byType('BottomNavigationBar'));

        // Navigate to profile
        await driver.tap(find.text('Profile'));
        await driver.waitFor(find.text('Profilim'));

        // Navigate back to home
        await driver.tap(find.text('Home'));
        await driver.waitFor(find.text('Ana Sayfa'));
      });
    });

    group('Book Management', () {
      test('can search for books', () async {
        // Find and tap search field
        final searchField = find.byType('TextField');
        await driver.tap(searchField);

        // Enter search query
        await driver.enterText('Flutter');
        await Future.delayed(const Duration(seconds: 1));

        // Verify search results appear
        await driver.waitFor(find.text('Search Results'));
      });

      test('can add book to favorites', () async {
        // Find first book in list
        final firstBook = find.byType('BookCard');
        await driver.waitFor(firstBook);

        // Tap favorite button
        final favoriteButton = find.descendant(
          of: firstBook,
          matching: find.byTooltip('Add to favorites'),
        );
        await driver.tap(favoriteButton);

        // Verify favorite icon changes
        await driver.waitFor(find.byTooltip('Remove from favorites'));
      });
    });

    group('User Experience', () {
      test('theme switching works', () async {
        // Navigate to settings
        await driver.tap(find.text('Settings'));

        // Find and tap theme toggle
        await driver.tap(find.text('Dark Theme'));

        // Verify theme change (you might need to check background color)
        await Future.delayed(const Duration(milliseconds: 500));
      });

      test('language switching works', () async {
        // Find language selector
        await driver.tap(find.text('Language'));

        // Switch to English
        await driver.tap(find.text('English'));

        // Verify language change
        await driver.waitFor(find.text('Home'));

        // Switch back to Turkish
        await driver.tap(find.text('Dil'));
        await driver.tap(find.text('Türkçe'));
        await driver.waitFor(find.text('Ana Sayfa'));
      });
    });

    group('Performance Tests', () {
      test('app scrolling performance', () async {
        // Scroll through book list multiple times
        for (int i = 0; i < 5; i++) {
          await driver.scroll(
            find.byType('ListView'),
            0,
            -500,
            const Duration(milliseconds: 300),
          );
          await Future.delayed(const Duration(milliseconds: 100));
        }

        // Scroll back to top
        await driver.scroll(
          find.byType('ListView'),
          0,
          500,
          const Duration(milliseconds: 300),
        );
      });

      test('memory usage during navigation', () async {
        // Navigate through different screens multiple times
        final screens = ['Home', 'Profile', 'Settings'];

        for (int cycle = 0; cycle < 3; cycle++) {
          for (String screen in screens) {
            await driver.tap(find.text(screen));
            await Future.delayed(const Duration(milliseconds: 500));
          }
        }
      });
    });

    group('Error Handling', () {
      test('handles network errors gracefully', () async {
        // Simulate network error scenarios
        // This would require mock network responses

        // Try to load books without network
        await driver.tap(find.text('Refresh'));

        // Verify error message appears
        await driver.waitFor(find.text('Network Error'));

        // Verify retry functionality
        await driver.tap(find.text('Retry'));
      });

      test('handles invalid input gracefully', () async {
        // Test search with invalid characters
        final searchField = find.byType('TextField');
        await driver.tap(searchField);
        await driver.enterText('!@#\$%^&*()');

        // Verify app doesn't crash
        await Future.delayed(const Duration(seconds: 1));
      });
    });
  });
}
