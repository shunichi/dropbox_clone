class ShareLinksController < ApplicationController
  before_action :set_inode, :check_permission

  def create
    share = @inode.shares.create!(email: params[:email])
    Message.shared_link(share).deliver
    redirect_to inode_shares_path(@inode)
  end

  def destroy
    share = @inode.shares.find(params[:id])
    share.destroy!
    redirect_to inode_shares_path(@inode)
  end
end
