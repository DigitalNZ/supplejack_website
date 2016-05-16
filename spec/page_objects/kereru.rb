class Kereru
  def home
    @home ||= HomePage.new
  end

  def sign_up
    @sign_up ||= SignUpPage.new
  end

  def login
    @login ||= LoginPage.new
  end

  def search
    @search ||= SearchPage.new
  end
end
