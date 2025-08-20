class TimeController < ApplicationController
  def current_time
    render json: { current_time: Time.now.in_time_zone("Africa/Niamey").strftime('%Y-%m-%d %H:%M:%S') }
  end
end
