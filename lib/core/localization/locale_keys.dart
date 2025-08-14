import 'package:easy_localization/easy_localization.dart';

class LocaleKeys {
  LocaleKeys._();

  // App
  static const app = _App();

  // Common
  static const common = _Common();

  // Auth
  static const auth = _Auth();

  // Home
  static const home = _Home();

  // Books
  static const books = _Books();

  // Profile
  static const profile = _Profile();

  // Search
  static const search = _Search();

  // Settings
  static const settings = _Settings();

  // Notifications
  static const notifications = _Notifications();

  // Errors
  static const errors = _Errors();

  // Offline
  static const offline = _Offline();
}

class _App {
  const _App();
  String get name => 'app.name'.tr();
  String get title => 'app.title'.tr();
  String get description => 'app.description'.tr();
}

class _Common {
  const _Common();
  String get loading => 'common.loading'.tr();
  String get error => 'common.error'.tr();
  String get success => 'common.success'.tr();
  String get retry => 'common.retry'.tr();
  String get cancel => 'common.cancel'.tr();
  String get confirm => 'common.confirm'.tr();
  String get ok => 'common.ok'.tr();
  String get save => 'common.save'.tr();
  String get delete => 'common.delete'.tr();
  String get edit => 'common.edit'.tr();
  String get search => 'common.search'.tr();
  String get filter => 'common.filter'.tr();
  String get sort => 'common.sort'.tr();
  String get refresh => 'common.refresh'.tr();
  String get back => 'common.back'.tr();
  String get next => 'common.next'.tr();
  String get previous => 'common.previous'.tr();
  String get done => 'common.done'.tr();
  String get close => 'common.close'.tr();
  String get add => 'common.add'.tr();
  String get remove => 'common.remove'.tr();
  String get share => 'common.share'.tr();
  String get favorite => 'common.favorite'.tr();
  String get favorites => 'common.favorites'.tr();
  String get recent => 'common.recent'.tr();
  String get popular => 'common.popular'.tr();
  String get new_ => 'common.new'.tr();
  String get all => 'common.all'.tr();
  String get none => 'common.none'.tr();
  String get yes => 'common.yes'.tr();
  String get no => 'common.no'.tr();
  String get failed => 'common.failed'.tr();
}

class _Auth {
  const _Auth();
  String get login => 'auth.login'.tr();
  String get logout => 'auth.logout'.tr();
  String get register => 'auth.register'.tr();
  String get forgotPassword => 'auth.forgotPassword'.tr();
  String get username => 'auth.username'.tr();
  String get password => 'auth.password'.tr();
  String get email => 'auth.email'.tr();
  String get confirmPassword => 'auth.confirmPassword'.tr();
  String get rememberMe => 'auth.rememberMe'.tr();
  String get loginButton => 'auth.loginButton'.tr();
  String get registerButton => 'auth.registerButton'.tr();
  String get orLoginWith => 'auth.orLoginWith'.tr();
  String get alreadyHaveAccount => 'auth.alreadyHaveAccount'.tr();
  String get dontHaveAccount => 'auth.dontHaveAccount'.tr();

  // Auth Validation
  _AuthValidation get validation => const _AuthValidation();

  // Auth Errors
  _AuthErrors get errors => const _AuthErrors();
}

class _AuthValidation {
  const _AuthValidation();
  String get usernameRequired => 'auth.validation.usernameRequired'.tr();
  String get passwordRequired => 'auth.validation.passwordRequired'.tr();
  String get emailRequired => 'auth.validation.emailRequired'.tr();
  String get emailInvalid => 'auth.validation.emailInvalid'.tr();
  String get passwordTooShort => 'auth.validation.passwordTooShort'.tr();
  String get passwordsNotMatch => 'auth.validation.passwordsNotMatch'.tr();
}

class _AuthErrors {
  const _AuthErrors();
  String get loginFailed => 'auth.errors.loginFailed'.tr();
  String get registerFailed => 'auth.errors.registerFailed'.tr();
  String get networkError => 'auth.errors.networkError'.tr();
  String get invalidCredentials => 'auth.errors.invalidCredentials'.tr();
  String get userNotFound => 'auth.errors.userNotFound'.tr();
  String get emailAlreadyExists => 'auth.errors.emailAlreadyExists'.tr();
  String get sessionExpired => 'auth.errors.sessionExpired'.tr();
}

