# Jedi's PieTTY Portable
PieTTY Portable 是另一個 Jedi 閒暇時亂弄的東西，目前沒有什麼做大的打算，也沒有什麼更新時程規劃，不過若有任何使用上的意見也都歡迎回饋，如果有什麼我也覺得應該要改進的地方，我也會抽空來處理，就這樣。
註：本專案目前已經完全停止更新，僅為了保存歷史而公開於此。

## 功能
- 可搭配任何版本的 [PieTTY](https://sites.google.com/view/pietty-project) 與 [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) 使用
- 支援 PieTTY 內建可攜式模式（對應 PieTTY 0.4.00 Beta 11 以上的版本）
- 支援多重連線，可選擇開新連線之熱鍵，最後一個連線關閉後才會整理登錄資訊
- 支援唯讀模式，放在 CD 等唯讀媒體上使用也沒問題
- 設定轉移：初次使用時，會詢問是否將現有的 PieTTY/PuTTY 登錄設定轉換成可攜式設定，原有設定也都會保留
- 設定可攜：所有的 PieTTY/PuTTY 設定都會跟著程式跑
- 設定備份：可以保留額外的設定備份（可以在系統列右鍵選單裡面設定備份數量上限）
- 清除痕跡：不會在 Windows 登錄當中留下任何使用殘骸
- 多語介面：繁中、簡中、英文，根據執行環境自動切換
- 手動檢查更新：隨時可透過網路檢查是否有新版的 PieTTY Portable
- 自動檢查更新：可設定成每七天自動檢查一次是否有新版的 PieTTY Portable

## 使用方法
- 下載 PieTTY Portable 後，解壓縮，將所有檔案與 [PieTTY](https://sites.google.com/view/pietty-project) 或 [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) 主程式放置在相同的路徑
- 日後都執行 `PieTTYPortable.exe`，不要直接執行 PieTTY 或 PuTTY 主程式
- 如果 PieTTY Portable 找不到你的 PieTTY 或 PuTTY 執行檔，就會詢問，並且自動更新 `piettyportable.ini` 內的設定值
- 在系統列圖示上按一下滑鼠左鍵就可以開出新的 PieTTY 視窗
- 在系統列圖示上按一下滑鼠右鍵則可以叫出選單（目前可以開新連線、指定額外保留的設定備份數量上限、指定搭配使用 PieTTY 0.4.00 Beta 11 以上版本所內建的「可攜式」功能、檢查是否有新版 PieTTY Portable 可以下載、查看「關於」資訊）
- 所有的 PieTTY 或 PuTTY 連線都關閉後，會自動整理登錄資訊，並關閉系統列圖示

## 變更沿革
### 2010-12-07 03:25
- 調整 `piettyportable.ini` 檔案預設值，對應 PieTTY 0.4.00 Beta 14
### 2010-11-14 00:44
- 修正無法正確啟用前次指定熱鍵的瑕疵
- 修正熱鍵僅能多開出一個新連線的瑕疵（受限於 AutoHotkey 的設計，最多祇能透過熱鍵開出 20 個新連線；直接按系統列圖示則無數量限制）
### 2010-11-04 04:05
- 加入可挑選開新連線之熱鍵的功能，目前可供挑選的熱鍵組合為：`Win-G`、`Win-H`、`Win-J`、`Win-N`、`Win-O`、`Win-Q`、`Win-T`、`Win-W`、`Win-X`、`Win-Y`、`Win-Z`，也可以關閉熱鍵。預設為關閉熱鍵不使用。
### 2010-09-27 01:10
- 調整 `piettyportable.ini` 檔案預設值，對應 PieTTY 0.4.00 Beta 13
### 2010-09-22 14:32
- 調整 `piettyportable.ini` 檔案預設值，對應 PieTTY 0.4.00 Beta 12
### 2010-09-20 10:16
- 修正在簡體中文環境下執行時不會以簡體中文介面呈現的瑕疵
### 2010-08-31 18:30
- 調整進入唯讀模式時該要有的組態設定
- 加入可自動定期檢查是否有新版 PieTTY Portable 的功能（每七天檢查一次）
- 改善與 PieTTY 0.4.00 Beta 11 以上版本內建的「可攜式模式」的整合度
- 修正與準備成唯讀模式有關的瑕疵
### 2010-08-31 13:57
- 加入選項，可與 PieTTY 0.4.00 Beta 11 以上版本內建的「可攜式模式」搭配得更好
- 加入檢查是否有新版的功能
### 2010-08-28 05:04
- 訊息微調
- 調整 `piettyportable.ini` 檔案預設值，對應 PieTTY 0.4.00 Beta 10
### 2010-08-22 04:56
- 支援唯讀模式：將 PieTTY Portable 燒錄到光碟或其他唯讀媒體上使用的情況
- 系統列圖示右鍵選單增加可切換成唯讀模式的選項（祇能切換成唯讀模式，不能回到普通模式；如果要回到普通模式，需要手動修改 `piettyportable.ini` 檔案，或直接把 `piettyportable.ini` 檔案刪除）
### 2010-08-22 01:52
- 修正前一版清理登錄時會遺留 `HKEY_CURRENT_USER\Software\SimonTatham` 這個鍵本身的瑕疵（前一版會把這個鍵底下所有的機碼跟子鍵都清掉，但是會遺漏這個鍵本身）
### 2010-08-21 23:53
- 修正前一版重複執行 `PieTTYPortable.exe` 會造成多個系統列圖示的瑕疵
- 修正前一版如果手動砍掉任何一個 PieTTY 執行緒（但還有其他 PieTTY 執行中）會造成 PieTTY Portable 提前結束的瑕疵
- 初次使用 PieTTY Portable 時，若發現有既有的設定，現在會詢問是否要沿用（前一版不會問，也不會判斷是否有既有的設定）
- 加入自動備份登錄設定檔的機制（預設是 3 個）
- 系統列右鍵選單加入可以選擇要有幾個備份的選單
- 計畫網頁加入變更沿革
### 2010-08-20 23:46
- 第一個公開版本

## 源碼用途說明
請注意：源碼內容都是 ANSI……
- `piettyportable.ahk`（主程式）
- `locale.ahk`（語系檔）
- `pietty.ico`（圖示檔）
- `piettyportable.ini`（預設設定檔）
- `build.ahk`（打包用腳本）
- `piettyportable.diz`（打包用註解檔）

## 致謝
PieTTY 超好用！請別忘了[贊助 piaip](https://www.csie.ntu.edu.tw/~piaip/donate/)
