class UserRightsController < ApplicationController
  before_filter :ensure_is_admin
  before_filter :ensure_logged_in

  def delete_rights
    UserRight.destroy_all(["rights_key = ?", params[:key]])
  end
  
  def index
    @rights_map = UserRight.all.inject({}) do |h, x|
      h[x[:rights_key]] ||= []
      h[x[:rights_key]] << "#{x.user.first_name} #{x.user.last_name}"
      h
    end
  end
end