class _Home {
  const _Home();
  String get title => 'home.title'.tr();
  String get welcome => 'home.welcome'.tr();
  String get library => 'home.library'.tr();
  String get recentlyRead => 'home.recentlyRead'.tr();
  String get continueReading => 'home.continueReading'.tr();
  String get recommendations => 'home.recommendations'.tr();
  String get categories => 'home.categories'.tr();
  String get searchPlaceholder => 'home.searchPlaceholder'.tr();
  String get searchHint => 'home.searchHint'.tr();
  String get noBooks => 'home.noBooks'.tr();
  String get noBooksFound => 'home.noBooksFound'.tr();
  String get allBooks => 'home.allBooks'.tr();
  String get loadingBooks => 'home.loadingBooks'.tr();
  String get errorLoadingBooks => 'home.errorLoadingBooks'.tr();
  String get offlineMode => 'home.offlineMode'.tr();
  String get syncData => 'home.syncData'.tr();
  String get viewAll => 'home.viewAll'.tr();
  String get science => 'home.science'.tr();
  String get filter => 'home.filter'.tr();
  String get search => 'home.search'.tr();
}

class _Books {
  const _Books();
  String get title => 'books.title'.tr();
  String get book => 'books.book'.tr();
  String get author => 'books.author'.tr();
  String get category => 'books.category'.tr();
  String get progress => 'books.progress'.tr();
  String get completed => 'books.completed'.tr();
  String get inProgress => 'books.inProgress'.tr();
  String get notStarted => 'books.notStarted'.tr();
  String get pages => 'books.pages'.tr();
  String get page => 'books.page'.tr();
  String get readingTime => 'books.readingTime'.tr();
  String get description => 'books.description'.tr();
  String get details => 'books.details'.tr();
  String get addToFavorites => 'books.addToFavorites'.tr();
  String get removeFromFavorites => 'books.removeFromFavorites'.tr();
  String get startReading => 'books.startReading'.tr();
  String get continueReading => 'books.continueReading'.tr();
  String get markAsCompleted => 'books.markAsCompleted'.tr();
  String get shareBook => 'books.shareBook'.tr();
  String get downloadBook => 'books.downloadBook'.tr();
  String get rating => 'books.rating'.tr();
  String get reviews => 'books.reviews'.tr();
  String get summary => 'books.summary'.tr();
  String get tableOfContents => 'books.tableOfContents'.tr();
  String get bookmarks => 'books.bookmarks'.tr();
  String get notes => 'books.notes'.tr();
  String get highlights => 'books.highlights'.tr();
  String get readingStats => 'books.readingStats'.tr();
  String get readPercentage => 'books.readPercentage'.tr();
  String get level => 'books.level'.tr();

  // Book Filters (for English)
  _BookFilters get filters => const _BookFilters();
  
  // Book Categories (for English)
  _BookCategories get categories => const _BookCategories();
}

class _BookFilters {
  const _BookFilters();
  String get all => 'books.filters.all'.tr();
  String get favorites => 'books.filters.favorites'.tr();
  String get completed => 'books.filters.completed'.tr();
  String get inProgress => 'books.filters.inProgress'.tr();
  String get notStarted => 'books.filters.notStarted'.tr();
  String get recentlyAdded => 'books.filters.recentlyAdded'.tr();
  String get alphabetical => 'books.filters.alphabetical'.tr();
  String get byAuthor => 'books.filters.byAuthor'.tr();
  String get byCategory => 'books.filters.byCategory'.tr();
  String get byProgress => 'books.filters.byProgress'.tr();
}

class _BookCategories {
  const _BookCategories();
  String get fiction => 'books.categories.fiction'.tr();
  String get nonFiction => 'books.categories.nonFiction'.tr();
  String get science => 'books.categories.science'.tr();
  String get technology => 'books.categories.technology'.tr();
  String get history => 'books.categories.history'.tr();
  String get biography => 'books.categories.biography'.tr();
  String get selfHelp => 'books.categories.selfHelp'.tr();
  String get business => 'books.categories.business'.tr();
  String get romance => 'books.categories.romance'.tr();
  String get mystery => 'books.categories.mystery'.tr();
  String get thriller => 'books.categories.thriller'.tr();
  String get fantasy => 'books.categories.fantasy'.tr();
  String get sciFi => 'books.categories.sciFi'.tr();
  String get horror => 'books.categories.horror'.tr();
  String get adventure => 'books.categories.adventure'.tr();
  String get programming => 'books.categories.programming'.tr();
}

