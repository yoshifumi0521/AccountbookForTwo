# coding: utf-8
#ログインやログアウトするコントローラー
class SessionsController < ApplicationController

  #oauth認証をするアクション。ここで、Facebookにリダイレクトする。
  def get
    
    #リダイレクトurlを取得する。
    @redirect_url = GetObject("get",nil)
    #facebookにリダイレクトする。
    redirect_to @redirect_url 

  end

  #Facebookからcallbackがきたらするアクション
  def callback
   
    @code = params[:code]
    #アクセストークンのオブジェクトを取得。これをUserコントローラーのnewに渡したいかも。
    @access_token = GetObject("callback",@code) 
    #ユーザーのデータを取得して、@user_data変数に格納する。
    @user_data = @access_token.get("/me/").parsed
    logger.debug(@user_data)


    #誰からも選んでもらってない場合は、getstartコントローラのフォローに飛ぶ。            
    redirect_to :follow, :flash => {:code => @code}
    return



    

  end


  #何らかのオブジェクトを返すメソッド。いろいろなoauthオブジェクトなど内部で作成
  def GetObject(pattern,param)
    
    #oauthクラスをつくるための変数
    @app_id = Settings.APPID
    @app_secret = Settings.APPSECRET 
    @args = {:site => 'https://graph.facebook.com', :token_url => '/oauth/access_token', :ssl => { :verify => false } }

    #OAuth2::Clientオブジェクトを取得
    @client = OAuth2::Client.new( @app_id ,@app_secret, @args) 
    @callback_url = url_for(:controller => "sessions",:action => "callback")

    if pattern == "get" 
      #メールアドレスを取得するために、スコープに"email"をいれる。
      return @client.auth_code.authorize_url(:redirect_uri => @callback_url,:scope => "email")
    elsif pattern == "callback"
      #フォーマットを決める。
      @header_format = 'OAuth %s'
      return @client.auth_code.get_token(param, {:redirect_uri => @callback_url,
        :parse => :query} ,{:header_format => @header_format})
    end

  end
 















end
