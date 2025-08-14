#!/bin/bash
set -e

# Deployment script for Okumanya
echo "🚀 Starting deployment process..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PLATFORM=${1:-"both"}      # android, ios, both
TRACK=${2:-"internal"}     # internal, alpha, beta, production
ENVIRONMENT=${3:-"staging"} # staging, production

echo -e "${YELLOW}Deployment Configuration:${NC}"
echo "- Platform: $PLATFORM"
echo "- Track: $TRACK" 
echo "- Environment: $ENVIRONMENT"
echo ""

# Validate inputs
if [[ ! "$PLATFORM" =~ ^(android|ios|both)$ ]]; then
    echo -e "${RED}❌ Invalid platform: $PLATFORM${NC}"
    echo "Valid options: android, ios, both"
    exit 1
fi

if [[ ! "$TRACK" =~ ^(internal|alpha|beta|production)$ ]]; then
    echo -e "${RED}❌ Invalid track: $TRACK${NC}"
    echo "Valid options: internal, alpha, beta, production"
    exit 1
fi

if [[ ! "$ENVIRONMENT" =~ ^(staging|production)$ ]]; then
    echo -e "${RED}❌ Invalid environment: $ENVIRONMENT${NC}"
    echo "Valid options: staging, production"
    exit 1
fi

# Check dependencies
check_dependencies() {
    echo -e "${YELLOW}🔍 Checking dependencies...${NC}"
    
    # Check Flutter
    if ! command -v flutter &> /dev/null; then
        echo -e "${RED}❌ Flutter not found${NC}"
        exit 1
    fi
    
    # Check Fastlane (only if deploying)
    if [ "$TRACK" != "build-only" ]; then
        if ! command -v fastlane &> /dev/null; then
            echo -e "${RED}❌ Fastlane not found${NC}"
            echo "Install with: gem install fastlane"
            exit 1
        fi
    fi
    
    echo -e "${GREEN}✅ Dependencies check passed${NC}"
}

# Prepare environment
prepare_environment() {
    echo -e "${YELLOW}🛠️ Preparing environment...${NC}"
    
    # Load environment variables
    if [ -f ".env.$ENVIRONMENT" ]; then
        export $(cat .env.$ENVIRONMENT | xargs)
        echo -e "${GREEN}✅ Loaded .env.$ENVIRONMENT${NC}"
    elif [ -f ".env" ]; then
        export $(cat .env | xargs)
        echo -e "${GREEN}✅ Loaded .env${NC}"
    else
        echo -e "${YELLOW}⚠️ No environment file found${NC}"
    fi
    
    # Update version based on environment
    if [ "$ENVIRONMENT" = "production" ]; then
        echo -e "${BLUE}📦 Production build${NC}"
    else
        echo -e "${BLUE}📦 Staging build${NC}"
    fi
}

# Clean and prepare Flutter project
prepare_flutter() {
    echo -e "${YELLOW}🧹 Preparing Flutter project...${NC}"
    
    flutter clean
    flutter pub get
    dart run build_runner build --delete-conflicting-outputs
    
    echo -e "${GREEN}✅ Flutter project prepared${NC}"
}

# Run tests before deployment
run_tests() {
    echo -e "${YELLOW}🧪 Running tests...${NC}"
    
    if [ -f "scripts/run_tests.sh" ]; then
        ./scripts/run_tests.sh unit
        if [ $? -ne 0 ]; then
            echo -e "${RED}❌ Tests failed${NC}"
            exit 1
        fi
    else
        flutter test
    fi
    
    echo -e "${GREEN}✅ Tests passed${NC}"
}

# Deploy Android
deploy_android() {
    echo -e "${BLUE}🤖 Deploying Android...${NC}"
    
    cd android
    
    case $TRACK in
        "internal")
            fastlane deploy_internal
            ;;
        "alpha")
            fastlane deploy_alpha
            ;;
        "beta")
            fastlane deploy_beta
            ;;
        "production")
            if [ "$ENVIRONMENT" = "production" ]; then
                fastlane deploy_production
            else
                echo -e "${RED}❌ Production track only allowed in production environment${NC}"
                exit 1
            fi
            ;;
    esac
    
    cd ..
    echo -e "${GREEN}✅ Android deployment completed${NC}"
}

