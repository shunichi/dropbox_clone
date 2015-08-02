class Shares::InodesController < ApplicationController
  before_action :set_share
  before_action :set_inode
  before_action :set_access_token
  before_action :check_permission

  def show
  end

  private

  def set_share
    @share = Share.find(params[:share_id])
  end

  def set_access_token
    if access_token = params[:access_token]
      session[@share.session_key] = access_token
    end
  end
end
