class ApplicationController < ActionController::API
  rescue_from Date::Error, ApiErrors::InvalidDateError do |e|
    render json: {error: "Invalid date format. Please use YYYY-MM-DD and ensure the date is not in the future"}, status: :bad_request
  end

  rescue_from ApiErrors::NoDataAvailableError do |e|
    render json: {error: "No data available for this date"}, status: :not_found
  end

  private

  def parse_and_validate_date
    date = Date.parse(params[:date])
    raise ApiErrors::InvalidDateError if date > Date.today
    date
  rescue Date::Error
    raise ApiErrors::InvalidDateError
  end
end
