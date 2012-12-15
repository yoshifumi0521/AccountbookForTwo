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

  end

  def followed
    logger.debug("aaaaaa")




  end
  





  def waiting
  
 





  end

  
 

  



end
