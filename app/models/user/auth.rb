module User::Auth
  extend ActiveSupport::Concern

  attr_reader :password

  included do
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: { on: :create }, confirmation: true
  end

  def password=(password)
    @password = password

    self.password_digest = digest(password) if password.present?
  end

  def authenticate(password)
    digest(password) == password_digest ? self : false
  end

  private

  def digest(password)
    Digest::SHA1.hexdigest(password)
  end
end 
