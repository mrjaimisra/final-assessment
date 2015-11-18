class Users::LinksController < Users::UsersController
  before_action :current_link, :authorize!, except: [:index, :new, :create]

  def index
    @user = User.find_by(params[:id])
    # @links = @user.links.where(status: false)
    @links = @user.links
  end

  private

  def list_params
    params.require(:link).permit(:url, :title, :user_id, :status)
  end

  def authorized?
    current_link.user_id == current_user.id
  end

  def current_list
    @current_list = List.find_by(id: params[:id])
  end
end
