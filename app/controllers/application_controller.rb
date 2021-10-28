class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, :with => :render_record_not_found

  def render_record_not_found
    render(json: { error: 'Record not found' }, status: :not_found)
  end
end
