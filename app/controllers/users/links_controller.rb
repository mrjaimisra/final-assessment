class Users::LinksController < Users::UsersController
  before_action :current_link, :authorize!, except: [:index, :new, :create]

  def index
    @user = User.find_by(params[:id])
    @links = @user.links
    @link = Link.new
  end

  def create
    @user = User.find_by(params[:id])
    @links = @user.links
    @link = Link.new(link_params)
    @link.user_id = current_user.id

    if @link.save
      redirect_to user_links_path(current_user)
    else
      render :index
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id, :status)
  end

  def authorized?
    current_link.user_id == current_user.id
  end

  def current_link
    @current_link = List.find_by(id: params[:id])
  end
end
