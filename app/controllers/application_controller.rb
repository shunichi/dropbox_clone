class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include PermissionHandlers

  protected

  def set_inode
    @inode = Inode.find(params[:id])
  end
end
