require 'rails_helper'

RSpec.describe "ShiftRequests", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/shift_requests/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/shift_requests/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/shift_requests/index"
      expect(response).to have_http_status(:success)
    end
  end

end