# Deploy iOS
deploy_ios() {
    echo -e "${BLUE}🍎 Deploying iOS...${NC}"
    
    # Check if on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo -e "${RED}❌ iOS deployment requires macOS${NC}"
        exit 1
    fi
    
    cd ios
    
    case $TRACK in
        "internal")
            fastlane deploy_testflight
            ;;
        "alpha")
            fastlane deploy_testflight
            ;;
        "beta")
            fastlane deploy_external_testflight
            ;;
        "production")
            if [ "$ENVIRONMENT" = "production" ]; then
                fastlane deploy_appstore
            else
                echo -e "${RED}❌ Production track only allowed in production environment${NC}"
                exit 1
            fi
            ;;
    esac
    
    cd ..
    echo -e "${GREEN}✅ iOS deployment completed${NC}"
}

# Post-deployment tasks
post_deployment() {
    echo -e "${YELLOW}📋 Running post-deployment tasks...${NC}"
    
    # Update version number for next build
    if [ "$TRACK" = "production" ]; then
        echo -e "${BLUE}📝 Consider updating version number for next release${NC}"
    fi
    
    # Send notifications (if configured)
    if [ ! -z "$SLACK_WEBHOOK_URL" ]; then
        curl -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"🚀 Okumanya deployed successfully!\n- Platform: $PLATFORM\n- Track: $TRACK\n- Environment: $ENVIRONMENT\"}" \
            $SLACK_WEBHOOK_URL
        echo -e "${GREEN}✅ Slack notification sent${NC}"
    fi
    
    # Generate deployment report
    DEPLOYMENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
    echo "Deployment Report" > deployment-report.txt
    echo "=================" >> deployment-report.txt
    echo "Time: $DEPLOYMENT_TIME" >> deployment-report.txt
    echo "Platform: $PLATFORM" >> deployment-report.txt
    echo "Track: $TRACK" >> deployment-report.txt
    echo "Environment: $ENVIRONMENT" >> deployment-report.txt
    echo "Status: SUCCESS" >> deployment-report.txt
    
    echo -e "${GREEN}✅ Post-deployment tasks completed${NC}"
}

# Error handling
handle_error() {
    echo -e "${RED}❌ Deployment failed${NC}"
    
    # Send error notification
    if [ ! -z "$SLACK_WEBHOOK_URL" ]; then
        curl -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"❌ Okumanya deployment FAILED!\n- Platform: $PLATFORM\n- Track: $TRACK\n- Environment: $ENVIRONMENT\"}" \
            $SLACK_WEBHOOK_URL
    fi
    
    # Generate error report
    DEPLOYMENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')
    echo "Deployment Report" > deployment-report.txt
    echo "=================" >> deployment-report.txt
    echo "Time: $DEPLOYMENT_TIME" >> deployment-report.txt
    echo "Platform: $PLATFORM" >> deployment-report.txt
    echo "Track: $TRACK" >> deployment-report.txt
    echo "Environment: $ENVIRONMENT" >> deployment-report.txt
    echo "Status: FAILED" >> deployment-report.txt
    
    exit 1
}

# Set up error handling
trap handle_error ERR

# Main deployment flow
main() {
    echo -e "${GREEN}🎯 Starting Okumanya deployment${NC}"
    
    check_dependencies
    prepare_environment
    prepare_flutter
    
    # Run tests (skip in emergency deployments)
    if [ "${SKIP_TESTS:-false}" != "true" ]; then
        run_tests
    fi
    
    # Deploy based on platform
    case $PLATFORM in
        "android")
            deploy_android
            ;;
        "ios")
            deploy_ios
            ;;
        "both")
            deploy_android
            deploy_ios
            ;;
    esac
    
    post_deployment
    
    echo ""
    echo -e "${GREEN}🎉 Deployment completed successfully!${NC}"
    echo -e "${BLUE}📊 Summary:${NC}"
    echo "- Platform: $PLATFORM"
    echo "- Track: $TRACK"
    echo "- Environment: $ENVIRONMENT"
    echo "- Time: $(date '+%Y-%m-%d %H:%M:%S')"
}

# Show help
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Okumanya Deployment Script"
    echo "=========================="
    echo ""
    echo "Usage: ./deploy.sh [platform] [track] [environment]"
    echo ""
    echo "Parameters:"
    echo "  platform    - android, ios, or both (default: both)"
    echo "  track       - internal, alpha, beta, or production (default: internal)"
    echo "  environment - staging or production (default: staging)"
    echo ""
    echo "Examples:"
    echo "  ./deploy.sh android internal staging"
    echo "  ./deploy.sh both beta production"
    echo "  ./deploy.sh ios production production"
    echo ""
    echo "Environment Variables:"
    echo "  SKIP_TESTS          - Set to 'true' to skip running tests"
    echo "  SLACK_WEBHOOK_URL   - Slack webhook for notifications"
    echo ""
    exit 0
fi

# Run main function
main