class _Profile {
  const _Profile();
  String get title => 'profile.title'.tr();
  String get profile => 'profile.profile'.tr();
  String get myProfile => 'profile.myProfile'.tr();
  String get editProfile => 'profile.editProfile'.tr();
  String get settings => 'profile.settings'.tr();
  String get preferences => 'profile.preferences'.tr();
  String get statistics => 'profile.statistics'.tr();
  String get achievements => 'profile.achievements'.tr();
  String get readingGoals => 'profile.readingGoals'.tr();
  String get personalInfo => 'profile.personalInfo'.tr();
  String get firstName => 'profile.firstName'.tr();
  String get lastName => 'profile.lastName'.tr();
  String get bio => 'profile.bio'.tr();
  String get location => 'profile.location'.tr();
  String get website => 'profile.website'.tr();
  String get joinDate => 'profile.joinDate'.tr();
  String get agenda => 'profile.agenda'.tr();
  String get goals => 'profile.goals'.tr();
  String get friends => 'profile.friends'.tr();
  String get totalReadingTime => 'profile.totalReadingTime'.tr();
  String get booksRead => 'profile.booksRead'.tr();
  String get booksListened => 'profile.booksListened'.tr();
  String get readingSpeed => 'profile.readingSpeed'.tr();
  String get ranking => 'profile.ranking'.tr();
  String get points => 'profile.points'.tr();
  String get lastPage => 'profile.lastPage'.tr();
  String get readingLevel => 'profile.readingLevel'.tr();
  String get totalPages => 'profile.totalPages'.tr();
  String get loadingProfile => 'profile.loadingProfile'.tr();
  String get errorLoadingProfile => 'profile.errorLoadingProfile'.tr();

  // Profile Stats (for English)
  _ProfileStats get stats => const _ProfileStats();
}

class _ProfileStats {
  const _ProfileStats();
  String get booksRead => 'profile.stats.booksRead'.tr();
  String get pagesRead => 'profile.stats.pagesRead'.tr();
  String get readingTime => 'profile.stats.readingTime'.tr();
  String get currentStreak => 'profile.stats.currentStreak'.tr();
  String get longestStreak => 'profile.stats.longestStreak'.tr();
  String get averageRating => 'profile.stats.averageRating'.tr();
  String get favoriteGenre => 'profile.stats.favoriteGenre'.tr();
  String get readingGoal => 'profile.stats.readingGoal'.tr();
  String get monthlyGoal => 'profile.stats.monthlyGoal'.tr();
  String get yearlyGoal => 'profile.stats.yearlyGoal'.tr();
  String get todayReading => 'profile.stats.todayReading'.tr();
  String get weekReading => 'profile.stats.weekReading'.tr();
  String get monthReading => 'profile.stats.monthReading'.tr();
  String get yearReading => 'profile.stats.yearReading'.tr();
}

class _Search {
  const _Search();
  String get searchBooks => 'search.searchBooks'.tr();
  String get searchResults => 'search.searchResults'.tr();
  String get searchPlaceholder => 'search.searchPlaceholder'.tr();
  String get noResults => 'search.noResults'.tr();
  String get searchHistory => 'search.searchHistory'.tr();
  String get clearHistory => 'search.clearHistory'.tr();
  String get popularSearches => 'search.popularSearches'.tr();
  String get suggestions => 'search.suggestions'.tr();
  String get advancedSearch => 'search.advancedSearch'.tr();

  // Search Filters
  _SearchFilters get filters => const _SearchFilters();
}

class _SearchFilters {
  const _SearchFilters();
  String get title => 'search.filters.title'.tr();
  String get author => 'search.filters.author'.tr();
  String get category => 'search.filters.category'.tr();
  String get year => 'search.filters.year'.tr();
  String get language => 'search.filters.language'.tr();
  String get rating => 'search.filters.rating'.tr();
}

