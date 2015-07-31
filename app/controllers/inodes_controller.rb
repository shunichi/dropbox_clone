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

  def download
    inode = Inode.find(params[:inode_id])
    send_file(inode.content.path, filename: inode.name, length: inode.file_size)
  end

  def search
    @inode = Inode.find(params[:inode_id])

    if @key = params[:key]
      @inodes = @inode.subtree.ransack(name_cont: @key).result if @key.present?
    end
  end

  private

  def inode_params
    params.require(:inode).permit(:name, :inode_type, :parent_id, :content)
  end
end

