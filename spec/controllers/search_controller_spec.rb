require 'spec_helper'

describe SearchController do

  describe "GET 'video'" do
    it "returns http success" do
      get 'video'
      expect(response).to be_success
    end
  end

end
