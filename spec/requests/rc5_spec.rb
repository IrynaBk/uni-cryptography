require 'rails_helper'

RSpec.describe "Rc5s", type: :request do
  describe "GET /encrypt" do
    it "returns http success" do
      get "/rc5/encrypt"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /decrypt" do
    it "returns http success" do
      get "/rc5/decrypt"
      expect(response).to have_http_status(:success)
    end
  end

end
