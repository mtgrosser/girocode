ENV["RAILS_ENV"] = "test"

require 'pathname'

require 'simplecov'
SimpleCov.start do
  if artifacts_dir = ENV['CC_BUILD_ARTIFACTS']
    coverage_dir Pathname.new(artifacts_dir).relative_path_from(Pathname.new(SimpleCov.root)).to_s
  end
  skip '/test/'
  skip 'vendor'
end

SimpleCov.at_exit do
  SimpleCov.result.format!
  if result = SimpleCov.result
    File.open(File.join(SimpleCov.coverage_path, 'coverage_percent.txt'), 'w') { |f| f << result.covered_percent.to_s }
  end
end

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'minitest/autorun'

require 'girocode'
