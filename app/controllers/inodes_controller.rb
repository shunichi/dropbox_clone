class InodesController < InheritedResources::Base
  respond_to :html
  actions :index, :show, :create, :edit, :update, :destroy

  before_action :authenticate_user!
  before_action :set_inode, :check_permission, except: [:index, :new, :create]

  def index
    redirect_to current_user.inode
  end

  def new
    @inode = Inode.new(parent_id: params[:inode_id], inode_type: params[:inode_type])
  end

  def create
    create! { @inode.parent }
  end

  def destroy
    destroy! { @inode.parent }
  end

  def search
    @inodes = @inode.subtree.ransack(name_cont: @key).result if (@key = params[:key]) && @key.present?
  end

  def shares
  end

  private

  def inode_params
    params.require(:inode).permit(:name, :inode_type, :parent_id, :content)
  end
end

