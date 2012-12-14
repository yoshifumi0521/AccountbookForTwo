class User < ActiveRecord::Base
  attr_accessible :follow_id, :match, :name, :partner_id, :uid, :wait
end
