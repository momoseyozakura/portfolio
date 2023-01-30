RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }
  let(:another_user) {create(:user)}

  def upload_user_avatar(user)
    sign_in user
    visit edit_user_path(user)
    attach_file 'user_avatar', "#{Rails.root}/spec/fixtures/images/test.jpg"
    click_on '保存する'
  end

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      before do
        visit new_user_registration_path
      end
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功すること' do
          fill_in 'バンド名', with: 'user_1'
          fill_in 'メンバー', with: 'member'
          fill_in 'メールアドレス', with: 'user_1@example.com'
          fill_in 'パスワード', with: 'password'
          click_button '新規登録'
          expect(current_path).to eq root_path
        end
      end
      context 'バンド名が未入力'  do
        it 'ユーザーの新規作成が失敗すること' do
          fill_in 'バンド名', with: ''
          fill_in 'メンバー', with: 'member'
          fill_in 'メールアドレス', with: 'user_1@example.com'
          fill_in 'パスワード', with: 'password'
          click_button '新規登録'
          expect(page).to have_content  "バンド名を入力してください"
        end
      end
      context 'メンバーが未入力'  do
        it 'ユーザーの新規作成が失敗すること' do
          fill_in 'バンド名', with: 'user'
          fill_in 'メンバー', with: ''
          fill_in 'メールアドレス', with: 'user_1@example.com'
          fill_in 'パスワード', with: 'password'
          click_button '新規登録'
          expect(page).to have_content  "メンバーを入力してください"
        end
      end
      context 'メールアドレスが未入力'  do
        it 'ユーザーの新規作成が失敗すること' do
          fill_in 'バンド名', with: 'user'
          fill_in 'メンバー', with: 'member'
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          click_button '新規登録'
          expect(page).to have_content  "メールアドレスを入力してください"
        end
      end
      context 'パスワードが未入力'  do
        it 'ユーザーの新規作成が失敗すること' do
          fill_in 'バンド名', with: 'user'
          fill_in 'メンバー', with: 'member'
          fill_in 'メールアドレス', with: 'user_1@example.com'
          fill_in 'パスワード', with: ''
          click_button '新規登録'
          expect(page).to have_content  "パスワードを入力してください"
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗すること' do
          fill_in 'バンド名', with: 'user_1'
          fill_in 'メンバー', with: 'member'
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          click_button '新規登録'
          expect(page).to have_content  'このメールアドレスは使用できません'
        end
      end
      context 'ログインはこちらをクリック' do
        it 'ログインページに遷移すること' do
          click_on 'ログインはこちら'
          expect(current_path).to eq user_session_path
        end
      end
    end
    describe 'ログイン' do
      before do
        visit user_session_path
      end
      context 'フォームの入力値が正常' do
        it 'ログインが成功すること' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
          expect(current_path).to eq root_path
        end
        context 'メールアドレスが未入力' do
          it 'ログインが失敗すること' do
            fill_in 'メールアドレス', with: ''
            fill_in 'パスワード', with: user.password
            click_button 'ログイン'
            expect(page).to have_content  'メールアドレス もしくはパスワードが不正です。'
          end
        end
        context 'メールアドレスが異なる' do
          it 'ログインが失敗すること' do
            fill_in 'メールアドレス', with: another_user.email
            fill_in 'パスワード', with: user.password
            click_button 'ログイン'
            expect(page).to have_content  'メールアドレス もしくはパスワードが不正です。'
          end
        end
        context 'パスワードが未入力' do
          it 'ログインが失敗すること' do
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: ''
            click_button 'ログイン'
            expect(page).to have_content  'メールアドレス もしくはパスワードが不正です。'
          end
        end
        context 'パスワードが異なる' do
          it 'ログインが失敗すること' do
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: another_user.password
            click_button 'ログイン'
            expect(page).to have_content  'メールアドレス もしくはパスワードが不正です。'
          end
        end
        context '新規登録はこちらをクリック' do
          it '新規登録ページに遷移すること' do
            click_on '新規登録はこちら'
            expect(current_path).to eq new_user_registration_path
          end
        end
      end
    end
  end
  describe 'ログイン後' do
    before do
      sign_in user
    end
    describe 'ログイン後ヘッダー' do
      context 'ヘッダーのユーザー表示' do
        it 'ログインユーザー名が表示される' do
          visit root_path
          expect(page).to have_content user.name
        end
      end
      describe 'ヘッダーのユーザーアイコン表示' do
        context 'アイコンが未登録' do
          it 'デフォルトアイコンが表示される' do
            visit root_path
            expect(page).to have_selector("img[src$='https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png']")
          end
        end
        context 'アイコン登録済み' do
          it '登録されたアイコンが表示される' do
            visit "/users/#{user.id}/edit"
            attach_file 'image', "#{Rails.root}/spec/fixtures/icon.jpg"
            click_on '更新'
            expect(page).to have_selector("img[src$='#{user.id}.jpg']")
          end
        end
      end
      describe 'プロフィール表示' do
        before do
          visit "/users/#{user.id}/show"
        end
        describe 'アイコン画像表示' do
          context 'アイコン画像が未登録' do
            it 'デフォルトアイコンが表示される' do
              within(".profile-container") do
                expect(page).to have_selector("img[src$='https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png']")
              end
            end
          end
          context 'アイコン画像が登録済み' do
            it '登録されたアイコンが表示されること' do
              visit "/users/#{user.id}/edit"
              attach_file 'image', "#{Rails.root}/spec/fixtures/icon.jpg"
              click_on '更新'
              visit "/users/#{user.id}/show"
              within(".profile-container") do
                expect(page).to have_selector("img[src$='#{user.id}.jpg']")
              end
            end
          end
        end
        describe 'バンド名表示' do
          it 'バンド名が表示されること' do
            within(".profile-container") do
              expect(page).to have_content user.name
            end
          end
        end
        describe 'メンバー表示' do
          it 'メンバーが表示されること' do
            within(".profile-container") do
              expect(page).to have_content user.member
            end
          end
        end
      end
      describe 'プロフィール編集' do
        before do
          visit "/users/#{user.id}/edit"
        end
        context 'バンド名変更' do
          it 'バンド名の変更が適応される' do
            fill_in 'name', with: 'test'
            click_on '更新'
            expect(page).to have_content 'test'
          end
          it 'メンバーの変更が適応される' do
            fill_in 'member', with: 'test'
            click_on '更新'
            visit "/users/#{user.id}/show"
            expect(page).to have_content 'test'
          end
        end
      end
    end
  end
end
