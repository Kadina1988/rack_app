require_relative 'time_format'

class App
  def call(env)
    req = Rack::Request.new(env)
    params = req.params['format']
    @format = TimeFormat.new(params)
    @format.checking_params
    @body = @format.result
    [status, {}, body]
  end

  private

  def status
    @format.status
  end

  def body
    ["#{@body}"]
  end
end
