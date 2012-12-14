#coding: utf-8
#Userモデル
class User < ActiveRecord::Base
  
  attr_accessible :follow_id, :match, :name, :partner_id, :uid, :wait

  #バリデーションをつける。
  validates :name,:presence => true
  validates :uid, :presence => true, :uniqueness=>true



end
