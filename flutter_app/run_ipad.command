#!/bin/bash

# [중요] Finder에서 실행 시 flutter 경로를 못 찾을 수 있으므로 환경변수 로드
# zsh 사용 중이면 ~/.zshrc, bash 사용 중이면 ~/.bash_profile
source ~/.zshrc 2>/dev/null || source ~/.bash_profile 2>/dev/null

# --- 설정 변수 ---
DEVICE_NAME="iPad Air 13-inch (M3)"
PROJECT_PATH="/Users/sunguk/0.code/기억의궁전(github)/flutter_app"

echo "🔍 시뮬레이터 상태 확인 중: $DEVICE_NAME"

# 1. 기기 상태 확인 및 부팅 로직
if xcrun simctl list devices | grep "$DEVICE_NAME" | grep -q "(Booted)"; then
    echo "✅ 이미 실행 중입니다. 부팅 과정을 건너뜁니다."
else
    echo "⚙️  실행 중이 아닙니다. 시뮬레이터를 정리하고 부팅합니다."
    xcrun simctl shutdown all
    xcrun simctl boot "$DEVICE_NAME"
    open -a Simulator
    sleep 2
fi

# 2. Flutter 앱 실행
echo "🚀 Flutter 앱을 빌드하고 실행합니다..."
cd "$PROJECT_PATH" || exit  # 폴더 이동 실패시 종료하도록 안전장치 추가
flutter run -d "$DEVICE_NAME"