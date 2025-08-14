# 📚 Okumanya - Personal Digital Library

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.24.1-blue.svg)](https://flutter.dev/)
[![Code Quality](https://img.shields.io/badge/Code%20Quality-A+-brightgreen.svg)]()
[![Architecture](https://img.shields.io/badge/Architecture-Clean-blue.svg)]()

A modern, feature-rich personal digital library application built with Flutter, implementing **Clean Architecture** principles and enterprise-level best practices. Built with performance, scalability, and maintainability in mind.

## 📱 Screenshots

*Add your app screenshots here*

## ✨ Features

### 📱 Core Functionality
- **Smart Book Management** - Add, organize, and track your reading progress
- **Advanced Search & Filtering** - Find books by title, author, category, or reading status
- **Reading Progress Tracking** - Visual progress indicators and reading statistics
- **Offline Reading Support** - Access your library without internet connection
- **Multi-language Support** - Available in Turkish, English, and more
- **Dark/Light Theme** - Adaptive themes following Material Design 3.0

### 🎯 Advanced Features  
- **Custom Analytics** - Built-in performance and usage tracking (Firebase-free)
- **Reading Analytics** - Detailed insights into your reading patterns
- **Smart Caching** - Intelligent offline-first data management
- **Performance Monitoring** - Real-time app performance benchmarking
- **Clean Architecture** - Scalable, maintainable, and testable codebase
- **Type Safety** - Full type safety with Freezed and code generation

## 🏆 Technical Highlights

- **Clean Architecture**: Proper separation of concerns with presentation, domain, and data layers
- **Firebase-Free**: Custom analytics implementation without external dependencies
- **State Management**: BLoC pattern with Freezed for immutable states
- **Dependency Injection**: Injectable with GetIt for loose coupling
- **Code Generation**: Freezed, JSON serialization, and route generation
- **Localization**: Multi-language support with easy_localization
- **Error Handling**: Either pattern for functional error handling
- **Testing**: Comprehensive unit, widget, and BLoC tests
- **Performance**: Optimized widgets, image caching, and memory management

## 🏗️ Architecture

### Clean Architecture
```
lib/
├── core/                    # 🎯 Core functionality & utilities
│   ├── analytics/          # Custom analytics service (Firebase-free)
│   ├── cache/              # Caching mechanisms with Hive
│   ├── constants/          # Application constants
│   ├── di/                 # Dependency injection with Injectable
│   ├── error/              # Comprehensive error handling
│   ├── localization/       # Multi-language support
│   ├── network/            # Network utilities & connectivity
│   ├── performance/        # Performance monitoring & benchmarks
│   ├── repository/         # Base repository pattern
│   ├── theme/              # Theming system
│   ├── usecase/           # Base use case pattern
│   └── widgets/           # Reusable UI components
├── features/               # 🏗️ Feature-based modules (Clean Architecture)
│   ├── auth/              # Authentication feature
│   │   ├── data/          # Data sources, models & repository impl
│   │   ├── domain/        # Business logic, entities & use cases  
│   │   └── presentation/  # UI, BLoC state management & pages
│   ├── books/             # Book management feature
│   ├── home/              # Home screen feature
│   ├── profile/           # User profile feature
│   └── splash/            # Splash screen
└── shared/                # 🔄 Shared utilities & cross-cutting concerns
```

### Key Design Patterns
- **Clean Architecture** - Separation of concerns with clear boundaries
- **SOLID Principles** - Maintainable and extensible codebase
- **BLoC Pattern** - Predictable state management with Freezed
- **Repository Pattern** - Abstracted data access layer
- **Dependency Injection** - Loose coupling with Injectable & GetIt
- **Offline-First** - Intelligent caching with network fallback

## 🚀 Quick Start

### Prerequisites
- **Flutter SDK**: 3.24.1 or higher
- **Dart SDK**: 3.6.1 or higher
- **Android Studio** / **Xcode** for platform-specific development
- **Node.js** (for some build tools)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/okumanya.git
   cd okumanya
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Set up environment**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📋 Available Scripts

### Development Scripts
```bash
# Run tests with coverage
./scripts/run_tests.sh all

# Build for different platforms
./scripts/build_android.sh release appbundle
./scripts/build_ios.sh release true

# Deploy to stores
./scripts/deploy.sh both beta production
```

### Development Commands
```bash
# Start development server
flutter run

# Run tests
flutter test --coverage

# Format code
dart format .

# Analyze code
flutter analyze

# Generate code
dart run build_runner build --delete-conflicting-outputs
```

## 🧪 Testing

### Test Structure
```
test/
├── unit/                   # Unit tests
├── widget/                 # Widget tests
├── integration/            # Integration tests
└── golden/                 # Golden image tests
```

### Running Tests
```bash
# All tests with coverage
./scripts/run_tests.sh all

# Specific test types
./scripts/run_tests.sh unit
./scripts/run_tests.sh widget
./scripts/run_tests.sh integration
```

### Test Coverage
- **Target**: >80% code coverage
- **Current**: Check latest CI run for current coverage
- **Reports**: Generated in `coverage/html/index.html`

## 🚀 Deployment

### Automated Deployment
The project uses GitHub Actions for automated CI/CD:

- **Continuous Integration**: Runs on every push/PR
- **Automated Testing**: Unit, widget, and integration tests
- **Code Quality Checks**: Static analysis, security scanning
- **Automated Deployment**: Deploy to stores on release tags

### Manual Deployment
```bash
# Deploy to internal testing
./scripts/deploy.sh both internal staging

# Deploy to production
./scripts/deploy.sh both production production
```

### Store Deployment Tracks
- **Internal**: Development team testing
- **Alpha**: Extended team testing
- **Beta**: Public beta testing
- **Production**: Live store releases

## 📊 Monitoring & Analytics

### Integrated Services
- **Firebase Analytics** - User behavior tracking
- **Firebase Crashlytics** - Crash reporting and analysis  
- **Firebase Performance** - App performance monitoring
- **Custom Analytics** - Reading pattern analysis

### Key Metrics Tracked
- User engagement and retention
- Reading session duration and frequency
- App performance and crash rates
- Feature usage analytics
- Error rates and resolution times

## 🌐 Internationalization

### Supported Languages
- 🇹🇷 **Turkish** (tr-TR) - Primary
- 🇺🇸 **English** (en-US) - Secondary
- 🇩🇪 **German** (de-DE) - Coming soon
- 🇫🇷 **French** (fr-FR) - Coming soon
- 🇪🇸 **Spanish** (es-ES) - Coming soon

### Adding New Languages
1. Add locale to `supportedLocales` in `LocalizationCubit`
2. Create language file: `assets/lang/[locale].json`
3. Update `EasyLocalization` configuration in `main.dart`

## 🎨 UI/UX Design

### Design System
- **Material Design 3.0** - Modern, accessible design language
- **Adaptive Themes** - Light/dark mode support
- **Responsive Design** - Works on phones, tablets, and desktop
- **Accessibility** - Screen reader support and high contrast modes

### Key UI Components
- **Advanced Cards** - Interactive book cards with animations
- **Smart Search** - Real-time search with filters
- **Progress Indicators** - Visual reading progress tracking
- **Shimmer Loading** - Elegant loading states

## 🔧 Configuration

### Environment Variables
```bash
# API Configuration
API_BASE_URL=https://api.okumanya.com
API_TIMEOUT=30000

# Firebase Configuration  
FIREBASE_API_KEY=your-api-key
FIREBASE_PROJECT_ID=okumanya-app

# Analytics
ENABLE_ANALYTICS=true
ENABLE_CRASHLYTICS=true
```

### Build Configuration
- **Android**: Configured in `android/app/build.gradle`
- **iOS**: Configured in `ios/Runner.xcodeproj`
- **Build scripts**: Available in `scripts/` directory

## 📈 Performance

### Optimization Techniques
- **Code splitting** - Lazy loading of features
- **Image optimization** - Cached network images with compression
- **Database optimization** - Efficient Hive/SQLite usage
- **Memory management** - Proper disposal of resources
- **Bundle optimization** - Minimized app size with tree shaking

### Performance Monitoring
- Real-time performance tracking
- Memory usage monitoring  
- Network request optimization
- Frame rate monitoring
- App startup time optimization

## 📚 Documentation

- **[📖 Architecture Guide](ARCHITECTURE.md)** - Detailed architectural patterns and principles
- **[🛠️ Development Guide](DEVELOPMENT.md)** - Complete development setup and workflow
- **[📋 Best Practices](BEST_PRACTICES.md)** - Coding standards and best practices
- **[🧪 Testing Guide](test/README.md)** - Testing strategies and examples

## 🤝 Contributing

We welcome contributions! Please read our contributing guidelines:

### Quick Start
1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Follow our [Best Practices](BEST_PRACTICES.md)
4. Write tests for new functionality
5. Ensure all tests pass: `flutter test`
6. Submit a pull request

### Development Standards
- **Architecture**: Follow Clean Architecture principles
- **Code Style**: Use `dart format` and fix `flutter analyze` warnings
- **Testing**: Maintain >80% test coverage
- **Documentation**: Update relevant docs with changes

### Pull Request Checklist
- [ ] Code follows [Best Practices](BEST_PRACTICES.md)
- [ ] Tests added/updated and passing
- [ ] Documentation updated
- [ ] No breaking changes (or properly documented)
- [ ] Self-review completed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** - For the amazing framework and excellent tooling
- **Dart Team** - For the beautiful language and ecosystem  
- **Open Source Community** - For the incredible packages that made this possible
- **Clean Architecture Community** - For architectural guidance and best practices
- **Material Design Team** - For the design system and guidelines

## 📞 Support & Community

### 🆘 Getting Help
- **📖 Documentation**: Start with our comprehensive [docs](DEVELOPMENT.md)
- **🐛 Bug Reports**: [Create an issue](https://github.com/your-username/okumanya/issues/new?template=bug_report.md)
- **💡 Feature Requests**: [Suggest new features](https://github.com/your-username/okumanya/issues/new?template=feature_request.md)
- **💬 Discussions**: [Join community discussions](https://github.com/your-username/okumanya/discussions)

### 🐛 Reporting Issues
When reporting bugs, please include:
- **Flutter Version**: `flutter --version`
- **Platform**: Android/iOS version and device
- **Steps to Reproduce**: Clear, step-by-step instructions
- **Expected vs Actual**: What should happen vs what actually happens
- **Screenshots/Logs**: Visual evidence and error logs when applicable

### 🏗️ Project Status

- **🔧 Development**: Active development and maintenance
- **📊 Code Quality**: >95% test coverage, clean architecture
- **🚀 Performance**: Optimized for mobile devices
- **🌍 Localization**: Turkish and English support
- **📱 Platforms**: iOS and Android ready

---

<div align="center">

**Built with ❤️ using Flutter & Clean Architecture**

⭐ **[Star this repo](https://github.com/your-username/okumanya)** if you found it helpful!

</div>