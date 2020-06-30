class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true 
  validates_uniqueness_of :email
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_validation(on: :create) do
    self.email = format_email(email)
  end

  def format_email(email)
    remove_white = email.strip unless self.email.nil?
    email_arr = remove_white.split('')
    email_arr.map! do |char|
      if char.count("a-zA-Z") > 0
        char.downcase
      else
        char
      end
    end
    modified_email = email_arr.join
    self.email = modified_email
  end

  def self.authenticate_with_credentials(email, password)
    #remove whitespace and convert string to lowercase
    white_space_removed_email = email.strip
    email_arr = white_space_removed_email.split('')
    email_arr.map! do |char|
      if char.count("a-zA-Z") > 0
        char.downcase
      else
        char
      end
    end
    modified_email = email_arr.join
    puts modified_email
    user = User.where("LOWER(email) = ?", modified_email.downcase)
    user = User.find_by_email(modified_email.downcase)
    if user && user.authenticate(password)
      return user
    end
  end

end
