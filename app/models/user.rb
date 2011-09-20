# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  address_line_1      :string(255)
#  address_line_2      :string(255)
#  city                :string(255)
#  state               :string(255)
#  zipcode             :string(255)
#  phone_number        :string(255)
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer         default(0), not null
#  failed_login_count  :integer         default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  active              :boolean         default(FALSE), not null
#  created_at          :datetime
#  updated_at          :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  
  acts_as_authentic do |c|
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 8 }
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 8 }
  end
  
  # Validations
  validates :name, :presence => true, :length => {:maximum => 255}

  def active?
    active
  end

  # We need to make sure that a user has a password set when they activate their account
  def has_no_credentials?
    self.crypted_password.blank?
  end
  
  def has_credentials?
    !self.has_no_credentials?
  end
  
  # Sign up a user before activation
  def sign_up!(params)
    self.email = params[:user][:email]
    save_without_session_maintenance
  end
  
  # Set information needed for the user to be activated.  User must at least set a password here
  def activate!(params)
    self.active = true
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    save
  end
  
  # Deliver the activation email
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end
  
  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end
  
  
end

