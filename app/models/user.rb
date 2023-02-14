class User < ApplicationRecord
  has_secure_password

  validates :password, confirmation: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true


  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    if user.authenticate(password)  
      return user
    else
      return nil
    end
  end

end
