#!/usr/bin/env rake
require "bundler/gem_tasks"
require File.expand_path("../lib/whirl", __FILE__)

begin
  require 'rspec/core/rake_task'

  desc "Run all examples"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w[--color]
  end

  task :default => [:spec]
rescue LoadError; end
