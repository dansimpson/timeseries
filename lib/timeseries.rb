$:.unshift File.dirname(__FILE__)

require "rubygems"
require "cairo"

module TimeSeries
  Version = 0.1
end

require "core_ext/fixnum"
require "timeseries/layer"
require "timeseries/text"
require "timeseries/grid"
require "timeseries/series"
require "timeseries/legend"
require "timeseries/timespan"
require "timeseries/chart"