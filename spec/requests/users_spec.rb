require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) } 
  
  it "ログインページが取得できること" do
    get user_session_path
    expect(response).to have_http_status "200"
  end

  it "新規登録ページが取得できること" do
    get new_user_registration_path
    expect(response).to have_http_status "200"
  end

  it "プロフィールページが取得できること" do
    sign_in user
    get "/users/#{user.id}/show"
    expect(response).to have_http_status "200"
  end

  it "プロフィール編集ページが取得できること" do
    sign_in user
    get "/users/#{user.id}/edit"
    expect(response).to have_http_status "200"
  end

  it "スタジオ抽選ページが取得できること" do
    sign_in user
    get "/users/#{user.id}/entry"
    expect(response).to have_http_status "200"
  end
  
end
