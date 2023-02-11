RSpec.describe 'TalkRoom', type: :system do
  let(:no_message_user) { create(:user) }
  let(:message_user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:talk_room) { create(:talk_room, id:1 ) }
  let!(:room_user) { create(:room_user, user_id: message_user.id, talk_room_id: talk_room.id) }
  let!(:another_room_user) { create(:room_user, user_id: another_user.id, talk_room_id: talk_room.id) }
  let!(:message) { create(:message, user_id: message_user.id, talk_room_id: 1) }
  let!(:another_message) { create(:message, user_id: another_user.id, talk_room_id: 1) }

  
  describe "初めてDM画面へ移行するユーザー" do
    context "プロフィール画面" do
      before do
        sign_in no_message_user
        visit "/users/#{another_user.id}/show"
      end

      it "メッセージを送ると表示されること" do
        expect(page).to have_button "メッセージを送る"
      end

      it "メッセージを送るをクリック時、talk_roomが作られ遷移すること" do
        click_on 'メッセージを送る'
        within(".chat-room") do
          expect(page).to have_content another_user.name
        end
      end
    end
  end

  describe "DM画面へ移行したことがあるユーザー" do
    before do
      sign_in message_user
    end

    context "プロフィール画面" do
      it "プロフィール画面にDMと表示されること" do
        visit "/users/#{another_user.id}/show"
        within(".profile-container") do
          expect(page).to have_link "DM"
        end
      end
    end

    context "talk_room" do
      before do
        visit "talk_rooms/#{talk_room.id}"
      end

      context "タイトル" do
        it "タイトルに相手ユーザー名が表示されること" do
          within(".chat-room") do
            expect(page).to have_content another_user.name
          end
        end
      end

      context "メッセージ" do
        context "メッセージの送信" do
          it "メッセージを送信できること" do
            fill_in 'メッセージを入力してください', with: 'test'
            click_on '送信する'
            expect(page).to have_content "test"
          end
        end

        context "メッセージの表示" do
          context "自分のメッセージの表示" do
            it "アイコンが表示されること" do
              within(".chat") do
                expect(page).to have_css ('.chat-icon-image')
              end
            end

            it "自分のユーザー名が表示されること" do
              within(".chat") do
                expect(page).to have_content message_user.name
              end
            end

            it "自分のメッセージが表示されること" do
              within(".chat") do
                expect(page).to have_content message.body
              end
            end

            it "自分のメッセージの作成日時が表示されること" do
              within(".chat") do
                expect(page).to have_content message.created_at.to_s(:datetime_jp)
              end
            end
          end

          context "相手のメッセージの表示" do
            it "アイコンが表示されること" do
              within(".chat") do
                expect(page).to have_css ('.chat-icon-image')
              end
            end

            it "相手のユーザー名が表示されること" do
              within(".chat") do
                expect(page).to have_content another_user.name
              end
            end

            it "相手のメッセージが表示されること" do
              within(".chat") do
                expect(page).to have_content another_message.body
              end
            end

            it "相手のメッセージの作成日時が表示されること" do
              within(".chat") do
                expect(page).to have_content another_message.created_at.to_s(:datetime_jp)
              end
            end
          end
        end
      end
    end
    describe "DM一覧画面" do
      before do
        sign_in message_user
        visit "/talk_rooms"
      end

      context "talk_roomの表示" do
        it "talk_roomの相手ユーザーが表示されること" do
          expect(page).to have_content another_user.name
        end
        
        it "最も新しいメッセージが表示されること" do
          expect(page).to have_content another_message.body
        end

        it "最も新しいメッセージの時間が表示されること" do
          expect(page).to have_content another_user.created_at.to_s(:datetime_jp)
        end

        it "新しくないメッセージが表示されないこと" do
          expect(page).not_to have_content message.body
        end
      end
    end
  end
end
