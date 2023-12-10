# app/controllers/concerns/linkable.rb
module Linkable
    extend ActiveSupport::Concern

    def set_link
        @link = Link.find_by(id: params[:id])
        if !user_signed_in?
            flash[:error] = "You need to sign in or sign up before continuing."
            redirect_to new_user_session_path
        elsif !authorized?(@link)
            flash[:error] = "You don't have access to this link."
            redirect_to links_path
        end
    end
    def authorized?(link)
        link && link.user_id == current_user.id
    end
end
