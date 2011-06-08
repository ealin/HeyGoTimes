<script type="text/javascript"><!--
google_ad_client = "ca-pub-3897509087802836";
/* heygotimes_ad */
google_ad_slot = "2636855508";
google_ad_width = 120;
google_ad_height = 600;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>




  <% if session[:login] == true %>
      <button id = "load_previous_filter"> <%= t(:load_previous_filter)%> </button>
  <% else %>
      <button id = "load_previous_filter" disabled="true"> <%= t(:load_previous_filter)%> </button>
  <% end %>




     # Ealin: this filed is only for controller, it's not meaningful when the record saved in DB.
      #    (it would waste a little DB space, it's ok because there's not so many tags in our application.')
      #
      t.integer :checked



    # get selected tags from session(or cookie)

    @tags.each do |tag|
          if(session[:filter_tags] == nil)
            tag.checked = false
          else
            if (session[:filter_tags]).sub!(tag.name)
              tag.checked = true
            else
              tag.checked = false
            end
          end
        end



  <input type="submit" id="save_filter" value="<%= t(:filter_ok) %>">  </input>


~~~~~~~~~~~~~~~~~~~~~~~ask all tags from server 2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#<div align = "left">
#  <h3><%= t(:filter_by_tag)%> </h3>
#  <button id="show_tags"><%= t(:show_tags) %></button>
#</div>#

#<div class = "setup_field" align = "center" >        <%#define my own ccs class!!! %>

#</div>

#<hr>


<script type="text/javascript">

 //  $(document).ready(function () {

  // get all tags from server.

//      $('#show_tags').unbind('click').click(function() {

  function get_all_tags()
  {
      // make sure this function would be executed only once!
      if( typeof get_all_tags.counter == 'undefined' )
      {
        get_all_tags.counter = 0;
      }

      if(get_all_tags.counter == 0)
        get_all_tags.counter = 1 ;
      else
        return ;

       $.getJSON("/tag/get_all_tags.json",'cmd=get_all_tag', function(json)
       {

             var append_html =  '<input type="checkbox"> ' ;
             append_html +=  json[0].tag.name ;
             append_html +=  '</input>' ;

             append_html +=  '<br><input type="checkbox"> ' ;
             append_html +=  json[1].tag.name ;
             append_html +=  '</input>' ;

            //$('#show_tags').
            $('.setup_field').append(append_html) ;

            //
            //$('#date_label')[0].lastChild.data = json[0].tag.name ;

            // disable the button
            $('#show_tags').attr("disabled", true);

            return false ;   // to prevent click event would be issued twice!
       } );

  }

  get_all_tags() ;

//      }  );

//  }  );
 </script>



~~~~~~~~~~~~~~~~~~~~~~~ask all tags from server 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


//  $(document).ready(function () {

  // get all tags from server.

//      $('#show_tags').unbind('click').click(function() {
         $.getJSON("/tag/get_all_tags.json",'cmd=get_all_tag', function(json)
         {

             var append_html =  '<input type="checkbox"> ' ;
             append_html +=  json[0].tag.name ;
             append_html +=  '</input>' ;

             append_html +=  '<br><input type="checkbox"> ' ;
             append_html +=  json[1].tag.name ;
             append_html +=  '</input>' ;

            //$('#show_tags').
            $('.setup_field').append(append_html) ;

            //
            //$('#date_label')[0].lastChild.data = json[0].tag.name ;

            // disable the button
            $('#show_tags').attr("disabled", true);

            return false ;   // to prevent click event would be issued twice!
         } );


//      }  );

//  }  );
 </script>

