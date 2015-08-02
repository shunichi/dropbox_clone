class SharesController < ApplicationController
  before_action :set_inode, :check_permission

  def create
    user = User.find_by(email: params[:email])
    if user
      user.follow(@inode)
      redirect_to inode_shares_path(@inode), notice: "add share for #{user.email}"
    else
      redirect_to inode_shares_path(@inode), notice: "can't find user"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.stop_following(@inode)
    redirect_to inode_shares_path(@inode), notice: "delete share for #{user.email}"
  end
end
