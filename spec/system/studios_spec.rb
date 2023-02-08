RSpec.describe 'Studio', type: :system do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user, open: true) }
  let!(:studio_user) { create(:studio_user, lottely: 100 ) }
  let(:admin_user) { create(:user, admin: true) }

  describe "応募" do
    before do
      sign_in user
      visit "/users/#{user.id}/entry"
    end

    it "応募した時間が応募状況に反映されること" do
      check 'studio40'
      click_on '応募する'
      visit studios_path
      within(".fri7") do
        expect(page).to have_content user.name
      end
    end

    it "応募した時間が抽選結果に反映されること" do
      check 'studio40'
      click_on '応募する'
      visit studios_election_path
      within(".fri7") do
        expect(page).to have_content user.name
      end
    end
  end

  describe "当選" do
    before do
      sign_in user
      visit studios_election_path
    end
    describe "応募ユーザーの表示" do
      context "ユーザーの降順表示" do
        it "studio_userのnameが初めに表示されること" do
          within(".band0") do
            expect(page).to have_content studio_user.user.name
          end
        end
      end
      context "当選ユーザーの表示" do
        it "当選ユーザーがピンク色で表示されること" do
          within(".band0") do
            expect(page).to have_css ('.election')
          end
        end
        it "非当選ユーザーがピンク色で表示されないこと" do
          within(".band1") do
            expect(page).not_to have_css ('.election')
          end
        end
      end
    end
  end

  describe "管理者権限" do
    describe "抽選結果画面の公開、非公開、リセットボタンの表示" do
      context "管理者権限があるユーザー" do
        before do
          sign_in admin_user
          visit studios_election_path
        end

        it "公開ボタンが表示されること" do
          expect(page).to have_content "公開"
        end

        it "非公開ボタンが表示されること" do
          expect(page).to have_content "非公開"
        end

        it "リセットボタンが表示されること" do
          expect(page).to have_content "リセット"
        end
      end
      context "管理者権限がないユーザー" do
        before do
          sign_in user
          visit studios_election_path
        end

        it "公開ボタンが表示されないこと" do
          expect(page).not_to have_content "公開"
        end

        it "非公開ボタンが表示されないこと" do
          expect(page).not_to have_content "非公開"
        end

        it "リセットボタンが表示されないこと" do
          expect(page).not_to have_content "リセット"
        end
      end
    end
    describe "抽選結果画面のリセットボタン機能" do
      before do
        sign_in admin_user
        visit studios_election_path
        click_on 'リセット'
        expect(page.accept_confirm).to eq "リセットしますか？"
      end

      context "抽選結果画面" do
        it "リセットボタンクリック時、応募されたスケジュールが削除されること" do
          expect(page).not_to have_content another_user.name
        end
      end

      context "応募状況画面" do
        it "リセットボタンクリック時、応募されたスケジュールが削除されること" do
          visit studios_path
          expect(page).not_to have_content another_user.name
        end
      end
    end

    describe "抽選結果画面の公開、非公開ボタン機能" do
      before do
        sign_in admin_user
        visit studios_election_path
      end

      context "公開ボタン" do
        it "公開ボタンクリック時、studios_open_pathに遷移すること" do
          click_on '公開'
          expect(current_path).to eq studios_open_path
        end

        it "studios_open_pathで、userのopenがtrueになること" do
          visit studios_open_path
          expect(user.reload.open).to eq true
        end
      end

      context "非公開ボタン" do
        it "非公開ボタンクリック時、studios_close_pathに遷移すること" do
          click_on '非公開'
          expect(current_path).to eq studios_close_path
        end

        it "studios_close_pathで、another_userのopenがfalseになること" do
          visit studios_close_path
          expect(another_user.reload.open).to eq false
        end
      end
    end
  end
end
