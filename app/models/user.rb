require 'digest/sha1'

class User < ActiveRecord::Base

  validates_uniqueness_of :email, :message => "Specified e-mail address is already registered with sportbookpage.com"

  validates_presence_of :first_name, :last_name
  validate :valid_password
  validate :valid_email
  validate :sportbucks_is_positive


  def self.authenticate(email, password)
    user = self.find_by_email(email.downcase)
    if user != nil
      expected_password = encrypted_field(password, user.salt)
    
      if user.hashed_password != expected_password
        user = nil
      end
      
    end
    
    return user
  end
  
  # 'password' is a virtual attribute
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    if(pwd != self.hashed_password)
      create_new_salt
      self.hashed_password = User.encrypted_field(self.password, self.salt)
    else
      self.hashed_password = pwd
    end
  end

  def email=(e)
    write_attribute(:email, e.downcase)
  end
  
  #def answer_1=(ans_1)
  #  write_attribute(:answer_1, ans_1.downcase)
  #end
  #
  #def answer_2=(ans_2)
  #  write_attribute(:answer_2, ans_2.downcase)
  #end
  
  
  def self.encrypted_field(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  
private

  #############################################################################
  # Description:
  #   Validates that all required fields are present. If a field does not exist,
  #   an error is added to User.errors[]
  #
  #############################################################################
  def validate_presence_of_attributes
    if first_name.blank? 
      errors.add(:first_name, "First name is a required field")
    end
    if last_name.blank? 
      errors.add(:last_name, "Last name is a required field")
    end
    if question_1.blank? 
      errors.add(:question_1, "Security question 1 is a required field")
    end
    if answer_1.blank? 
      errors.add(:answer_1, "Answer 1 is a required field")
    end
    if question_2.blank? 
      errors.add(:question_2, "Security question 2 is a required field")
    end
    if answer_2.blank? 
      errors.add(:answer_2, "Answer 2 is a required field")
    end
  end

  #############################################################################
  # Description:
  #   Validate a user's chosen password. A valid password is between 6 and 20 
  #   characters in length. If the chosen password is invalid, add an error to 
  #   User.errors[]
  #
  #############################################################################
  def valid_password
    if(@password != self.hashed_password)
      if (@password.blank? || @password.length < 6 || @password.length > 20)
        errors.add(:password, "You're password must be between 6 and 20 characters long.")
      end
    end
  end
  
  #############################################################################
  # Description:
  #   Validate a user's email address. A valid e-mail address is non-blank, does
  #   not currently exist in the database, and ends with a three letter extension.
  #   If the email address is invalid, add an error to User.errors[]
  #
  #############################################################################
  def valid_email
    
    #if User.find_by_email(email)
    #  errors.add(:email, "Specified e-mail address is already registered with sportbookpage.com")
    if email.blank?
      errors.add(:email, "E-mail address is a required field")
    elsif !(email =~ /(.+)@(.+)\.(.{3})/)
      errors.add(:email, "Invalid e-mail address")
    end
    
  end
  
  #############################################################################
  # Description:
  #   Validate that a user's sportbucks total is not less than zero. If the 
  #   sportbucks total is less than 0, add an error to User.errors[]
  #
  #############################################################################
  def sportbucks_is_positive
    if(sportbucks < 0)
      errors.add(:sportbucks, "Sportbucks cannot be a negative value")
    end
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  

  
end
