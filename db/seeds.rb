# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#~~~~~~~~~~~~~~~~~~~~~~~~~Create Default User~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
User.create(:first_name => 'Reporter', :last_name => 'TW',:email => 'reporter.tw@heygotimes.com',
    :locale => 'zh_TW', :birthday => '2011-05-01 09:00:00',  :host_id => 0,  :host_site => 0)

User.create(:first_name => 'HGTimes', :last_name => 'Taiwan',:email => 'heygoinc@gmail.com',
    :locale => 'zh_TW', :birthday => '2011-07-01 09:00:00',  :host_id => 0,  :host_site => 0)
#
#  :host_site = 0  means this account is belongs to HeyGoTimes


#~~~~~~~~~~~~~~~~~~~~~~~~~Create Default Area~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

Area.create(:name => 'All_area', :parent_area =>nil)
Area.create(:name => 'Taiwan', :parent_area =>nil)
Area.create(:name => 'TW_CN', :parent_area => 'Taiwan')
Area.create(:name => 'North_TW', :parent_area => 'Taiwan')
Area.create(:name => 'Middle_TW', :parent_area => 'Taiwan')
Area.create(:name => 'South_TW', :parent_area => 'Taiwan')
Area.create(:name => 'East_TW', :parent_area => 'Taiwan')

Area.create(:name => 'China', :parent_area => nil)
Area.create(:name => 'TW_HK', :parent_area => "China")

Area.create(:name => 'USA', :parent_area => nil)
Area.create(:name => 'Japan', :parent_area => nil)
Area.create(:name => 'Europe', :parent_area => nil)
Area.create(:name => 'Asia', :parent_area => nil)
Area.create(:name => 'Others', :parent_area => nil)


#~~~~~~~~~~~~~~~~~~~~~~~~~Create Default Tag~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
Tag.create(:name => 'All', :parent_tag => nil)

Tag.create(:name => 'HGTimesNotice', :parent_tag => nil)
Tag.create(:name => 'FeedbackTag', :parent_tag => nil)

Tag.create(:name => 'Focus', :parent_tag => nil)
Tag.create(:name => 'Motion', :parent_tag => nil)
Tag.create(:name => 'World', :parent_tag => nil)
Tag.create(:name => 'Society', :parent_tag => nil)
Tag.create(:name => 'Local', :parent_tag => nil)

Tag.create(:name => 'Politics', :parent_tag => nil)
Tag.create(:name => 'Life', :parent_tag => nil)

Tag.create(:name => 'Business', :parent_tag => nil)
#Tag.create(:name => 'Stock', :parent_tag => 'Business')

Tag.create(:name => 'Sci_Tech' , :parent_tag => nil)
Tag.create(:name => 'Sport', :parent_tag => nil)
#Tag.create(:name => 'NBA', :parent_tag => 'Sport')
#Tag.create(:name => 'Baseball', :parent_tag => 'Sport')

Tag.create(:name => 'Entertainment', :parent_tag => nil)
Tag.create(:name => 'Health', :parent_tag => nil)
Tag.create(:name => 'Internet', :parent_tag => nil)
Tag.create(:name => 'Travel', :parent_tag => nil)
#Tag.create(:name => 'Car', :parent_tag => nil)
Tag.create(:name => 'Education', :parent_tag => nil)
Tag.create(:name => 'Art', :parent_tag => nil)
Tag.create(:name => 'Special', :parent_tag => nil)



Tag.create(:name => 'Closed_spam', :parent_tag => nil)
Tag.create(:name => 'Closed_spam_report', :parent_tag => nil)

# NOTE: FAQ should be the last one!!!
#
Tag.create(:name => 'FAQ', :parent_tag => nil)


#~~~~~~~~~~~~~~~~~~~~~~~~~Create Default News (for FAQ)~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Title = Q,  Content = A

image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
tag = Tag.find_by_name("FAQ")
area_tw = Area.find_by_name("Taiwan")
area_usa = Area.find_by_name("USA")
user = User.find(2)

# SOP to create a new FAQ entry
#
# ---------- Q22 (TW) --------------
#
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '22/22.在使用中我發現了一些問題，如何反饋意見給你們？'
news.content = 'HeyGo! Times(黑狗日報) 歡迎任何的批評與指教，您可在主頁的下方找到"官方回覆"的連結，
			依此連結到 HeyGo! Times(黑狗日報) 的facebook粉絲團，您可在此裡留言，我們會儘快處理您的反饋與意見。'