class _Settings {
  const _Settings();
  String get settings => 'settings.settings'.tr();
  String get general => 'settings.general'.tr();
  String get appearance => 'settings.appearance'.tr();
  String get reading => 'settings.reading'.tr();
  String get notifications => 'settings.notifications'.tr();
  String get privacy => 'settings.privacy'.tr();
  String get about => 'settings.about'.tr();
  String get language => 'settings.language'.tr();
  String get theme => 'settings.theme'.tr();
  String get lightTheme => 'settings.lightTheme'.tr();
  String get darkTheme => 'settings.darkTheme'.tr();
  String get systemTheme => 'settings.systemTheme'.tr();
  String get fontSize => 'settings.fontSize'.tr();
  String get fontFamily => 'settings.fontFamily'.tr();
  String get lineSpacing => 'settings.lineSpacing'.tr();
  String get brightness => 'settings.brightness'.tr();
  String get readingMode => 'settings.readingMode'.tr();
  String get autoNightMode => 'settings.autoNightMode'.tr();
  String get pageAnimation => 'settings.pageAnimation'.tr();
  String get gestureControls => 'settings.gestureControls'.tr();
  String get soundEffects => 'settings.soundEffects'.tr();
  String get vibration => 'settings.vibration'.tr();
  String get autoBackup => 'settings.autoBackup'.tr();
  String get syncSettings => 'settings.syncSettings'.tr();
  String get clearCache => 'settings.clearCache'.tr();
  String get clearHistory => 'settings.clearHistory'.tr();
  String get exportData => 'settings.exportData'.tr();
  String get importData => 'settings.importData'.tr();
  String get restoreDefaults => 'settings.restoreDefaults'.tr();
  String get version => 'settings.version'.tr();
  String get buildNumber => 'settings.buildNumber'.tr();
  String get termsOfService => 'settings.termsOfService'.tr();
  String get privacyPolicy => 'settings.privacyPolicy'.tr();
  String get contactSupport => 'settings.contactSupport'.tr();
  String get rateApp => 'settings.rateApp'.tr();
  String get shareApp => 'settings.shareApp'.tr();
}

class _Notifications {
  const _Notifications();
  String get notifications => 'notifications.notifications'.tr();
  String get readingReminders => 'notifications.readingReminders'.tr();
  String get dailyGoal => 'notifications.dailyGoal'.tr();
  String get newBooks => 'notifications.newBooks'.tr();
  String get bookUpdates => 'notifications.bookUpdates'.tr();
  String get socialUpdates => 'notifications.socialUpdates'.tr();
  String get systemUpdates => 'notifications.systemUpdates'.tr();
  String get emailNotifications => 'notifications.emailNotifications'.tr();
  String get pushNotifications => 'notifications.pushNotifications'.tr();
  String get morning => 'notifications.morning'.tr();
  String get afternoon => 'notifications.afternoon'.tr();
  String get evening => 'notifications.evening'.tr();
  String get night => 'notifications.night'.tr();
  String get custom => 'notifications.custom'.tr();
  String get frequency => 'notifications.frequency'.tr();
  String get daily => 'notifications.daily'.tr();
  String get weekly => 'notifications.weekly'.tr();
  String get never => 'notifications.never'.tr();
}

class _Errors {
  const _Errors();
  String get generic => 'errors.generic'.tr();
  String get network => 'errors.network'.tr();
  String get networkError => 'errors.networkError'.tr();
  String get server => 'errors.server'.tr();
  String get serverError => 'errors.serverError'.tr();
  String get notFound => 'errors.notFound'.tr();
  String get unauthorized => 'errors.unauthorized'.tr();
  String get forbidden => 'errors.forbidden'.tr();
  String get timeout => 'errors.timeout'.tr();
  String get noInternet => 'errors.noInternet'.tr();
  String get offlineMode => 'errors.offlineMode'.tr();
  String get unknownError => 'errors.unknownError'.tr();
  String get loginFailed => 'errors.loginFailed'.tr();
  String get invalidCredentials => 'errors.invalidCredentials'.tr();
  String get sessionExpired => 'errors.sessionExpired'.tr();
  String get cacheError => 'errors.cacheError'.tr();
  String get syncError => 'errors.syncError'.tr();
  String get uploadError => 'errors.uploadError'.tr();
  String get downloadError => 'errors.downloadError'.tr();
  String get fileNotFound => 'errors.fileNotFound'.tr();
  String get permissionDenied => 'errors.permissionDenied'.tr();
  String get storageError => 'errors.storageError'.tr();
}

class _Offline {
  const _Offline();
  String get title => 'offline.title'.tr();
  String get message => 'offline.message'.tr();
  String get cachedContent => 'offline.cachedContent'.tr();
  String get lastSync => 'offline.lastSync'.tr();
  String get syncNow => 'offline.syncNow'.tr();
  String get goOnline => 'offline.goOnline'.tr();
  String get offlineReading => 'offline.offlineReading'.tr();
  String get downloadForOffline => 'offline.downloadForOffline'.tr();
  String get removeFromOffline => 'offline.removeFromOffline'.tr();
  String get storageUsed => 'offline.storageUsed'.tr();
  String get freeSpace => 'offline.freeSpace'.tr();
}

// Note: easy_localization package will provide the .tr() extension
// This file provides structured access to localization keys
// Usage: LocaleKeys.home.welcome.tr() will return translated text