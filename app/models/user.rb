class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :old_password, :updating_password
  attr_accessible :email, :nick, :password, :password_confirmation, :old_password, :updating_password

  #Relationships

  #Validators
  validates :email,
              presence: true,
              uniqueness: true,
              email_format: true
  validates :nick,
              presence: true,
              uniqueness: true

  validates_length_of :nick, maximum: 15 #or 30 eng charactors, a validation should be implemented
  validates_presence_of :password, if: lambda {|u| u.should_validate_password? }
  validates_length_of :password, minimum: 6, maximum: 20, if: lambda {|u| u.should_validate_password? }
  validates_confirmation_of :password, if: lambda {|u| u.should_validate_password? }

  #Others
  before_save :encrypt_password
  before_save :check_old_password, if: lambda {|u| u.should_validate_password? }
  before_create { generate_token(:auth_token)}
  before_validation :strip_whitespace

  def should_validate_password?
    updating_password || new_record?
  end

  def self.of_auth_token(token)
    User.first(conditions: {auth_token: token})
  end

  def authenticate(password)
    if password.present? && self.password_hash == BCrypt::Engine.hash_secret(password, self.password_salt)
      true
    else
      false
    end
  end

  def self.roles
    [[I18n.t("roles.inactive_user"), -1], [I18n.t("roles.normal_user"), 1], [I18n.t("roles.master"), 3], [I18n.t("roles.editor"), 7], [I18n.t("roles.admin"), 9]]
  end

  def has_permission?(permission)
    case permission
      when :normal_user
        self.role >= NORMAL_USER_ROLE
      when :master
        self.role >= MASTER_ROLE
      when :editor
        self.role >= EDITOR_ROLE
      when :admin
        self.role == ADMIN_ROLE
      else
        raise "invalid permission"
    end
  end

  #TODO stub
  def get_avatar(version = nil)
    "/assets/anonymous_m_#{version.to_s}.png"
  end

  private

  def generate_token(column)
     begin
       self[column] = SecureRandom.urlsafe_base64
     end while User.where(column => self[column]).exists?
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def check_old_password
    if !self.new_record? && password_hash_changed?
      if self.password_hash_was != BCrypt::Engine.hash_secret(old_password, self.password_salt_was)
        errors.add(:old_password, I18n.t("errors.messages.old_password_not_match"))
        false
      end
    end
  end

  def strip_whitespace
    self.email = self.email.strip.force_encoding("BINARY").delete 160.chr+194.chr
    self.nick = self.nick.strip
  end

end
