require 'spec_helper'

describe Whirl do

  module Whirl::Job
    class FakeJob
      def self.perform(*); end
    end

    class Nope; end
  end

  describe '.jobs' do

    it "returns an array of all constants under Whirl::Job that respond to #perform, less Base" do
      Whirl.jobs.should == [Whirl::Job::FakeJob]
    end

  end

  describe '.run' do

    # Don't want Whirl to fork, keep spinning or have delays.
    #
    before do
      Whirl.stub(:fork) do |&block|
        block.call
      end
      Whirl.stub(:loop?).and_return(false)
      Whirl.stub(:whirl_interval).and_return(0)
    end

    it 'knows its jobs' do
      job_mock = mock
      job_mock.should_receive(:perform)

      Whirl.stub(:jobs).and_return [job_mock]
      Whirl.run
    end

    it 'runs each job' do
      class Whirl::Job::FakeAgain
        def perform(*); end
      end

      Whirl::Job::FakeJob.should_receive(:perform).once
      Whirl::Job::FakeAgain.should_receive(:perform).once

      Whirl.run
    end

  end

end
