require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザーを新規作成した場合' do
      it 'ユーザー情報が表示される' do
        visit new_user_path
        fill_in :user_user_name, with: '一般ユーザー'
        fill_in :user_email, with: 'general@ex.com'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_button "登録する"
        expect(page).to have_content '一般ユーザー'
      end
    end
    context 'ユーザーがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end
  describe 'セッション機能のテスト(一般ユーザー)' do
    before do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:second_user)
      visit new_session_path
      fill_in :session_email, with: 'general@ex.com'  #idへ変更
      fill_in :session_password, with: 'password'    #idへ変更
      click_button "ログイン" #click_on => click_buttonへ変更
    end
    context 'ユーザーがログインした場合' do
      it 'タスク一覧画面が見れるようになる' do
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content '一般ユーザーさんでログイン中'
      end
    end
    context 'ユーザー情報をクリックした場合' do
      it '自分の詳細画面(マイページ)に飛べる' do
        click_on "ユーザー情報"
        expect(page).to have_content '詳細'
        expect(page).to have_content '一般ユーザー'
        expect(page).to have_content 'general@ex.com'
      end
    end
    context '他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移' do
        visit user_path(@user2.id)
        expect(page).to have_content '違うユーザー情報は見れません'
      end
    end
    context '管理画面に飛んだ場合' do
      it 'タスク一覧画面に遷移' do
        visit admin_users_path
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトした場合' do
      it 'ログイン画面へ遷移' do
        click_on "ログアウト"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content 'ログイン'
      end
    end
  end
  describe '管理画面のテスト' do
    before do
      @user2 = FactoryBot.create(:second_user)
      visit new_session_path
      fill_in :session_email, with: 'admin@ex.com'
      fill_in :session_password, with: 'password'
      click_button "ログイン"
    end
    context '管理ユーザーがログインした場合' do
      it '管理画面にアクセスできること' do
        visit admin_users_path
        expect(page).to have_content 'ユーザー管理'
        expect(page).to have_content '管理ユーザーさんでログイン中'
      end
    end
    context '管理ユーザーが新規ユーザー登録した場合' do
      it 'ユーザーを登録できる' do
        visit new_admin_user_path
        fill_in :user_user_name, with: '一般ユーザー'
        fill_in :user_email, with: 'general@ex.com'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_button "登録する"
        visit admin_users_path
        expect(page).to have_content '一般ユーザー'
      end
    end
    context '管理ユーザーがユーザー詳細画面にアクセスした場合' do
      it '他人のユーザー情報をみれる' do
        user = FactoryBot.create(:user)
        visit user_path(user.id)
        expect(page).to have_content '詳細'
      end
    end
    context '管理ユーザーがユーザーを編集した場合' do
      it 'ユーザー情報が更新される' do
        user = FactoryBot.create(:user)
        visit edit_admin_user_path(user.id)
        fill_in :user_email, with: 'edit@ex.com'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_button "更新する"
        expect(page).to have_content 'edit@ex.com'
        expect(page).to have_content 'ユーザーを変更しました'
      end
    end
    context '管理ユーザーがユーザーを削除した場合' do
      it 'ユーザーが削除される' do
        user = FactoryBot.create(:user)
        visit user_path(user.id)
        click_link "削除"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザーを削除しました'
      end
    end
  end
end