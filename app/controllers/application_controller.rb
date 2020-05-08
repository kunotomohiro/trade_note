class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound,   with: :error_404
  rescue_from ActionController::RoutingError, with: :error_404
  rescue_from Exception,                      with: :error_500

  def after_sign_in_path_for(resource)
    user_trades_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  private

  def error_404(e)
    respond_to do |format|
      format.html { render file: 'public/404.html', layout: false, status: 404, content_type: 'text/html' }
      format.all { render nothing: true, status: 404 }
    end
  end

  def error_500(e)
    respond_to do |format|
      format.html { render file: 'public/500.html', layout: false, status: 500, content_type: 'text/html' }
      format.all { render nothing: true, status: 500 }
    end
  end

end
