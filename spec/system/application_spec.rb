RSpec.describe 'Application', type: :system do
  let(:user) { create(:user) }
  
  describe 'ログイン前ヘッダー' do
    before do
      visit root_path
    end
    context '新規登録をクリック' do
      it '新規登録ページに遷移すること' do
        click_on '新規登録'
        expect(current_path).to eq new_user_registration_path
      end
    end
    context 'ログインをクリック' do
      it 'ログインページに遷移すること' do
        click_on 'ログイン'
        expect(current_path).to eq user_session_path
      end
    end
    context 'ロゴをクリック' do
      it 'トップページに遷移すること' do
        visit studios_path
          within(".header-container") do
            click_on 'studio schedule'
          end
        expect(current_path).to eq root_path
      end
    end
  end
end