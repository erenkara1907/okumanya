// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> tr_TR = {
  "rememberMe": "Beni Hatırla",
  "username": "Kullanıcı Adı",
  "password": "Şifre",
  "login": "Giriş Yap",
  "error": "Hata",
  "usernameRequired": "Lütfen Kullanıcı Adınızı Giriniz",
  "passwordRequired": "Lütfen Parolanızı Giriniz",
  "homeDesc": "Aşağıda transfer listesini görüntülüyorsun. Transferleri onaylayabilir veya iptal edebilirsin.",
  "confirmed": "Onaylandı",
  "denied": "Reddedildi",
  "confirm": "Onayla",
  "deny": "Reddet",
  "addTransferDesc": "Yeni bir transfer oluşturmak için aşağıdaki bilgileri doldurun.",
  "customerName": "Müşteri Adı",
  "enterName": "Müşteri Adını Giriniz",
  "customerPhone": "Müşteri Telefon No",
  "enterPhone": "Müşteri Telefon No Giriniz",
  "driver": "Şoför",
  "pickupLoc": "Alış Konumu",
  "selectPickupLoc": "Alış Konumu Seçiniz",
  "pickupDate": "Alış Tarihi",
  "selectPickupDate": "Alış Tarihi Seçiniz",
  "pickupTime": "Alış Saati",
  "selectPickupTime": "Alış Saati Seçiniz",
  "dropLoc": "Teslim Konumu",
  "selectDropLoc": "Teslim Konumu Seçiniz",
  "flightNo": "Uçuş No",
  "enterFlight": "Uçuş No Giriniz",
  "personCount": "Kişi Sayısı",
  "enterPersonCount": "Kişi Sayısı Giriniz",
  "price": "Ücret",
  "enterPrice": "Ücret Giriniz",
  "createTransfer": "Transfer Oluştur",
  "name": "Adı",
  "logout": "Çıkış Yap"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr_TR": tr_TR};
}