news.url = ''
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q21 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '21/22.我要去哪裡看 HeyGo! Times(黑狗日報) 的系統公告？'
news.content = '您可在主頁的最下面找到"公告"的連結。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q20 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '20/22.為什麼手機版上面沒有提供發佈新聞的功能？'
news.content = '目前 HeyGo! Times(黑狗日報) 手機版本屬於網頁的形式，使用者必須透過瀏覽器才可使用，故而無法使用手機上拍照的功能，這也導致利用手機隨時發佈即時新聞的功能大受限制！
<br><br>
HeyGo! Times(黑狗日報) 將提供iPhone與Android的App版本，其中就會包含完整的新聞發佈功能。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q19 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '19/22.為什麼手機版上的新聞內容長度這麼長？我想要留言時得一直移動畫面，很不方便耶！'
news.content = '基於尊重原始新聞網站的著作權，我們不能裁減原始新聞網站中的任何元素。為了讓使用者能夠方便地在手機上對此新聞發表評論，HeyGo! Times(黑狗日報) 手機版本在新聞內容頁面的最上方增加了一個"到讀者回應"的按鈕，您可很容易地跳到發表評論的位置。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q18 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '18/22.手機的螢幕解析度比電腦螢幕差，你們如何讓使用者在手機上舒適的閱讀新聞？'
news.content = 'HeyGo! Times(黑狗日報) 的手機版本在顯示原始新聞網頁之前，會利用Google Web Toolkit的功能，在不裁減任何內容的前提下，將該新聞網頁轉換成手機模式。所以在手機上使用 HeyGo! Times(黑狗日報) 閱讀新聞是件輕鬆的事情，您再也不需要費心地縮放內容以符合螢幕的大小。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q17 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '17/22.我如何在手機上閱讀 HeyGo! Times(黑狗日報) 的新聞？'
news.content = 'HeyGo! Times(黑狗日報) 提供了手機版本的網頁，您可在手機的瀏覽器上輸入此網址：m.heygotimes.com。或仍使用www.hetgotimes.com，系統會判斷若您目前是在手機上操作，則會自動轉到手機版本的頁面。
<br><br>
當您進入 HeyGo! Times(黑狗日報) 手機版本主頁後，除了可以將其加入瀏覽器書籤，以方便下次訪問之外，也可將這個頁面加入主畫面螢幕（詳細操作步驟請參考您手機的使用說明），此後您可以直接從手機桌面叫起 HeyGo! Times(黑狗日報) 。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q16 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '16/22.為什麼顯示新聞詳細內容時還要把原始網站上的廣告顯示出來？不能只顯示該新聞的內容和相片嗎？'
news.content = '基於尊重原始新聞網站的著作權，我們不能直接對原始新聞網頁的內容進行篩選與重整，但我們已設法讓新聞內容出現在螢幕上最適合閱讀的位置，您可自己決定是否要閱讀新聞之外的內容。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q15 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '15/22.既然你們不審查新聞，如何避免有不肖使用者放上不恰當的新聞內容（如色情廣告）？'
news.content = '我們認為透過"使用者監督"，會比由 HeyGo! Times(黑狗日報) 統一審查來得公正且有效率！每篇新聞的右下角都有一個"檢舉"的按鈕，使用者只要簡單地輸入他認為此篇新聞不洽當的理由， HeyGo! Times(黑狗日報) 會立即介入審查，必要時會以最短的時間令該新聞下架。
<br><br>
（為避免檢舉濫用，使用者必須登入才可使用檢舉功能。）'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q14 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '14/22.我發佈的新聞會經過審查嗎？'
news.content = '我們不會審查任何使用者發佈的新聞。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q13 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '13/22.我如何在發佈新聞時，把我拍攝的照片當做新聞照片？'
news.content = '目前 HeyGo! Times(黑狗日報) 僅提供輸入新聞照片網址的功能，故您必須先將您的照片上傳到網路相簿中，並取得該照片的網址 - Google的Picase網路相簿(http://picasaweb.google.com)是個很好的選擇。
<br><br>
 HeyGo! Times(黑狗日報) 預計將在正式版中提供照片上傳的功能。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q12 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '12/22.為什麼我在發佈新聞時，已經貼上新聞的網址，新聞的內容不會自動填上對話框裡的表格？'
