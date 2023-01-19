require 'rails_helper'
RSpec.describe "TalkRooms", type: :request do
  let(:user) { create(:user) } 
  let(:another_user) { create(:user) } 
  let(:talk_room) { create(:talk_room) }
  
  it "DM一覧ページが取得できること" do
    sign_in user
    get talk_rooms_path
    expect(response).to have_http_status "200"
  end

  it "DMページが取得できること" do
    sign_in user
    get talk_rooms_path
    expect(response).to have_http_status "200"
  end

end
