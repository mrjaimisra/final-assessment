class Users::ListsController < Users::UsersController
  before_action :current_list, :authorize!, except: [:index, :new, :create]

  def index
    @user = User.find_by(params[:url])
    @lists = @user.lists.where(status: "unarchived")
  end

  def show
    @list = current_list
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to user_links_path(current_user)
    else
      redirect_to new_user_list_path(current_user)
    end
  end

  def edit
    @list = List.find_by(id: params[:id])
  end

  def update
    @list = current_list
    if current_list.update_attributes(list_params)
      redirect_to user_list_path(current_user, current_list)
    else
      flash.now[:danger] = "Update failed, please enter valid information"
      render :edit
    end
  end

  def destroy
    current_list.reassign_links
    current_list.destroy

    redirect_to user_links_path(current_user)
    flash[:message] = "List successfully deleted"
  end

  private

  def list_params
    params.require(:list).permit(:title, :user_id)
  end

  def authorized?
    current_list.user_id == current_user.id
  end

  def current_list
    @current_list = List.find_by(id: params[:id])
  end
end
