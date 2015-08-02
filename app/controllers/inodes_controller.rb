class InodesController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_inode, :check_permission, only: %w(show download search edit_share create_share delete_share activities create_share_link delete_share_link)

  def index
    redirect_to current_user.inode
  end

  def show
    show!
  end

  def new_file
    @inode = Inode.new(parent_id: params[:inode_id], inode_type: 'file')
    render :new
  end

  def new_directory
    @inode = Inode.new(parent_id: params[:inode_id], inode_type: 'directory')
    render :new
  end

  def create
    create! { @inode.parent }
  end

  def destroy
    destroy! { @inode.parent }
  end

  def search
    if @key = params[:key]
      @inodes = @inode.subtree.ransack(name_cont: @key).result if @key.present?
    end
  end

  def edit_share
  end

  def create_share
    user = User.find_by(email: params[:email])
    if user
      user.follow(@inode)
      redirect_to inode_share_path(@inode), notice: "add share for #{user.email}"
    else
      redirect_to inode_share_path(@inode), notice: "can't find user"
    end
  end

  def delete_share
    user = User.find(params[:user_id])
    user.stop_following(@inode)
    redirect_to inode_share_path(@inode), notice: "delete share for #{user.email}"
  end

  def activities
  end

  def create_share_link
    share = @inode.shares.create!(email: params[:email])
    Message.shared_link(share).deliver
    redirect_to inode_share_path(@inode)
  end

  def delete_share_link
    share = @inode.shares.find(params[:share_id])
    share.destroy!
    redirect_to inode_share_path(@inode)
  end

  private

  def inode_params
    params.require(:inode).permit(:name, :inode_type, :parent_id, :content)
  end

  def set_inode
    @inode = Inode.find(params[:inode_id] || params[:id])
  end
end

