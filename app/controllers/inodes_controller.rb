class InodesController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_inode, only: %w(download search edit_share create_share delete_share)

  def index
    redirect_to current_user.inode
  end

  def new_file
    @inode = Inode.new(parent_id: params[:inode_id], inode_type: 'file')
    render :new
  end

  def new_directory
    @inode = Inode.new(parent_id: params[:inode_id], inode_type: 'directory')
    render :new
  end

  def destroy
    destroy! { @inode.parent }
  end

  def download
    send_file(@inode.content.path, filename: @inode.name, length: @inode.file_size)
  end

  def search
    if @key = params[:key]
      @inodes = @inode.subtree.ransack(name_cont: @key).result if @key.present?
    end
  end

  def edit_share
    @followers = @inode.followers
  end

  def create_share
    user = User.find_by(email: params[:email])
    user.follow(@inode)
    redirect_to inode_share_path(@inode), notice: "add share for #{user.email}"
  end

  def delete_share
    user = User.find(params[:user_id])
    user.stop_following(@inode)
    redirect_to inode_share_path(@inode), notice: "delete share for #{user.email}"
  end

  private

  def inode_params
    params.require(:inode).permit(:name, :inode_type, :parent_id, :content)
  end

  def set_inode
    @inode = Inode.find(params[:inode_id])
  end
end

