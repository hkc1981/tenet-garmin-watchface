# Tenet WatchFace - Garmin 錶面開發專案

這是一個使用 Garmin Connect IQ SDK 建立的錶面 (watchface) 開發專案。

## 專案結構
```
.
├── README.md               # 本說明文件
├── build.sh                # 一鍵編譯與模擬器執行腳本 (macOS)
├── developer_key.pem       # 開發者金鑰 (PEM 格式)
├── developer_key.der       # 開發者金鑰 (DER 格式，編譯專案必備)
├── manifest.xml            # 應用程式屬性與支援裝置設定
├── monkey.jungle           # 編譯路徑與資源設定
├── source/
│   ├── App.mc              # 應用程式進入點與生命週期管理
│   └── View.mc             # 錶面畫面繪製邏輯
└── resources/
    ├── drawables/
    │   ├── drawables.xml   # 圖形資源定義
    │   └── launcher_icon.svg # 應用程式啟動圖示
    ├── layouts/
    │   └── layout.xml      # 版面配置定義
    └── strings/
        └── strings.xml     # 字串資源定義
```

## 開發指引

### 1. 使用 VS Code 開發 (推薦)
1. 安裝 VS Code 的 **Monkey C** 官方擴充套件。
2. 在 VS Code 設定中，搜尋 `monkeyc.developerKey`，將其指向此專案目錄底下的 `developer_key.der` 的絕對路徑。
3. 執行 **Monkey C: Build Project** 進行編譯，或執行 **Monkey C: Run App** 啟動模擬器進行測試。

### 2. 使用命令列開發 (CLI)
我們為您準備了 `build.sh` 輔助指令，可以一鍵完成編譯、啟動模擬器並載入執行。

#### 執行編譯與模擬器 (預設裝置為 fenix7)
```bash
./build.sh
```

#### 指定特定裝置編譯並執行
若想更換測試手錶裝置（如 `fr965` 或 `venu3`）：
```bash
./build.sh fr965
```

## 常見問題與自訂設定
*   **如何新增支援的手錶裝置？**
    *   編輯 `manifest.xml`，在 `<iq:products>` 區段中加入對應的產品 ID（例如 `<iq:product id="fr955"/>`）。
    *   請確保您已使用 **Garmin SDK Manager** 下載了該裝置的 SDK 支援檔。
*   **如何修改畫面上顯示的時間位置與樣式？**
    *   版面配置可修改 `resources/layouts/layout.xml` 中的 `label` 元素。
    *   繪圖邏輯與時間格式更新可以修改 `source/View.mc` 中的 `onUpdate` 函式。
