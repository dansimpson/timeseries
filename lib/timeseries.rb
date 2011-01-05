$:.unshift File.dirname(__FILE__)

require "rubygems"
require "cairo"

module TimeSeries
  Version = 0.1
end

require "core_ext/fixnum"
require "timeseries/sprite"
require "timeseries/time_series_sprite"
require "timeseries/text_sprite"
require "timeseries/grid"
require "timeseries/series"
require "timeseries/legend"
require "timeseries/timespan"
require "timeseries/chart"
require "timeseries/border"
require "timeseries/annotation"