class UserSession < Authlogic::Session::Base
  generalize_credentials_error_messages "Login/password invaild"
end