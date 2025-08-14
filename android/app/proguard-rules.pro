# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Gson specific classes
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Keep model classes (if using JSON serialization)
-keep class **.data.models.** { *; }
-keep class **.domain.entities.** { *; }

# BLoC/Cubit classes
-keep class **.bloc.** { *; }
-keep class **.cubit.** { *; }

# Hive database
-keep class hive_flutter.** { *; }
-keep class **.g.dart
-keepnames class * extends HiveObject

# Connectivity
-keep class io.flutter.plugins.connectivity.** { *; }

# Device Info
-keep class io.flutter.plugins.deviceinfo.** { *; }

# Secure Storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# Path Provider
-keep class io.flutter.plugins.pathprovider.** { *; }

# Package Info
-keep class io.flutter.plugins.packageinfo.** { *; }

# Share Plus
-keep class dev.fluttercommunity.plus.share.** { *; }

# URL Launcher
-keep class io.flutter.plugins.urllauncher.** { *; }

# Remove debug logs in release
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}