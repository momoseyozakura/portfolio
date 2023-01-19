require 'rails_helper'
RSpec.describe "Studios", type: :request do
  let(:user) { create(:user) } 
  
  it "応募状況確認ページが取得できること" do
    get studios_path
    expect(response).to have_http_status "200"
  end

  it "当選確認ページが取得できること" do
    sign_in user
    get studios_election_path
    expect(response).to have_http_status "200"
  end

end
