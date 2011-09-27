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

    end
  end

end
