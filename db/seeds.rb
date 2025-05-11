
puts "シードデータを作成中..."

admin = User.find_or_create_by!(email: 'admin@example.com') do |u|
  u.password = 'password'
  u.role = :admin
end

employee = User.find_or_create_by!(email: 'employee@example.com') do |u|
  u.password = 'password'
  u.role = :employee
end

puts "ユーザー作成完了"

# 勤怠打刻データ（過去7日分）
(1..7).each do |i|
  date = Date.today - i
  employee.attendances.find_or_create_by!(date: date) do |a|
    a.clock_in = date.to_time.change(hour: 9)
    a.clock_out = date.to_time.change(hour: 18)
  end
end

puts "勤怠データ作成完了"

# 休暇申請データ
LeaveApplication.find_or_create_by!(
  user: employee,
  start_date: Date.today + 3,
  end_date: Date.today + 5,
  reason: "私用のため",
  status: :pending
)

puts "休暇申請作成完了"

# 経費申請データ
ExpenseApplication.find_or_create_by!(
  user: employee,
  date: Date.today - 2,
  amount: 3500,
  purpose: "書籍購入",
  status: :pending
)

puts "経費申請作成完了"

puts "すべてのシードデータを作成しました。"
