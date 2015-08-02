class InodesController < InheritedResources::Base
  respond_to :html
  actions :index, :show, :create, :edit, :update, :destroy

  before_action :authenticate_user!
  before_action :set_inode, :check_permission, except: [:index, :new, :create]
  before_action :set_mode, only: [:edit]
  before_action :set_sort_key, only: [:show]

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
    params.require(:inode).permit(:name, :inode_type, :parent_id, :content, :original_inode_id)
  end

  def set_mode
    @mode = params[:mode]
  end

  def set_sort_key
    @sort_key = params[:sort]
  end
end

