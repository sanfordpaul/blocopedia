require 'rails_helper'

RSpec.describe "Collaborations", type: :request do
  describe "GET /collaborations" do
    it "works! (now write some real specs)" do
      get collaborations_path
      expect(response).to have_http_status(200)
    end
  end
end
