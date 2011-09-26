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

    end
  end

end
