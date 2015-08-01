class Shares::InodesController < ApplicationController
  before_action :set_share
  before_action :check_access_token
  before_action :set_inode

  def show
  end

  private

  def set_share
    @share = Share.find(params[:share_id])
  end

  def check_access_token
    if @share.access_token != session["share_#{@share.id}"]
      redirect_to @share
    end
  end

  def set_inode
    @inode = Inode.find(params[:id])
  end
end
