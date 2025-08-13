enum ExceptionType {
  requestCancelled,
  requestTimeout,
  noInternetConnection,
  timeout,
  unauthorisedRequest,
  badRequest,
  notFound,
  internalServerError,
  serviceUnavailable,
  unknownError,
  formatException,
  unauthorizedUser,
  conflict,
}

extension ExceptionTypeExtension on ExceptionType {
  String get message {
    switch (this) {
      case ExceptionType.requestCancelled:
        return ('İstek iptal edildi! ');

      case ExceptionType.requestTimeout:
        return ('İstek zamanaşımına uğradı!');

      case ExceptionType.noInternetConnection:
        return ('İnternet bağlantısı bulunamadı. Uygulamayı kullanabilmeniz için internete ihtiyacınız vardır!');

      case ExceptionType.timeout:
        return ('Zamanaşımı hatası. Lütfen daha sonra tekrar deneyiniz!');

      case ExceptionType.unauthorisedRequest:
        return ('Yetkisiz İstek!');

      case ExceptionType.notFound:
        return ('404 - Bulunamadı! || 404');

      case ExceptionType.internalServerError:
        return ('Sunucu hatası oluştu. Lütfen daha sonra tekrar deneyiniz! || 500');

      case ExceptionType.serviceUnavailable:
        return ('Sunucuya ulaşılamıyor. Lütfen daha sonra tekrar deneyiniz.! || 503');

      case ExceptionType.unknownError:
        return ('Bilinmeyen bir hata oluştu. Lütfen daha sonra tekrar deneyiniz!');

      case ExceptionType.formatException:
        return ('formatException!');

      case ExceptionType.badRequest:
        return ('Kullanıcı adı veya şifre hatalı');

      case ExceptionType.unauthorizedUser: // 488

        return ('Yetkisiz Kullanıcı - Hata aldıysa eğer logout eder. || 488'); // verdiği durumlarda kullanıcı login sonrasında veren authorization token süresi dolduğunda
      case ExceptionType.conflict: // 409
        return ('Kayıt zaten mevcut || 409');
    }
  }
}
