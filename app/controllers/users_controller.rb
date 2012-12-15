#codig: utf-8
#Userコントローラー
class UsersController < ApplicationController
 


  #友達をフォローするアクション
  def follow
    
    @token = session[:token]
    #koalaライブラリを使って、友達の情報を取得する。 
    @graph = Koala::Facebook::API.new(@token)
  
    @friends = @graph.fql_query("select uid, name, pic_square from user where uid in (select uid2 from friend where uid1 = me())")
    @user = @current_user
    logger.debug(@user.inspect)    

  end

  #フォローしたら行われるアクション
  def followed
  
    @user_id = @current_user.id
    #フォローしたユーザーのパートナーがいるかどうか調べる。 
    @follower = User.find_by_uid(params[:id])
    if @follower
      if @follower.match == true
        #パートナーを探す"users/:id/follow"にリダイレクト
        redirect_to follow_user_path(@usr_id)
        return
      end
    end

    @user = User.find_by_id(@current_user.id)
    @user.follow_id = params[:uid]
    @user.follow_image = "http://graph.facebook.com/" + params[:uid] + "/picture"
    @user.follow_name = params[:name]
    #waitをtrueにする。
    @user.wait = true

    if @user.save
      #リダイレクトする。
      redirect_to waiting_user_path(@user_id) 
      return
    else
      #ここでエラー処理。
      
      return
    end


  end
  
  #待ち受け画面に映るアクション
  def waiting
  
    #フォローしたユーザーのパートナーがいるかどうか調べる。 
    @follower_id = @current_user.follow_id
    @follower = User.find_by_uid(@follower_id)

    if @follower
      if @follower.match == true
        #パートナーを探す"users/:id/follow"にリダイレクト
        redirect_to follow_user_path(@current_user.id)
        return
      end
    end

  end

  #フォローされた人から選ぶ。
  def select 

    logger.debug("select--")










  end








  
 

  



end
