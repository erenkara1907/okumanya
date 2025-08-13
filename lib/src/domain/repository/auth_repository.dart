import 'package:dartz/dartz.dart';
import '../../app/network/exceptions.dart';
import '../../app/network/network_data_manager.dart';
import '../../data/models/user_model.dart';
import '../../data/models/profile_model.dart';
import '../../shared/enum/exception_type.dart';
import '../../shared/url/endpoints.dart';

abstract class IAuthRepository {
  Future<Either<ServerException, UserModel>> login(
    String user,
    String pass,
    String pushToken,
    String lang,
  );
  
  Future<Either<ServerException, ProfileModel>> getProfile();
}

class AuthRepository extends IAuthRepository {
  final NetworkDataManager networkDataManager;

  AuthRepository({required this.networkDataManager});

  @override
  Future<Either<ServerException, UserModel>> login(
    String user,
    String pass,
    String pushToken,
    String lang,
  ) async {
    try {
      final response = await networkDataManager.post(
        Endpoints.login,
        queryParameters: {
          'user': user,
          'pass': pass,
          'pushtoken': pushToken,
          'lang': lang,
        },
      );

      final responseData = response.data;
      
      if (responseData == null) {
        return Left(
          ServerException(
            ExceptionType.unknownError,
            message: 'Sunucudan geçersiz yanıt alındı',
          ),
        );
      }

      if (responseData is Map<String, dynamic>) {
        final success = responseData['success'];
        if (success == false) {
          return Left(
            ServerException(
              ExceptionType.badRequest,
              message: responseData['message']?.toString() ?? 'Giriş başarısız',
            ),
          );
        } else {
          try {
            final data = UserModel.fromJson(responseData);
            return Right(data);
          } catch (e) {
            return Left(
              ServerException(
                ExceptionType.formatException,
                message: 'Kullanıcı verileri işlenirken hata oluştu',
              ),
            );
          }
        }
      } else {
        return Left(
          ServerException(
            ExceptionType.unknownError,
            message: 'Beklenmeyen yanıt formatı',
          ),
        );
      }
    } on ServerException catch (err) {
      return Left(
        ServerException(err.exceptionType),
      );
    }
  }

  @override
  Future<Either<ServerException, ProfileModel>> getProfile() async {
    try {
      final response = await networkDataManager.get(Endpoints.getProfile);
      
      final responseData = response.data;
      
      if (responseData == null) {
        return Left(
          ServerException(
            ExceptionType.unknownError,
            message: 'Sunucudan geçersiz yanıt alındı',
          ),
        );
      }

      if (responseData is Map<String, dynamic>) {
        try {
          final data = ProfileModel.fromJson(responseData);
          return Right(data);
        } catch (e) {
          return Left(
            ServerException(
              ExceptionType.formatException,
              message: 'Profil verileri işlenirken hata oluştu',
            ),
          );
        }
      } else {
        return Left(
          ServerException(
            ExceptionType.unknownError,
            message: 'Beklenmeyen yanıt formatı',
          ),
        );
      }
    } on ServerException catch (err) {
      return Left(
        ServerException(err.exceptionType, message: err.message),
      );
    }
  }
}