class Kereru
  def home
    @home ||= HomePage.new
  end

  def sign_up
    @sign_up ||= SignUpPage.new
  end
end
