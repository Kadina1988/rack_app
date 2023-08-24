# frozen_string_literal: true

class TimeFormat
  FORMAT = { 'year' => '%Y',
             'month' => '%m',
             'day' => '%d',
             'hour' => '%H',
             'minute' => '%M',
             'second' => '%S' }.freeze

  attr_reader :invalid_parameters, :correct_parameters

  def initialize(params)
    @params = params.split(',')
    @correct_parameters = []
    @invalid_parameters = []
  end

  def checking_params
    @params.each do |param|
      if FORMAT.include?(param)
        @correct_parameters << param
      else
        @invalid_parameters << param
      end
    end
  end

  def result
    if @invalid_parameters.any?
      "Unknown time format #{@invalid_parameters}"
    else
      @correct_parameters.map! { |param| FORMAT[param] }
      date = @correct_parameters.join('-')
      Time.now.strftime(date)
    end
  end
end
