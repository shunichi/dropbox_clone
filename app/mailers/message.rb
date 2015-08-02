class Message < ApplicationMailer
  def shared_link(share)
    @share = share
    mail to: @share.email, subject: 'shared_link'
  end
end
