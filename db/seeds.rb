['admin', 'user'].each do |role|
  Role.create!(name: role)
end
Role.first.users.create(first_name: 'Admin', last_name: 'Admin', email: 'admin@gmail.com', password: 'password', password_confirmation: 'password', auth_token: "khasgdiyttvshd")
