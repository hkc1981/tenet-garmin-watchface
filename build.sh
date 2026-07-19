#!/bin/bash

# 偵測 Garmin Connect IQ SDK 路徑
CFG_FILE="$HOME/Library/Application Support/Garmin/ConnectIQ/current-sdk.cfg"
if [ -f "$CFG_FILE" ]; then
    SDK_PATH=$(cat "$CFG_FILE" | tr -d '\r\n')
    echo "偵測到 SDK 路徑: $SDK_PATH"
else
    echo "未偵測到 current-sdk.cfg，嘗試使用預設路徑..."
    SDK_PATH="$HOME/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-9.2.0-2026-06-09-92a1605b2"
fi

if [ ! -d "$SDK_PATH" ]; then
    echo "錯誤: 找不到 Garmin SDK，請確認已使用 SDK Manager 下載 SDK。"
    exit 1
fi

MONKEYC="$SDK_PATH/bin/monkeyc"
CONNECTIQ="$SDK_PATH/bin/connectiq"
MONKEYDO="$SDK_PATH/bin/monkeydo"

# 預設編譯裝置
DEVICE=${1:-"fenix7"}
OUTPUT_DIR="bin"
OUTPUT_PRG="$OUTPUT_DIR/tenet-watchface.prg"
KEY_FILE="developer_key.der"

# 建立輸出目錄
mkdir -p "$OUTPUT_DIR"

if [ ! -f "$KEY_FILE" ]; then
    echo "找不到開發者金鑰 ($KEY_FILE)，正在產生..."
    openssl genrsa -out developer_key.pem 4096
    openssl pkcs8 -topk8 -inform PEM -outform DER -in developer_key.pem -out developer_key.der -nocrypt
fi

echo "開始編譯專案，目標裝置: $DEVICE ..."
"$MONKEYC" -O 2 -f monkey.jungle -d "$DEVICE" -o "$OUTPUT_PRG" -y "$KEY_FILE"

if [ $? -eq 0 ]; then
    echo "編譯成功: $OUTPUT_PRG"
    
    # 啟動模擬器
    echo "啟動 Connect IQ 模擬器..."
    "$CONNECTIQ" &
    
    # 等待模擬器啟動 (約 2 秒)
    sleep 2
    
    echo "在模擬器中執行應用程式..."
    "$MONKEYDO" "$OUTPUT_PRG" "$DEVICE"
else
    echo "編譯失敗！"
    exit 1
fi
