class Newsletter < ActiveRecord::Base
  named_scope :actived?, :conditions => { :situation => true }
  validates_presence_of :email,:name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :email,:message => 'Esse email já existe'
end

