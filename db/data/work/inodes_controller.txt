class InodesController < InheritedResources::Base
  before_action :authenticate_user!

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

  private

  def inode_params
    params.require(:inode).permit(:name, :inode_type, :parent_id, :content)
  end
end

