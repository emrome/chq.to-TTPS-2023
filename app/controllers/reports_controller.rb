class ReportsController < ApplicationController
    include Linkable

    before_action :set_link
    before_action :authenticate_user!

    # GET /reports/:id/access_logs
    def access_logs
        @access_logs = @link.access_logs.page(params[:page]).order(access_date: :desc)
        filter_logs
    end

    # GET /reports/:id/access_count
    def date_count
        @access_counts = @link.access_logs.group_by_day(:access_date).count
    end

    private
    def filter_logs
        @access_logs = @access_logs.filter_by_ip_address(params[:ip_address]) if params[:ip_address].present?
        @access_logs = @access_logs.filter_by_start_date(params[:start_date].to_datetime) if params[:start_date].present?
        @access_logs = @access_logs.filter_by_end_date(params[:end_date].to_datetime.end_of_day) if params[:end_date].present?
    
    end
end
