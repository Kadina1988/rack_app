class TimeFormat
  TIME_FORMATS = { 'year' => '%Y',
                   'month' => '%m',
                   'day' => '%d',
                   'hour' => '%H',
                   'minute' => '%M',
                   'second' => '%S'
                  }

  attr_reader :status

  def initialize(params)
    @params = params.split(',')
    @correct_parameters = []
    @invalid_parameters = []
    @status = nil
  end

  def checking_params
    @params.each do |param|
      if TIME_FORMATS.include?(param)
        @correct_parameters << param
      else
        @invalid_parameters << param
      end
    end
  end

  def result
    if @invalid_parameters.any?
      @status = 400
      return "Unknown time format #{@invalid_parameters}"
    else
      @status = 200
      @correct_parameters.map! { |param| TIME_FORMATS[param] }
      date = @correct_parameters.join('-')
      return Time.now.strftime(date)
    end
  end
end
