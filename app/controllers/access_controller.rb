class AccessController < ApplicationController
    before_action :set_link

    # GET /l/:slug
    def show
        return render_error(:not_found) unless @link
        if @link.is_a?(PrivateLink)
            render :private
        elsif @link.allow_access?
            log_and_go
        else
            status = @link.is_a?(EphemeralLink) ? :forbidden : :not_found
            render_error(status)
        end
    end

    # GET /l/:slug/private
    def private
    end

    # POST /l/:slug/private
    def authorize
        if @link.allow_access?(params[:password])
            log_and_go
        else
            redirect_to private_access_path(slug: @link.slug), notice: "Wrong password"
        end
    end
    
    private
    def set_link
        @link = Link.find_by(slug: params[:slug])
    end

    def log_and_go
        @link.access_logs.create!(ip_address: request.remote_ip, access_date: Time.now)
        redirect_to @link.url, allow_other_host: true
    end

    def render_error(status)
        @status_code = Rack::Utils.status_code(status)
        render "access/errors/#{@status_code}", status: status, layout: false
    end
end