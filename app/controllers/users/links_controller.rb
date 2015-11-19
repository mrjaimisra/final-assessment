class Users::LinksController < Users::UsersController
  before_action :current_link, :authorize!, except: [:index, :new, :create]
  respond_to :html, :js

  def index
    @links = current_user.links
    @lists = current_user.lists
    @link = Link.new
  end
  
  def create
    @user = current_user
    @links = @user.links
    @link = Link.new(link_params)
    @link.user_id = current_user.id

    if @link.save
      redirect_to user_links_path(current_user)
    else
      render :index
    end
  end

  def edit
    @link = Link.find_by(id: params[:id])
  end

  def update
    @link = current_link
    if current_link.update_attributes(link_params)
      redirect_to user_links_path(current_user)
    else
      flash.now[:danger] = "Update failed, please enter valid information"
      redirect_to edit_user_link_path(current_user, @link)
    end
  end

  def read
    @link = current_link
    current_link.update_attribute(:status, true)
    current_link.save
    render :index
  end

  def unread
    @link = current_link
    current_link.update_attribute(:status, false)
    current_link.save
    render :index
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id, :list_id, :status)
  end

  def authorized?
    current_link.user_id == current_user.id
  end

  def current_link
    @current_link = Link.find_by(id: params[:id])
  end
end
