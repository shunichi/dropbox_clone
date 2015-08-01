module PermissionHandlers
  extend ActiveSupport::Concern

  def check_permission
    return if user_signed_in? && current_user.accessible?(@inode)
    return if @share && (session[@share.session_key] == @share.access_token) && @share.inode.include?(@inode)
    render nothing: true, status: :forbidden
  end
end
