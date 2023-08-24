# frozen_string_literal: true

require_relative 'time_format'

class App
  def call(env)
    req = Rack::Request.new(env)
    @params = req.params['format']
    if @params.nil?
      status
    else
      @format = TimeFormat.new(@params)
      @format.checking_params
      @body = @format.result
    end
    [status, {}, body]
  end

  private

  def status
    if @params.nil? || @format.invalid_parameters.any? || @format.correct_parameters.empty?
      400
    else
      200
    end
  end

  def body
    [@body.to_s]
  end
end
