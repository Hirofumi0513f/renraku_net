# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Staff.create!(
#   last_name: '福田',
#   first_name: '泰史',
#   last_name_kana: 'フクダ',
#   first_name_kana: 'ヒロフミ',
#   telephone_number: '050-0000-1111',
#   email: 'hirofumi.fukuda@renrakunet.com',
#   password: '19930513',
#   work_style: 1,
#   is_admin: true
# )

staffs = [
  {
    last_name: '福田',
    first_name: '泰史',
    last_name_kana: 'フクダ',
    first_name_kana: 'ヒロフミ',
    telephone_number: '050-0000-1111',
    email: 'hirofumi.fukuda@renrakunet.com',
    password: '19930513',
    work_style: 1,
    is_admin: true
  },
]

staffs.each do |staff|
  staff_data = Staff.find_by(email: staff[:email])
  if staff_data.nil?
    Staff.create(
        last_name: staff[:last_name],
        first_name: staff[:first_name],
        last_name_kana: staff[:last_name_kana],
        first_name_kana: staff[:first_name_kana],
        telephone_number: staff[:telephone_number],
        email: staff[:email],
        password: staff[:password],
        work_style: staff[:work_style],
        is_admin: staff[:is_admin]
      )
  end
end

positions = [
  {email: 'hirofumi.fukuda@renrakunet.com', name: '社員' },
]
positions.each do |position|
  staff = Staff.find_by(email: position[:email])
  Position.find_or_create_by(staff_id: staff.id, name: position[:name])
end

  # Position.create!(
  #   staff_id: 1,
  #   name: "社員")

  # Department.create!(
  #   staff_id: 1,
  #   name: "販売推進部")

departments = [
  {email: 'hirofumi.fukuda@renrakunet.com', name: '販売推進部' },
  {email: 'hirofumi.fukuda2@renrakunet.com', name: '販売推進部' },
]
departments.each do |department|
  staff = Staff.find_by(email: department[:email])
  Department.find_or_create_by(staff_id: staff.id, name: department[:name])
end

  # Division.create!(
  #   department_id: 1,
  #   name: "第二販売支援課")

divisions = [
  {email: 'hirofumi.fukuda@renrakunet.com', name: '第二販売支援課' },
]
divisions.each do |division|
  staff = Department.find_by(email: division[:department])
  Division.find_or_create_by(department_id: department.id, name: division[:name])
end