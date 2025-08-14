import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:okumanya/core/error/exceptions.dart';
import 'package:okumanya/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:okumanya/features/auth/data/models/login_response_model.dart';
import 'package:okumanya/features/auth/data/models/user_model.dart';
import 'package:okumanya/features/auth/data/models/login_request_model.dart';

import 'auth_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = AuthRemoteDataSourceImpl(mockDio);
  });

  group('AuthRemoteDataSource', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tLoginRequest = LoginRequestModel(email: tEmail, password: tPassword);

    final tUserModelJson = {
      'id': 1,
      'name': 'John Doe',
      'last_name': null,
      'email': tEmail,
      'user_level': 1,
      'user_role': 'student',
      'created_at': '2023-01-15T00:00:00.000Z',
      'updated_at': '2023-01-15T00:00:00.000Z',
      'email_verified_at': null,
      'phone': null,
      'avatar': null,
      'birth_date': null,
      'gender': null,
      'status': 'active',
    };

    final tLoginResponseModelJson = {
      'token': 'test_token_123',
      'is_teacher': false,
      'user': tUserModelJson,
    };

    final tLoginResponseModel = LoginResponseModel.fromJson(tLoginResponseModelJson);

    group('login', () {
      test('should perform POST request on correct endpoint', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: tLoginResponseModelJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        await dataSource.login(tLoginRequest);

        // assert
        verify(mockDio.post(
          '/login',
          data: {'email': tEmail, 'password': tPassword},
          options: anyNamed('options'),
        ));
      });

      test('should return LoginResponseModel when response code is 200', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: tLoginResponseModelJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final result = await dataSource.login(tLoginRequest);

        // assert
        expect(result, tLoginResponseModel);
      });

      test('should throw AuthException when response code is 401', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 401,
            data: {'message': 'Invalid credentials'},
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<AuthException>()),
        );
      });

      test('should throw NotFoundException when response code is 404', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 404,
            data: {'message': 'User not found'},
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<NotFoundException>()),
        );
      });

      test('should throw ServerException when response code is 500', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            data: {'message': 'Internal server error'},
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<ServerException>()),
        );
      });

      test('should throw NetworkException when there is no connection', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<NetworkException>()),
        );
      });

      test('should throw NetworkException when request times out', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.sendTimeout,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<NetworkException>()),
        );
      });

      test('should throw NetworkException when receive timeout occurs', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<NetworkException>()),
        );
      });

      test('should throw CacheException when response data is invalid JSON', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: 'invalid json response',
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<CacheException>()),
        );
      });

      test('should handle successful login with teacher role', () async {
        // arrange
        final tTeacherResponseJson = {
          'token': 'teacher_token_456',
          'is_teacher': true,
          'user': {
            ...tUserModelJson,
            'id': 2,
            'name': 'Jane Teacher',
            'email': 'teacher@example.com',
            'user_role': 'teacher',
            'user_level': 3,
          },
        };

        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: tTeacherResponseJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final result = await dataSource.login(LoginRequestModel(email: 'teacher@example.com', password: 'teacherpass'));

        // assert
        expect(result.isTeacher, true);
        expect(result.user.userRole, 'teacher');
        expect(result.token, 'teacher_token_456');
      });

      test('should handle response with missing optional user fields', () async {
        // arrange
        final tMinimalUserJson = {
          'id': 1,
          'name': 'Minimal User',
          'email': tEmail,
          'user_level': 1,
          'user_role': 'student',
          'created_at': '2023-01-15T00:00:00.000Z',
          'updated_at': '2023-01-15T00:00:00.000Z',
          // Missing optional fields
        };

        final tMinimalResponseJson = {
          'token': 'minimal_token',
          'is_teacher': false,
          'user': tMinimalUserJson,
        };

        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: tMinimalResponseJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final result = await dataSource.login(tLoginRequest);

        // assert
        expect(result.user.name, 'Minimal User');
        expect(result.user.lastName, isNull);
        expect(result.user.phoneNumber, isNull);
      });

      test('should handle validation errors (422 status code)', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 422,
            data: {
              'message': 'Validation failed',
              'errors': {
                'email': ['The email field is required.'],
                'password': ['The password field is required.']
              }
            },
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(LoginRequestModel(email: '', password: '')),
          throwsA(isA<ValidationException>()),
        );
      });

      test('should handle malformed response structure', () async {
        // arrange
        final tMalformedResponse = {
          'token': 'test_token',
          // Missing 'is_teacher' field
          'user': tUserModelJson,
        };

        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: tMalformedResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<CacheException>()),
        );
      });

      test('should set correct headers for login request', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: tLoginResponseModelJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        await dataSource.login(tLoginRequest);

        // assert
        verify(mockDio.post(
          any,
          data: any,
          options: argThat(
            predicate<Options>((options) =>
              options.headers?['Content-Type'] == 'application/json' &&
              options.headers?['Accept'] == 'application/json'
            ),
            named: 'options',
          ),
        ));
      });
    });

    group('Edge Cases', () {
      test('should handle very long email addresses', () async {
        // arrange
        const longEmail = 'very.long.email.address@very.long.domain.name.example.com';
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: {
            ...tLoginResponseModelJson,
            'user': {...tUserModelJson, 'email': longEmail},
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final result = await dataSource.login(LoginRequestModel(email: longEmail, password: tPassword));

        // assert
        expect(result.user.email, longEmail);
        verify(mockDio.post(
          any,
          data: {'email': longEmail, 'password': tPassword},
          options: anyNamed('options'),
        ));
      });

      test('should handle special characters in credentials', () async {
        // arrange
        const specialEmail = 'test+special@example.com';
        const specialPassword = 'P@ssw0rd!#\$%^&*()';
        
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: tLoginResponseModelJson,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final result = await dataSource.login(LoginRequestModel(email: specialEmail, password: specialPassword));

        // assert
        expect(result, isA<LoginResponseModel>());
        verify(mockDio.post(
          any,
          data: {'email': specialEmail, 'password': specialPassword},
          options: anyNamed('options'),
        ));
      });

      test('should handle unicode characters in credentials', () async {
        // arrange
        const unicodeEmail = 'tëst@éxämplé.com';
        const unicodePassword = 'pässwörd123ñ';
        
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: {
            ...tLoginResponseModelJson,
            'user': {...tUserModelJson, 'email': unicodeEmail},
          },
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final result = await dataSource.login(LoginRequestModel(email: unicodeEmail, password: unicodePassword));

        // assert
        expect(result.user.email, unicodeEmail);
      });

      test('should handle empty response body', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<CacheException>()),
        );
      });

      test('should handle response with extra unexpected fields', () async {
        // arrange
        final tResponseWithExtraFields = {
          ...tLoginResponseModelJson,
          'extra_field': 'extra_value',
          'another_field': 123,
          'user': {
            ...tUserModelJson,
            'unexpected_field': 'unexpected_value',
          },
        };

        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: tResponseWithExtraFields,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final result = await dataSource.login(tLoginRequest);

        // assert
        expect(result.token, 'test_token_123');
        expect(result.user.email, tEmail);
        // Should ignore extra fields gracefully
      });
    });

    group('Performance Tests', () {
      test('should complete login request within reasonable time', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async {
          // Simulate network delay
          await Future.delayed(const Duration(milliseconds: 50));
          return Response(
            data: tLoginResponseModelJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          );
        });

        // act
        final stopwatch = Stopwatch()..start();
        await dataSource.login(tLoginRequest);
        stopwatch.stop();

        // assert
        expect(stopwatch.elapsedMilliseconds, lessThan(500));
      });

      test('should handle large response payloads', () async {
        // arrange
        final largeUserData = {
          ...tUserModelJson,
          'bio': 'Very long biography text ' * 1000, // Large text field
          'preferences': List.generate(1000, (i) => 'preference_$i'),
        };

        final largeResponse = {
          ...tLoginResponseModelJson,
          'user': largeUserData,
          'additional_data': List.generate(100, (i) => 'data_$i'),
        };

        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenAnswer((_) async => Response(
          data: largeResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final result = await dataSource.login(tLoginRequest);

        // assert
        expect(result, isA<LoginResponseModel>());
        expect(result.user.email, tEmail);
      });
    });

    group('Error Handling Edge Cases', () {
      test('should handle DioException with null response', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions(path: ''),
          response: null,
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<NetworkException>()),
        );
      });

      test('should handle generic exceptions', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(Exception('Generic error'));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<CacheException>()),
        );
      });

      test('should handle response with non-standard error format', () async {
        // arrange
        when(mockDio.post(
          any,
          data: anyNamed('data'),
          options: anyNamed('options'),
        )).thenThrow(DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 400,
            data: 'Plain text error message',
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ));

        // act
        final call = dataSource.login;

        // assert
        expect(
          () => call(tLoginRequest),
          throwsA(isA<ServerException>()),
        );
      });
    });
  });
}