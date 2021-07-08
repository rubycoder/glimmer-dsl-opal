require "observer"

class LoginPresenter

  attr_accessor :user_name
  attr_accessor :password
  attr_accessor :status

  def initialize
    @user_name = ""
    @password = ""
    @status = "Logged Out"
  end

  def status=(status)
    @status = status

    notify_observers("logged_in")
    notify_observers("logged_out")
  end
  
  def valid?
    !@user_name.to_s.strip.empty? && !@password.to_s.strip.empty?
  end

  def logged_in
    self.status == "Logged In"
  end

  def logged_out
    !self.logged_in
  end

  def login
    return unless valid?
    self.status = "Logged In"
  end

  def logout
    self.user_name = ""
    self.password = ""
    self.status = "Logged Out"
  end

end

class Login
  include Glimmer

  def launch
    presenter = LoginPresenter.new
    @shell = shell {
      text "Login"
      composite {
        grid_layout 2, false #two columns with differing widths

        label { text "Username:" } # goes in column 1
        @user_name_text = text {   # goes in column 2
          text <=> [presenter, :user_name]
          enabled <= [presenter, :logged_out]
          on_key_pressed { |event|
            @password_text.set_focus if event.keyCode == swt(:cr)
          }
        }

        label { text "Password:" }
        @password_text = text(:password, :border) {
          text <=> [presenter, :password]
          enabled <= [presenter, :logged_out]
          on_key_pressed { |event|
            presenter.login if event.keyCode == swt(:cr)
          }
        }

        label { text "Status:" }
        label { text <= [presenter, :status] }

        button {
          text "Login"
          enabled <= [presenter, :logged_out]
          on_widget_selected { presenter.login }
          on_key_pressed { |event|
            presenter.login if event.keyCode == swt(:cr)
          }
        }

        button {
          text "Logout"
          enabled <= [presenter, :logged_in]
          on_widget_selected { presenter.logout }
          on_key_pressed { |event|
            if event.keyCode == swt(:cr)
              presenter.logout
              @user_name_text.set_focus
            end
          }
        }
      }
    }
    @shell.open
  end
end

Login.new.launch
