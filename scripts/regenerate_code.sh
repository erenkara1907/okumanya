#!/bin/bash

# 🏗️ Code Regeneration Script
# This script regenerates all auto-generated code files

echo "🧹 Cleaning build cache..."
flutter clean

echo "📦 Getting dependencies..."
flutter pub get

echo "🏗️ Generating code..."
echo "  • Auto Route generation..."
echo "  • Freezed models..."
echo "  • Injectable DI..."
echo "  • JSON serialization..."
echo "  • Mock classes for tests..."

dart run build_runner build --delete-conflicting-outputs

echo "✅ Code generation complete!"
echo ""
echo "📝 Generated files:"
echo "  • *.g.dart - JSON serialization"
echo "  • *.freezed.dart - Immutable classes"
echo "  • *.config.dart - Dependency injection"
echo "  • *.gr.dart - Routes"
echo "  • *.mocks.dart - Test mocks"
echo ""
echo "🎯 Ready for development!"