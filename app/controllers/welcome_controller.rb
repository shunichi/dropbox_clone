class WelcomeController < ApplicationController
  before_action :check_current_status

  def index
  end

  private

  def check_current_status
    redirect_to current_user.inode if user_signed_in?
  end
end
