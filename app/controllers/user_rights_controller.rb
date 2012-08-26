class UserRightsController < ApplicationController
  before_filter :ensure_logged_in
  before_filter :ensure_is_admin
  
  def index
    @rights_map = UserRight.all.inject({}) do |h, x|
      h[x[:rights_key]] ||= []
      h[x[:rights_key]] << "#{x.user.first_name} #{x.user.last_name}"
      h
    end
  end

  def delete_rights
    UserRight.destroy_all(["rights_key = ?", params[:key]])
  end
end