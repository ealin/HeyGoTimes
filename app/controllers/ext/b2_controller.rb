class Ext::B2Controller < ApplicationController

  def index

    if params[:ch] == nil
      @chapter = 'main'
    else
      @chapter = params[:ch]
    end

    case @chapter
      when 'main'
        @title = "大黑狗之現代嵌入式系統開發專案實務 - 封面"
      when 'list'
        @title = "大黑狗之現代嵌入式系統開發專案實務 - 章節列表"
      when 'intro100'
        @title = "Web無料版 發佈序言"
      when 'intro'
        @title = "大黑狗之現代嵌入式系統開發專案實務 - 序＆章節簡介"
      when 'fpage'
        @title = "大黑狗之現代嵌入式系統開發專案實務 - 封面文字"
      when 'CH00_01'
        @title = "00.01. 系統．嵌入．硬體-welcome on board!"
      when 'CH00_02'
        @title = "00.02. 嵌入式系統開發團隊"
      when 'CH00_03'
        @title = "00.03. 老調重彈-什麼是嵌入式系統?"
      when 'CH00_04'
        @title = "00.04. 限制、限制、限制"
      when 'CH00_05'
        @title = "00.0.5 基本職能–老鳥也曾是菜鳥"
      when 'CH00_06'
        @title = "00.06. 讀書計畫"
      when 'CH00_07'
        @title = "00.07. 工作內容-做工程師，而非程式工人"

      when 'CH01_01'
        @title = "01.01. 嵌入式系統專案 – 簡介"
      when 'CH01_02'
        @title = "01.02. 初期規劃-該不該接這個案子？"
      when 'CH01_03'
        @title = "01.03. 時程規劃—ASAP？"
      when 'CH01_04'
        @title = "01.04. 規格-請接受這個不完美的世界"
      when 'CH01_05'
        @title = "01.05. 人力規劃 - 營級組織，連級人力"
      when 'CH01_06'
        @title = "01.06. 一切都為了Cost Down"

      when 'CH02_01'
        @title = "02.01. 設計階段-擬定作戰計畫"
      when 'CH02_02'
        @title = "02.02. 產品規格設計"
      when 'CH02_03'
        @title = "02.03. 硬體設計"
      when 'CH02_04'
        @title = "02.04. 系統設計"
      when 'CH02_05'
        @title = "02.05. 測試計畫設計"
      when 'CH02_06'
        @title = "02.06. 測試計畫設計"
      when 'CH02_07'
        @title = "02.07. 風險評估"
      when 'CH02_08'
        @title = "02.08. 設計文件的重要性"
      when 'CH02_09'
        @title = "02.09. 實作階段-執行所有設計"
      when 'CH02_10'
        @title = "02.10. 衝突不斷-協同作戰有多難?"
      when 'CH02_11'
        @title = "02.11. 產品化"
      when 'CH02_12'
        @title = "02.12. 無間道-專案可有close的一天?"

      when 'CH03_01'
        @title = "03.01. 開發環境"
      when 'CH03_02'
        @title = "03.02. 無痛起步 - 善用sample code"
      when 'CH03_03'
        @title = "03.03. 如何確定程式在執行?"
      when 'CH03_04'
        @title = "03.04. 標準C Library可以用嗎?"

      when 'CH04_01'
        @title = "04.01. 系統與平台"
      when 'CH04_02'
        @title = "04.02. 系統架構設計"
      when 'CH04_03'
        @title = "04.03. API與程式風格設計"
      when 'CH04_04'
        @title = "04.04. 嵌入式作業系統-OS在哪裡?"
      when 'CH04_05'
        @title = "04.05. 模擬器"
      when 'CH04_06'
        @title = "04.06. Source Tree設計"
      when 'CH04_07'
        @title = "04.07. 程式風格典範"


      when 'CH05_01'
        @title = "05.01. 開發工具"
      when 'CH05_02'
        @title = "05.02. Makefile / 批次檔(.BAT)"
      when 'CH05_03'
        @title = "05.03. Link Script"
      when 'CH05_04'
        @title = "05.04. ROM Maker"
      when 'CH05_05'
        @title = "05.05. 下載 / 執行"
      when 'CH05_06'
        @title = "05.06. 版本控制Server"
      when 'CH05_07'
        @title = "05.07. 說故事時間"


      when 'CH06_01'
        @title = "06.01. 上電之後-Boot Loader"
      when 'CH06_02'
        @title = "06.02. 基本硬體測試"
      when 'CH06_03'
        @title = "06.03. 載入程式段與資料段初始化"
      when 'CH06_04'
        @title = "06.04. 實例：從NAND Flash載入"


      when 'CH07_01'
        @title = "07.01. 莫恐懼！"
      when 'CH07_02'
        @title = "07.02. 準備工作"
      when 'CH07_03'
        @title = "07.03. 控制CPU"
      when 'CH07_04'
        @title = "07.04. Memory"
      when 'CH07_05'
        @title = "07.05. 控制其他晶片"
      when 'CH07_06'
        @title = "07.06. ISR寫作注意事項"
      when 'CH07_07'
        @title = "07.07. 驅動程式除錯"


      when 'CH08_01'
        @title = "08.01. 記憶體空間配置"
      when 'CH08_02'
        @title = "08.02. Stack"
      when 'CH08_03'
        @title = "08.03. Heap-動態記憶體配置"
      when 'CH08_04'
        @title = "08.04. 燒錄器"


      when 'CH09_01'
        @title = "09.01. 模擬器概論"
      when 'CH09_02'
        @title = "09.02. Emulator vs. Simulator"
      when 'CH09_03'
        @title = "09.03. 模擬器對專案開發的貢獻"
      when 'CH09_04'
        @title = "09.04. 實戰篇"


      when 'CH10_01'
        @title = "10.01. 系統整合"
      when 'CH10_02'
        @title = "10.02. 全功能整合"
      when 'CH10_03'
        @title = "10.03. 發行第一個版本"


      when 'CH11_01'
        @title = "11.01. 測試"
      when 'CH11_02'
        @title = "11.02. Bug Sheet管理"
      when 'CH11_03'
        @title = "11.03. Debug基本技法"
      when 'CH11_04'
        @title = "11.04. Tuning"


      when 'CH12_01'
        @title = "12.01. 版本發行-兵荒馬亂的日子"
      when 'CH12_02'
        @title = "12.02. 自動測試程式"
      when 'CH12_03'
        @title = "12.03. 決定量產版本"
      when 'CH12_04'
        @title = "12.04. 出貨≠結案"
      when 'CH12_05'
        @title = "12.05. 專案結案"


      when 'CH13_A'
        @title = "附錄A: 沒有執行專案管理的專案"
      when 'CH13_B'
        @title = "附錄B: Callback Function"
      when 'CH13_C'
        @title = "附錄C: 用C來實作物件導向的概念"
      when 'CH13_D'
        @title = "附錄D: 有效率的畫斜線演算法"
      when 'CH13_E'
        @title = "附錄E: 電子產品設計導論"


    end
  end

end
