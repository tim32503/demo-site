require 'digest'

class User < ApplicationRecord
  validates :email, presence: true, 
                    uniqueness: true, format: { with: /.+\@.+.\.+/ }
  validates :password, presence: true, 
                       confirmation: true
  before_create :encrypt_password

  def self.login(params)
    email = params[:email]
    password = params[:password]
    encrypted_password = Digest::SHA1.hexdigest("hao#{password}hao")

    fing_by(email: email, password: encrypted_password)
  end

  private
  def encrypt_password
    self.password = Digest::SHA1.hexdigest(salted_password)
  end

  def salted_password
    "hao#{self.password}hao"
  end
end
