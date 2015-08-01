class Shares::InodesController < ApplicationController
  before_action :set_inode
  before_action :set_share
  before_action :check_permission

  def show
  end

  private

  def set_share
    @share = Share.find(params[:share_id])
  end
end
