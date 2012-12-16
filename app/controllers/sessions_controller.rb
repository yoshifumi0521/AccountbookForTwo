# coding: utf-8
#ログインやログアウトするコントローラー
class SessionsController < ApplicationController

  #applicationコントローラーのauthorizeメソッドは実行しないようにする。
  skip_before_filter :authorize

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
    @token = @access_token.token
    
    #ユーザーのデータを取得して、@user_data変数に格納する。
    @user_data = @access_token.get("/me/").parsed

    #ユーザーのデータを取得する。
    @user = User.find_or_initialize_by_uid(@user_data["id"])

    #ユーザーのレコードが保存されたかを判定する。
    if @user.new_record?
      @user.name = @user_data["name"]      
      @user.mail = @user_data["email"]
      @user.image = "http://graph.facebook.com/"+ @user_data["id"] + "/picture"
      if @user.save
      
      else
        #ここでエラー処理。
        
        return
      end
    end

    #ログインユーザーのidをcookiesに保存する。
    cookies.signed[:user_id] ={ value: @user.id ,expires: 30.days.from_now }   

    #@userのmatchを判定する。
    if @user.match
      #"posts/new"にリダイレクトする。
      redirect_to :new_post_path      
      return
    end

    #waitの判定をする。trueだったら、waitingにリダイレクトする。
    if @user.wait
      #"users/:id/waiting"にリダイレクトする。
      redirect_to waiting_user_path(@user.id)     
      return
    end

    #ここでUserモデルの中のfollow_idに自分のuidがあるかどうかを調べる。
    @followers = User.where(:follow_id => @user.uid)
  
    #@followersが空だったらする処理。
    if @followers == [] 
      
      #Facebookの友達からパートナーを探す。"users/:id/follow"にリダイレクトする。
      redirect_to follow_user_path(@user.id)
      #セッションにアクセストークンを記録する。暗号化？
      session[:token] = @token  
      return
    else
      #@followersが空でなかったらする処理。
      #"users/:id/select"にリダイレクトする。
      redirect_to select_user_path(@user.id) 
      return
    end

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
