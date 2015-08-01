class StaticAccessController < ApplicationController
  before_action :set_inode
  before_action :set_share
  before_action :check_permission

  def download
    disposition = params[:disposition] || 'inline'
    path = Rails.root.join('uploads', params[:id], "#{params[:basename]}.#{params[:extension]}")
    send_file path, disposition: disposition
  end

  private

  def set_share
    @share = Share.find(params[:share_id]) if params[:share_id]
  end
end
