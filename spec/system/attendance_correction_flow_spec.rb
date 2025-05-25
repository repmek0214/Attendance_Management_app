require 'rails_helper'


RSpec.describe '勤怠修正フロー', type: :system do
    let!(:employee) { create(:user, :employee, email: 'test_employee@example.com', password: 'password') }
    let!(:admin)    { create(:user, :admin,    email: 'test_admin@example.com',    password: 'password') }

  before do
    driven_by(:selenium_chrome_headless)
  end

  it '社員が修正申請し、管理者が承認するとホームに反映される' do
    # 社員ログイン
    visit new_user_session_path
    fill_in 'Email',    with: employee.email
    fill_in 'Password', with: 'password'
    click_button 'ログイン'

    # 勤怠打刻（初回）
    click_button '打刻する'
    expect(page).to have_content('出勤')

    # 修正申請ページへ
    click_link '勤怠修正申請する'
    select Date.current.strftime('%Y-%m-%d'), from: '修正対象日'
    select '9:00', from: '修正後 出勤時刻'
    select '18:00', from: '修正後 退勤時刻'
    fill_in '修正理由',            with: '遅刻したため'
    click_button '申請する'
    expect(page).to have_content('勤怠修正申請を送信しました')

    # ログアウト
    click_link 'ログアウト'
    Capybara.reset_sessions!
    save_and_open_page

    # 管理者ログイン
    visit new_user_session_path
    fill_in 'Email',    with: admin.email
    fill_in 'Password', with: 'password'
    click_button 'ログイン'

    expect(page).to have_content('ログイン中: test_admin@example.com')
    expect(page).to have_content('ロール: admin')

    # 管理画面で承認
    expect(page).to have_link('勤怠修正申請管理')
    click_link '勤怠修正申請管理'
    within 'table' do
      click_button '承認'
    end
    expect(page).to have_content('勤怠修正申請を更新しました')

    # ホームに戻り確認
    click_link '戻る'

    # ログアウト
    click_link 'ログアウト'
    Capybara.reset_sessions!

    # 社員ログイン
    visit new_user_session_path
    fill_in 'Email',    with: employee.email
    fill_in 'Password', with: 'password'
    click_button 'ログイン'

    # ホームに修正された勤怠が表示されていることを確認
    expect(page).to have_content('9:00')
    expect(page).to have_content('18:00')
    expect(page).to have_content('修正済みの打刻が適用されています')
  end
end