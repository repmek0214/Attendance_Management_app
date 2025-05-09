User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = :admin
end

User.find_or_create_by!(email: 'employee@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.role = :employee
end