~~~~~~~~~~~~~~~~~~~~~~~網頁上用點選方式選擇日期~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<script language="javascript">
<!--
//日期
var srcDateElement;
function fbtnDate_onclick(){
  srcDateElement = window.event.srcElement;
  window.open ("/common/calendar.htm","","top=180,left=200,width=500, height=370,
    fullscreen=no,channelmode=no,toolbar=no,location=no,directories=no,status=yes, 
    menubar=no,scrollbars=no,resizable=no");
  window.event.cancelBubble = true;
}
//日期-顯示日期
function displayDate(dateString){
  if(srcDateElement.id=="fbtnStartDate")
    document.all("txtStartDate").value=dateString;
  else
    document.all("txtEndDate").value=dateString;
}
-->
</script>
<body>
查詢日期：
<button style="WIDTH: 60px; CURSOR: hand; COLOR: #ffff00; HEIGHT: 22px; BACKGROUND-COLOR: slategray" 
 id=fbtnStartDate name=fbtnStartDate LANGUAGE="javascript" onclick="return fbtnDate_onclick()">住院日</button>
<input LANGUAGE="javascript" size="8" id="txtStartDate"  name="txtStartDate" value="" tabindex=1>
<button style="WIDTH: 30px; CURSOR: hand; COLOR: #ffff00; HEIGHT: 22px; BACKGROUND-COLOR: slategray" 
 id=fbtnEndDate name=fbtnEndDate LANGUAGE="javascript" onclick="return fbtnDate_onclick()">至</button>
<input LANGUAGE="javascript" size="8" id="txtEndDate"  name="txtEndDate" value="" tabindex=1>
</body>

~~~~~~~~~~~~~~~~~~~~~~~修剪 setup/index.html.rb~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   <input type="button" value=<%= t(:deactive_account) %> onclick="self.location.href='deactive_fb_account'"/>

   <input type="button" value=<%= t(:connect_to_twitter) %> onclick="self.location.href='connect_twitter_account'"/>



~~~~~~~~~~~~~~~~~~~~~~~修剪 area.rb~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  has_one :area
  belongs_to :area, :foreign_key => "area_id"
  belongs_to :paper, :foreign_key => "paper_id"
  belongs_to :news, :foreign_key => "news_id"





  has_many :tag_filters
  has_many :tags, :through => :tag_filters

  has_many :area_filters
  has_many :areas, :through => :area_filters

~~~~~~~~~~~~~~~~~~~~~~~修剪 get_current_user_info()~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    # 1 account has MAX 3 email-address
    @email_for_subscription = "ealin@yahoo.com.tw"

    # 取得使用者訂閱的報紙列表 (read from database)
    @user_subscribed_paper_no = 4
    @user_subscribed_paper = Array.new
    @user_subscribed_paper[0] = "Taiwan"
    @user_subscribed_paper[1] = "Silicon Valley"
    @user_subscribed_paper[2] = "SH High School"
    @user_subscribed_paper[3] = "7-11 Special Price "


    <br>&nbsp;&nbsp;<%= t(:edit_no) + @edit_no.to_s %>
    &nbsp;&nbsp;<input type="button" value=<%= t(:to_my_history) %> onclick="self.location.href='/user_history/index/'"/>

    <br>&nbsp;&nbsp;<%= t(:AD_no) + @ad_no.to_s %>
    &nbsp;&nbsp;<input type="button" value=<%= t(:to_my_AD) %> onclick="self.location.href='/my_ad/index/'"/>


~~~~~~~~~~~~~~~~~~~~~~~修剪paper/_show_fun_buttons.html.erb~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<div>
<%=     link_to( image_tag("icon_target.png",:size => "45x45"), {:controller => 'my_ad'}, \
    {:title => 'issue a AD !'} )  %>
</div>

<div>
<%=     link_to( image_tag("icon_template.png",:size => "45x45"), {:controller => 'template'}, \
    {:title => '選擇報紙版型'} )  %>
</div>


~~~~~~~~~~~~~~~~~~~~~~~修剪paper/index.html.erb~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    <div id="search_bar">
        <!--- # show_search_bar is implemented in search_helper.rb
        show_search_bar@search_helper.rb ==> render _search_bar.html.erb ==> submit ==> search/do_search
        --->
        <%= show_search_bar :paper %>
      </div>





~~~~~~~~~~~~~~~~~~~~~~~about koala~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)

@access_token = @facebook_cookies["access_token"]
@graph = Koala::Facebook::GraphAPI.new(@access_token)

@likes = @graph.get_connections("me", "likes")

i = 10







	<!--- @logged_flag and method-login/logout/signup are defined in application_controller.rb -->
	<% if @logged_flag  == true %>   
      <%= link_to 'Logout', {:action => 'logout'}, {:title => 'logout'} %>
    <% else %>

        <% #link_to 'Login',  {:action => 'login'},  {:title => 'login'} %>


        <%= fb_connect_async_js %>
        <% if current_facebook_user != nil %>
          <% current_facebook_user.fetch %>
          <%= fb_logout_link("Logout of fb", request.url) %>
              <br />
          <%= "Welcome #{current_facebook_user.first_name} #{current_facebook_user.last_name}!" %>
        <% else
           # you must explicitly request permissions for facebook user fields.
           # here we instruct facebook to ask the user for permission for our website
           # to access the user's facebook email and birthday
           %>
          <%= fb_login_and_redirect('http://localhost:3000/', :perms => 'email,user_birthday') %>
        <% end %>

    <% end %>





  def check_logged_in
    # cehck status of session, then store it to class-variable - @@logged_flag  
   
    
    # 紀錄current user 是否已經login (要使用session的功能, session should be stored in database) 
    # (all controllers in this system would have attribute - "@logged_flag")
    if session[:logged_in] == nil
      @logged_flag = false
    else
      @logged_flag = true
    end

    
    return @logged_flag
    
  end
  #===========================================================================








   <% if @logged_flag  == true %>
      <%= show_logout #defined in user_helper.rb
      %>
    <% else %>
      <%= show_login %>
    <% end %>





  <% @user_account_email.each do |email| %>
        <br>&nbsp;&nbsp;
        <% if email == nil %>
           <input type="button" value=<%= t(:add_email) %> onclick="self.location.href='add_email'"/>
        <%else%>
           <%=email %>
           <input type="button" value=<%= t(:modify_email) %> onclick="self.location.href='modify_email'"/>
          <%end%>
   <% end %>
