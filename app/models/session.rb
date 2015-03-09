class Session < ActionDispatch::Session::CookieStore
  attr_accessor :email, :password
end