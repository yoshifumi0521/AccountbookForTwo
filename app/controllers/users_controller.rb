#codig: utf-8
#Userコントローラー
require 'net/http'
class UsersController < ApplicationController
 


  #友達をフォローするアクション
  def follow
    
    @token = session[:token]
    #koalaライブラリを使って、友達の情報を取得する。 
    @graph = Koala::Facebook::API.new(@token)
    #@friends = @graph.get_connections("me", "friends")
  
    @friends = @graph.fql_query("select uid, name, pic_square from user where uid in (select uid2 from friend where uid1 = me())")

    logger.debug(@friends)


  end

  def waiting
  
 





  end

  
 

  



end
