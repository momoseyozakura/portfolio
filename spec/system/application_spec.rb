RSpec.describe 'Application', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user, open: true) }

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

  describe "ログイン後ヘッダー" do
    describe "ヘッダーメニュー" do
      context "抽選結果公開前" do
        before do
          sign_in user
          visit root_path
        end

        it "スタジオ抽選が表示されること" do
          within(".header-left") do
            expect(page).to have_content "スタジオ抽選"
          end
        end

        it "応募状況が表示されること" do
          within(".header-left") do
            expect(page).to have_content "応募状況"
          end
        end

        it "抽選結果が表示されないこと" do
          within(".header-left") do
            expect(page).not_to have_content "抽選結果"
          end
        end

        it "プロフィールクリック時、プロフィール画面に遷移すること" do
          within(".header-left") do
            click_on 'プロフィール'
            expect(current_path).to eq "/users/#{user.id}/show"
          end
        end

        it "プロフィール編集クリック時、プロフィール編集画面に遷移すること" do
          within(".header-left") do
            click_on 'プロフィール編集'
            expect(current_path).to eq "/users/#{user.id}/edit"
          end
        end

        it "スタジオ抽選クリック時、スタジオ抽選画面に遷移すること" do
          within(".header-left") do
            click_on 'スタジオ抽選'
            expect(current_path).to eq "/users/#{user.id}/entry"
          end
        end

        it "応募状況クリック時、応募状況画面に遷移すること" do
          within(".header-left") do
            click_on '応募状況'
            expect(current_path).to eq "/studios"
          end
        end

        it "DMクリック時、DM画面に遷移すること" do
          within(".header-left") do
            click_on 'DM'
            expect(current_path).to eq "/talk_rooms"
          end
        end

        it "ログアウトクリック時、ログアウトに成功すること" do
          within(".header-left") do
            click_on 'ログアウト'
          end
          expect(page).to have_content "ログイン"
        end
      end

      context "抽選結果公開後" do
        before do
          sign_in another_user
          visit root_path
        end

        it "スタジオ抽選が表示されないこと" do
          within(".header-left") do
            expect(page).not_to have_content "スタジオ抽選"
          end
        end

        it "応募状況が表示されないこと" do
          within(".header-left") do
            expect(page).not_to have_content "応募状況"
          end
        end

        it "抽選結果が表示されること" do
          within(".header-left") do
            expect(page).to have_content "抽選結果"
          end
        end

        it "抽選結果クリック時、抽選結果画面に遷移すること" do
          within(".header-left") do
            click_on '抽選結果'
            expect(current_path).to eq "/studios/election"
          end
        end
      end
    end

    describe "ハンバーガーメニュー" do
      context "抽選結果公開前" do
        before do
          sign_in user
          visit root_path
        end

        it "スタジオ抽選が表示されること" do
          within(".header-right") do
            expect(find('.nav', visible: false).text(:all)).to include "スタジオ抽選"
          end
        end

        it "応募状況が表示されること" do
          within(".header-right") do
            expect(find('.nav', visible: false).text(:all)).to include "応募状況"
          end
        end

        it "抽選結果が表示されないこと" do
          within(".header-right") do
            expect(find('.nav', visible: false).text(:all)).not_to include "抽選結果"
          end
        end

        it "プロフィールクリック時、プロフィール画面に遷移すること" do
          browser_size
          within(".header-right") do
            find('.nav_toggle').click
            click_on 'プロフィール'
            expect(current_path).to eq "/users/#{user.id}/show"
          end
        end

        it "プロフィール編集クリック時、プロフィール編集画面に遷移すること" do
          browser_size
          within(".header-right") do
            find('.nav_toggle').click
            click_on 'プロフィール編集'
            expect(current_path).to eq "/users/#{user.id}/edit"
          end
        end

        it "スタジオ抽選クリック時、スタジオ抽選画面に遷移すること" do
          browser_size
          within(".header-right") do
            find('.nav_toggle').click
            click_on 'スタジオ抽選'
            expect(current_path).to eq "/users/#{user.id}/entry"
          end
        end

        it "応募状況クリック時、応募状況画面に遷移すること" do
          browser_size
          within(".header-right") do
            find('.nav_toggle').click
            click_on '応募状況'
            expect(current_path).to eq "/studios"
          end
        end

        it "DMクリック時、DM画面に遷移すること" do
          browser_size
          within(".header-right") do
            find('.nav_toggle').click
            click_on 'DM'
            expect(current_path).to eq "/talk_rooms"
          end
        end

        it "ログアウトクリック時、ログアウトに成功すること" do
          browser_size
          within(".header-right") do
            find('.nav_toggle').click
            click_on 'ログアウト'
          end
          expect(page).to have_content "ログイン"
        end
      end

      context "抽選結果公開後" do
        before do
          sign_in another_user
          visit root_path
        end

        it "スタジオ抽選が表示されないこと" do
          within(".header-right") do
            expect(find('.nav', visible: false).text(:all)).not_to include "スタジオ抽選"
          end
        end

        it "応募状況が表示されないこと" do
          within(".header-right") do
            expect(find('.nav', visible: false).text(:all)).not_to include "応募状況"
          end
        end

        it "抽選結果が表示されること" do
          within(".header-right") do
            expect(find('.nav', visible: false).text(:all)).to include "抽選結果"
          end
        end

        it "抽選結果クリック時、抽選結果画面に遷移すること" do
          browser_size
          within(".header-right") do
            find('.nav_toggle').click
            click_on '抽選結果'
            expect(current_path).to eq "/studios/election"
          end
        end
      end
    end
  end
end
