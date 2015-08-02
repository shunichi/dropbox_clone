class Message < ApplicationMailer
  def shared_link(share)
    @share = share
    @share_url = share_inode_url(@share, @share.inode, access_token: @share.access_token)
    mail to: @share.email, subject: 'shared_link'
  end
end
