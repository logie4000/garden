class User < ApplicationRecord
  has_many :crops

  validates :username, :presence => true, :uniqueness => true
  validates :username, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "must be a valid email format!" }

  validates :password_presence, :presence => true
  validates :password, :confirmation => true
  #validates :password_confirmation, :presence => true, unless: :password.nil?
  validates :api_key, :uniqueness => true

  def self.authenticate(username, password)
    # Return nil if username or password are not provided
    return nil unless (username && password)

    # Find the user record in the db
    user = User.find_by_username(username)

    # Return nil if user is not found, or has no password value
    return nil unless user
    return nil unless user.password_hash

    # Return nil if the password does not match the stored hash value
    user = nil unless (user.password_hash == User.encrypted_password(password, user.password_salt))
    
    return user
  end

  def self.register(username, password)
    return nil unless (username && password)

    # Check for existing username
    user = User.find_by_username(username)
    raise UserAlreadyExistsError, "Username already exists!" if user

    user = User.new(:username => username)
    user.password = password
    user.save!
  end

  def self.generate_api_key
    while true
      now = Time.now
      token = Digest::SHA256.hexdigest now.tv_nsec.to_s + rand.to_s
      return token unless User.exists?(:api_key => '#{token}')
    end    
  end
 
  # Password is a virtual attribute
  def password
    @password
  end

  def password=(pswd)
    unless (pswd.nil? || pswd == "")
      @password = pswd
      create_new_salt
      self.password_hash = User.encrypted_password(self.password, self.password_salt)
    end
  end

  def password_confirmation
    @password_confirmation
  end

  def password_confirmation=(pswd_conf)
    unless (pswd_conf.nil? || pswd_conf == "")
      @password_confirmation = pswd_conf
    end
  end

  def password_presence
    if (self.password || self.password_hash)
      return true
    else
      return false
    end
  end

  # Returns an encrypted password from the given clear text password and the salt
  def self.encrypted_password(pswd, salt)
    Rails.logger.debug "Generating new encrypted password with pswd = #{pswd}, salt = #{salt}"
    string_to_hash = pswd + "acoaxet" + salt
    pw_hash = Digest::SHA2.hexdigest(string_to_hash)
    Rails.logger.debug "Encrypted password: #{pw_hash}"
    return pw_hash
  end

  def is_admin?
    if (self.is_admin && self.is_admin > 0)
      return true
    else
      return false
    end
  end
  
private
  # Create a new salt
  def create_new_salt
    self.password_salt = self.object_id.to_s + rand.to_s
  end
end
