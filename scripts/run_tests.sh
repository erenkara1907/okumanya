#!/bin/bash
set -e

# Comprehensive test runner for Okumanya
echo "🧪 Running comprehensive test suite..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
TEST_TYPE=${1:-"all"}  # unit, widget, integration, all
COVERAGE=${2:-"true"}   # true, false

echo -e "${YELLOW}Test Configuration:${NC}"
echo "- Test Type: $TEST_TYPE"
echo "- Coverage: $COVERAGE"
echo ""

# Clean and prepare
echo -e "${YELLOW}🧹 Preparing test environment...${NC}"
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# Create coverage directory
mkdir -p coverage

# Run different test types
run_unit_tests() {
    echo -e "${BLUE}🔬 Running unit tests...${NC}"
    if [ "$COVERAGE" = "true" ]; then
        flutter test test/unit/ --coverage --test-randomize-ordering-seed random
    else
        flutter test test/unit/ --test-randomize-ordering-seed random
    fi
}

run_widget_tests() {
    echo -e "${BLUE}📱 Running widget tests...${NC}"
    if [ "$COVERAGE" = "true" ]; then
        flutter test test/widget/ --coverage --test-randomize-ordering-seed random
    else
        flutter test test/widget/ --test-randomize-ordering-seed random
    fi
}

run_integration_tests() {
    echo -e "${BLUE}🔗 Running integration tests...${NC}"
    flutter test integration_test/
}

run_golden_tests() {
    echo -e "${BLUE}🎨 Running golden tests...${NC}"
    if [ "$COVERAGE" = "true" ]; then
        flutter test test/golden/ --coverage --update-goldens
    else
        flutter test test/golden/ --update-goldens
    fi
}

# Execute based on test type
case $TEST_TYPE in
    "unit")
        run_unit_tests
        ;;
    "widget")
        run_widget_tests
        ;;
    "integration")
        run_integration_tests
        ;;
    "golden")
        run_golden_tests
        ;;
    "all")
        echo -e "${YELLOW}🚀 Running all test types...${NC}"
        
        # Run tests in order
        if run_unit_tests; then
            echo -e "${GREEN}✅ Unit tests passed${NC}"
        else
            echo -e "${RED}❌ Unit tests failed${NC}"
            exit 1
        fi
        
        if run_widget_tests; then
            echo -e "${GREEN}✅ Widget tests passed${NC}"
        else
            echo -e "${RED}❌ Widget tests failed${NC}"
            exit 1
        fi
        
        if run_golden_tests; then
            echo -e "${GREEN}✅ Golden tests passed${NC}"
        else
            echo -e "${RED}❌ Golden tests failed${NC}"
            exit 1
        fi
        
        if run_integration_tests; then
            echo -e "${GREEN}✅ Integration tests passed${NC}"
        else
            echo -e "${RED}❌ Integration tests failed${NC}"
            exit 1
        fi
        ;;
    *)
        echo -e "${RED}❌ Invalid test type: $TEST_TYPE${NC}"
        echo "Valid options: unit, widget, integration, golden, all"
        exit 1
        ;;
esac

# Generate coverage report if enabled
if [ "$COVERAGE" = "true" ] && [ -f "coverage/lcov.info" ]; then
    echo -e "${YELLOW}📊 Generating coverage report...${NC}"
    
    # Install lcov if not present (on macOS)
    if ! command -v lcov &> /dev/null; then
        echo -e "${YELLOW}Installing lcov...${NC}"
        if command -v brew &> /dev/null; then
            brew install lcov
        else
            echo -e "${YELLOW}Please install lcov to generate HTML coverage report${NC}"
        fi
    fi
    
    # Generate HTML coverage report
    if command -v lcov &> /dev/null; then
        genhtml coverage/lcov.info -o coverage/html
        echo -e "${GREEN}📈 Coverage report generated: coverage/html/index.html${NC}"
    fi
    
    # Extract coverage percentage
    if command -v lcov &> /dev/null; then
        COVERAGE_PERCENT=$(lcov --summary coverage/lcov.info 2>&1 | grep -o 'lines......: [0-9.]*%' | grep -o '[0-9.]*')
        echo -e "${BLUE}📊 Overall coverage: ${COVERAGE_PERCENT}%${NC}"
        
        # Check coverage threshold
        THRESHOLD=80
        if (( $(echo "$COVERAGE_PERCENT >= $THRESHOLD" | bc -l) )); then
            echo -e "${GREEN}✅ Coverage meets threshold (>=$THRESHOLD%)${NC}"
        else
            echo -e "${YELLOW}⚠️  Coverage below threshold ($THRESHOLD%): $COVERAGE_PERCENT%${NC}"
        fi
    fi
fi

# Test performance analysis
echo -e "${YELLOW}🏃‍♂️ Analyzing test performance...${NC}"
TEST_END_TIME=$(date +%s)
TEST_START_TIME=${TEST_START_TIME:-$TEST_END_TIME}
TEST_DURATION=$((TEST_END_TIME - TEST_START_TIME))

if [ $TEST_DURATION -gt 300 ]; then
    echo -e "${YELLOW}⏱️  Tests took ${TEST_DURATION}s (consider optimizing)${NC}"
else
    echo -e "${GREEN}⚡ Tests completed in ${TEST_DURATION}s${NC}"
fi

# Memory usage check (if on macOS/Linux)
if command -v ps &> /dev/null; then
    MEMORY_USAGE=$(ps -o pid,vsz,rss,comm | grep flutter | awk '{sum+=$3} END {print sum}')
    if [ ! -z "$MEMORY_USAGE" ]; then
        MEMORY_MB=$((MEMORY_USAGE / 1024))
        echo -e "${BLUE}🧠 Peak memory usage: ${MEMORY_MB}MB${NC}"
    fi
fi

echo ""
echo -e "${GREEN}🎉 Test suite completed successfully!${NC}"

# Summary
echo -e "${BLUE}📋 Test Summary:${NC}"
echo "- Test Type: $TEST_TYPE"
echo "- Coverage Enabled: $COVERAGE"
echo "- Duration: ${TEST_DURATION}s"
if [ "$COVERAGE" = "true" ] && [ ! -z "$COVERAGE_PERCENT" ]; then
    echo "- Coverage: $COVERAGE_PERCENT%"
fi