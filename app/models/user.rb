class User < ActiveRecord::Base


  #validations
  validates_presence_of :nick
  validates_presence_of :email


end
