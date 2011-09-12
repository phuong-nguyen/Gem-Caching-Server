require 'spec_helper'
require File.expand_path("../../gem_fetcher", __FILE__)

describe GemFetcher do
  describe "version_list" do
    it "should return last 5 gems" do
      list = GemFetcher.version_list("cucumber")
      list.size.should == 5
      list.should include("1.0.4")
      list.should include("1.0.3")
    end
  end

  describe "download_gem" do
    context "such gem exists" do
      it "should return false" do
        `touch test_gems/cucumber-1.0.4.gem`
        GemFetcher.download_gem('cucumber', '1.0.4', 'test_gems').should be_false
      end

      after(:each) do
        `rm test_gems/cucumber-1.0.4.gem`
      end
    end

    context 'such gem does not exist' do
      before(:each) do
        `rm test_gems/cucumber-1.0.4.gem`
      end

      it "should download gem to the target folder" do
        GemFetcher.download_gem('cucumber', '1.0.4', 'test_gems').should be_true
        File.read("test_gems/cucumber-1.0.4.gem").length.should == File.read("org_gems/cucumber-1.0.4.gem").length
      end

      after(:each) do
        `rm test_gems/cucumber-1.0.4.gem`
      end
    end
  end
end
