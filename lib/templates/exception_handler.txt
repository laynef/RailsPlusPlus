module ExceptionHandler 
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_json({ error: e.message }, :not_found)
    end
    rescue_from ActiveRecord::RecordInvalid do |e|
      render_json({ error: e.message }, :unprocessable_entity)
    end
    rescue_from ActiveRecord::ActiveRecordError do |e|
      render_json({ error: e.message }, :bad_request)
    end
    rescue_from ActionController::InvalidAuthenticityToken do |e|
      render_json({ error: e.message }, :forbidden)
    end
  end

end
