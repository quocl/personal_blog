class MyDevise::RegistrationsController < Devise::RegistrationsController
  def new
    if User.count < 1
      super
    else
      redirect_to :root
    end
  end
end