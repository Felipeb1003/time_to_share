class ApplicationController < ActionController::Base
    include ApplicationHelper
    def checked_log_in
        if !logged_in?
            flash[:message] = "Not Logged in!"
            redirect_to '/log_in'
        end
    end

    
end
