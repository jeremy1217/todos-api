module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches 'StandardErrors'
  class AuthenticationError < StandardErrors; end
  class MissingToken < StandardErrors; end
  class InvalidToken < StandardErrors; end

  Included do
  	rescue_from ActiveRecord::RecordNotFound, with: :four_twenty_two
  	rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
  	rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
  	rescue_from	ExceptionHandler::InvalidToken, with: :four_twenty_two

  	rescue_from ActiveRecord::RecordNotFound do |e|
  		json_response({ message: e.message }, :not_found)
  	end

  	rescue_from ActiveRecord::RecordInvalid do |e|
  		json_response({ message: e.message }, :unprocessable_entity)
  	end
  end

  private

  def four_twenty_two(e)
  	json_response({ message: e.message }, :unprocessable_entity)
  end

  def unauthorized_request9e)
  	json_response({ message: e.message }, :unauthorized)
  end
end