news.content = '當您輸入完新聞網址後，您還必須按下右上方的"取得新聞"按鈕，系統需要2~3秒去分析取得新聞的內容與照片的網址。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q11 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '11/22.我如何發佈新聞？'
news.content = '您可使用主頁面上"發佈新聞"的功能，當對話框出現時，您有兩個方法發佈新聞：
<br><br>
1. 如果您想發佈的新聞是個網頁，請先複製該網頁的網址，然後貼上"發佈新聞"對話框中的第一個編輯欄位中，接下來請按下"取得新聞"按鈕，系統就會自動幫您取得該新聞的內容與照片。
<br><br>
2. 您可選擇自行輸入新聞的標題，內容與照片網址。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q10 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '10/22.我可以篩選出我的所有朋友看過的新聞，為什麼不能只選定看某個朋友感興趣的新聞？'
news.content = '主要就是為了保護使用者隱私權的考量！除非使用者個人許可，否則通常一般使用者並不希望別人知道他生活得太多細節。
<br><br>
（此外 HeyGo! Times(黑狗日報) 的團隊正計畫是否要加入如同twitter裡的"follow"功能）'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q9 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '9/22.我的朋友會看到哪些與我有關的新聞？'
news.content = '實際上 HeyGo! Times(黑狗日報) 並不會提供"可篩選出某個特定好友的所有行為" 的功能，使用者僅能篩選出他的"所有"朋友曾經：1. 閱讀過，2.評論過，3. 喜歡 的新聞。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q8 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '8/22.新聞篩選中的"好友選項"是什麼意思？'
news.content = '好友選項可以幫您篩選出：1. 您個人閱讀與評論過的新聞。 2. 所有您在facebook的好友，在HeyGo! Times(黑狗日報) 中閱讀與評論過的新聞。
<br><br>
"篩選新聞"功能中的"好友選項"搭配其他的篩選功能，能夠幫您找出您真正會感興趣的新聞。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q7 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '7/22.HeyGo! Times(黑狗日報) 中動態新聞排序的依據是什麼？'
news.content = '我們有一套專為新聞之熱門程度所設計的計分演算法，這套演算法會考慮新聞被閱讀與評論的次數，以及使用者對各則新聞的喜好程度。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q6 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '6/22.新聞這麼多，我如何找到我真正感興趣的新聞？'
news.content = '您可使用主頁中"篩選新聞"的功能，您可依地區，新聞分類，好友選項與日期進行篩選，你的設定將會被記錄起來，下次您再造訪 HeyGo! Times(黑狗日報) 時，系統就會主動為您篩選新聞。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q5 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '5/22.HeyGo! Times(黑狗日報) 以後會支持其他社群網站（如twitter）的帳號嗎？'
news.content = '當然，我們會持續加入對其他實名制社群的支持。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q4 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '4/22.我沒有facebook帳號也可以使用 HeyGo! Times(黑狗日報) 的服務嗎？'
news.content = '使用者無需登入即可閱讀 HeyGo! Times(黑狗日報) 中的所有新聞與評論，但為了控制新聞評論的品質，HeyGo! Times(黑狗日報) 要求使用者必須登入後才可發佈新聞，發表評論與提供反饋。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q3 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = '3/22.為什麼 HeyGo! Times(黑狗日報) 不需要註冊？'
news.content = 'HeyGo! Times(黑狗日報) 旨在提供所有使用者豐富完整的新聞，以及一個方便的新聞評論園地，並不需要收集使用者的個人資訊；且鑑於facebook是世界上活躍會員最多的社群，故 HeyGo! Times(黑狗日報) 選擇使用facebook的會員系統。
<br><br>
值得注意的是：即便您沒有facebook帳號，您依然可閱讀 HeyGo! Times(黑狗日報) 中的所有新聞與評論。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q2 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = "2/22.HeyGo! Times(黑狗日報) 與一般新聞網站有什麼不同？"
news.content = '有意義的評論可讓讀者對新聞有更深入的理解，有時比新聞本身還有價值；而一般新聞網站通常並未整合實名制的社交功能，導致新聞的評論區中充滿垃圾訊息，不值一讀！HeyGo! Times(黑狗日報) 則自各地區具代表性的新聞網站中不斷收集新聞，並完整整合了facebook的留言系統。
<br><br>
一般新聞網站的新聞來自專業記者或其他新聞網站，難免會對新聞依其意識型態進行篩選；HeyGo! Times(黑狗日報) 除了追求廣泛的新聞來源外，也可讓使用者自行發佈其想要分享的新聞，使得HeyGo! Times(黑狗日報) 中的新聞更加多元化！'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save


# ---------- Q1 (TW) --------------
#
image = Image.create(:url => "http://heygotimes.heroku.com/images/HeyGoTimes_logo.png")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = "1/22.HeyGo! Times(黑狗日報) 提供哪些服務？"
news.content = 'HeyGo! Times(黑狗日報) 是具社交功能的新聞網站，除了豐富與不斷更新的新聞外，只要您擁有facebook帳號，即可發佈您發現的新聞，並參與您感興趣之新聞的討論；除了傳統的新聞分類外，使用者可以只閱讀他的朋友所關心的新聞。'
news.url = ""
news.area_string = ""

news.save
image.news = news
image.save





