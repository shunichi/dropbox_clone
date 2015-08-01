class SharesController < ApplicationController
  def show
    @share = Share.find(params[:id])
    if access_token = params[:access_token]
      session["share_#{@share.id}"] = access_token
      redirect_to share_inode_path(@share, @share.inode)
    end
  end
end