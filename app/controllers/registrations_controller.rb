class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end

  def sign_up_params
    params.require(:user).permit(:name, :country_code, :phone, :password)
  end
end