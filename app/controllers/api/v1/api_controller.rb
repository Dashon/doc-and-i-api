class Api::ApiController < ActionController::Base
  #before_action :authenticate
  before_action :authenticate_manual
  #before_action :validate_rpm
  before_action :check_pageination, only: [:index, :prefix]
  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(api_token: token).first
    end
  end

  # NOTE: For ref
  # Manual way of authenticate request
  def authenticate_manual
    api_token = request.headers['X-Api-Key']
    @user = User.where(api_token: api_token).first if api_token

    unless @user
      head status: :unauthorized
      return false
    end
  end


  # Check request per min
  # You can add field to user table request per min or define constant.
  # Here I am just passsing some random value
  def validate_rpm
    if ApiRpmStore.threshold?(@user.id, @user.api_rpm) # 10 request per min
      render json: { help: 'www.docandi.com' }, status: :too_many_requests
      return false
    end
  end

  def check_pageination
    params[:page] = 1 if params[:page].nil?
  end


  def set_pagination_header(name, options = {})
    scope = instance_variable_get("@#{name}")
    if !scope.nil?
      request_params = request.query_parameters
      url_without_params = request.original_url.slice(0..(request.original_url.index("?")-1)) unless request_params.empty?
      url_without_params ||= request.original_url

      page = {}
      page[:first] = 1 if scope.total_pages > 1 && !scope.first_page?
      page[:last] = scope.total_pages  if scope.total_pages > 1 && !scope.last_page?
      page[:next] = scope.current_page + 1 unless scope.last_page?
      page[:prev] = scope.current_page - 1 unless scope.first_page?

      pagination_links = []
      page.each do |k, v|
        new_request_hash= request_params.merge({:page => v})
        pagination_links << "<#{url_without_params}?#{new_request_hash.to_param}>; rel=\"#{k}\""
      end
      headers["Link"] = pagination_links.join(", ")
      headers["Total_pages"] = scope.total_pages
      headers["Current_page"] = scope.current_page
    end
  end
end