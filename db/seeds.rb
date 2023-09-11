# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#求人部門ダミーデータ作成
# 1
technology_development_operations = Department.create(name: "技術開発本部")
# 2
monitoring_technology_development_division = technology_development_operations.children.create(name: "生体モニタ技術開発部")
# 3
medical_instruments_technology_development_division = technology_development_operations.children.create(name: "医療機器技術開発部")
# 4
vital_sensor_technology_development_division = technology_development_operations.children.create(name: "バイタルセンサ技術開発部")
# 5
ivd_technology_development_division = technology_development_operations.children.create(name: "IVD技術開発部")
# 6
digital_health_solution_technology_development_division = technology_development_operations.children.create(name: "DHS技術開発部")
# 7
it_solution_technology_development_division = technology_development_operations.children.create(name: "ITソリューション技術開発部")
# 8
systems_technology_development_department_1 = it_solution_technology_development_division.children.create(name: "第一システム技術部")
# 9
stdd1_section_1 = systems_technology_development_department_1.children.create(name: "一課")
# 10
stdd1_section_2 = systems_technology_development_department_1.children.create(name: "二課")
# 11
stdd1_section_3 = systems_technology_development_department_1.children.create(name: "三課")
# 12
vp_development_team = systems_technology_development_department_1.children.create(name: "VP開発チーム")
# 13
systems_technology_development_department_2 = it_solution_technology_development_division.children.create(name: "第二システム技術部")
# 14
stdd2_section_1 = systems_technology_development_department_2.children.create(name: "一課")
# 15
stdd2_section_2 = systems_technology_development_department_2.children.create(name: "二課")
# 16
stdd2_section_3 = systems_technology_development_department_2.children.create(name: "三課")
# 17
stdd2_section_4 = systems_technology_development_department_2.children.create(name: "四課")
# 18
stdd2_section_5 = systems_technology_development_department_2.children.create(name: "五課")
# 19
stdd2_section_6 = systems_technology_development_department_2.children.create(name: "六課")
# 20
stdd2_section_7 = systems_technology_development_department_2.children.create(name: "七課")
# 21
internal_auditing_department = Department.create(name: "内部監査室")
# 22
iad_domestic_team = internal_auditing_department.children.create(name: "国内チーム")
# 23
iad_international_team = internal_auditing_department.children.create(name: "海外チーム")
# 24
iad_jsox_team = internal_auditing_department.children.create(name: "J-SOXチーム")
# 25
corporate_strategy_division = Department.create(name: "経営戦略統括部")
# 26
csv_corporate_planning_department = corporate_strategy_division.children.create(name: "経営企画部")
# 27
csv_corporate_planning_department.children.create(name: "経営企画チーム")
# 28
csv_corporate_planning_department.children.create(name: "サステナビリティ推進チーム")
# 29
csv_investor_relation_group = corporate_strategy_division.children.create(name: "IRグループ")
# 30
csv_investor_relation_group.children.create(name: "IRチーム")
# 31
csv_corporate_strategy_department = corporate_strategy_division.children.create(name: "経営戦略部")
# 32
csv_corporate_strategy_department.children.create(name: "経営戦略チーム")
# 33
csv_corporate_strategy_department.children.create(name: "事業開発チーム")

# 勤務地ダミーデータ作成
prefectures = [
  "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
  "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
  "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県",
  "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県",
  "鳥取県", "島根県", "岡山県", "広島県", "山口県",
  "徳島県", "香川県", "愛媛県", "高知県",
  "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
]

prefectures.each do |name|
  WorkLocation.find_or_create_by(name: name)
end

# 役職ダミーデータ作成
positions = [
  "役員", "上級職", "一般社員", "その他"
]

positions.each do |name|
  Position.find_or_create_by(name: name)
end

# 職種ダミーデータ作成
categories = [
  "営業系", "サービス系", "技術系", "事務系"
]

categories.each do |name|
  Category.find_or_create_by(name: name)
end

# 求人部門担当者ダミーデータ作成(11名分)
20.times do |n|
  Recruiter.create(
    username: "recruiter#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: "password"
  )
end

# 求人担当者プロファイルダミーデータ作成(21名分）
# 技術開発本部/ITソリューション技術開発部/第一システム技術部/一課: id: 9, 上級職
RecruiterProfile.create(
  recruiter_id: 1,
  department_id: 9,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)
# 技術開発本部/ITソリューション技術開発部/第一システム技術部/一課: id: 9, 一般社員
RecruiterProfile.create(
  recruiter_id: 2,
  department_id: 9,
  position_id: 3,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)
# 技術開発本部/ITソリューション技術開発部/第一システム技術部/二課: id: 10, 一般社員
RecruiterProfile.create(
  recruiter_id: 3,
  department_id: 10,
  position_id: 3,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/一課: id: 14, 上級職
RecruiterProfile.create(
  recruiter_id: 4,
  department_id: 14,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/一課: id: 14, 一般社員
RecruiterProfile.create(
  recruiter_id: 5,
  department_id: 14,
  position_id: 3,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/二課: id: 15, 一般社員
RecruiterProfile.create(
  recruiter_id: 6,
  department_id: 15,
  position_id: 3,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部 id: 8, 上級職
RecruiterProfile.create(
  recruiter_id: 7,
  department_id: 8,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部 id: 13, 上級職
RecruiterProfile.create(
  recruiter_id: 8,
  department_id: 13,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

# 技術開発本部/ITソリューション技術開発部 id: 7, 上級職
RecruiterProfile.create(
  recruiter_id: 9,
  department_id: 7,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

# 内部監査室 id: 21, 上級職
RecruiterProfile.create(
  recruiter_id: 10,
  department_id: 21,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

# 内部監査室/海外チーム id: 23, 一般社員
RecruiterProfile.create(
  recruiter_id: 11,
  department_id: 23,
  position_id: 3,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

RecruiterProfile.create(
  recruiter_id: 12,
  department_id: 25,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

RecruiterProfile.create(
  recruiter_id: 13,
  department_id: 26,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

RecruiterProfile.create(
  recruiter_id: 14,
  department_id: 27,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

RecruiterProfile.create(
  recruiter_id: 15,
  department_id: 28,
  position_id: 3,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

RecruiterProfile.create(
  recruiter_id: 16,
  department_id: 29,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

RecruiterProfile.create(
  recruiter_id: 17,
  department_id: 30,
  position_id: 3,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

RecruiterProfile.create(
  recruiter_id: 18,
  department_id: 31,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

RecruiterProfile.create(
  recruiter_id: 19,
  department_id: 32,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)

RecruiterProfile.create(
  recruiter_id: 20,
  department_id: 33,
  position_id: 3,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name
)


# 求人ステータスダミーデータ作成
job_statuses = [
  "未公開", "公開中", "募集終了"
]

job_statuses.each do |name|
  JobStatus.find_or_create_by(name: name)
end

# 求人ダミーデータ作成(12件)
# 技術開発本部/ITソリューション技術開発部/第一システム技術部/一課: id: 9 担当者: 1人
# job_id: 1
Job.create(
  category_id: 3,
  department_id: 9,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [1],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部/一課: id: 9 担当者: 2人
# job_id: 2
Job.create(
  category_id: 3,
  department_id: 9,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [1,2],
  job_status_id: 2

)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部/二課: id: 10 担当者1人
# job_id: 3
Job.create(
  category_id: 3,
  department_id: 10,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [3],
  job_status_id: 2

)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/一課: id: 14 担当者2人
# job_id: 4
Job.create(
  category_id: 3,
  department_id: 14,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [4, 5],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/二課: id: 15　担当者1人
# job_id: 5
Job.create(
  category_id: 3,
  department_id: 15,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [6],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/二課: id: 15　担当者1人
# job_id: 6
Job.create(
  category_id: 3,
  department_id: 15,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [6],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部/一課: id: 9 担当者: 1人
# job_id: 7
Job.create(
  category_id: 3,
  department_id: 9,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [1],
  job_status_id: 1
)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部/一課: id: 9 担当者1人
# job_id: 8
Job.create(
  category_id: 3,
  department_id: 9,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [2],
  job_status_id: 3
)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部/二課: id: 10 担当者1人
# job_id: 9
Job.create(
  category_id: 3,
  department_id: 10,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [3],
  job_status_id: 1
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/一課: id: 14　担当者2人
# job_id: 10
Job.create(
  category_id: 3,
  department_id: 14,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [4, 5],
  job_status_id: 3
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/二課: id: 15 担当者1人
# job_id: 11
Job.create(
  category_id: 3,
  department_id: 15,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [6],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/二課: id: 15 担当者1人
# job_id: 12
Job.create(
  category_id: 3,
  department_id: 15,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [6],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部/一課: id: 9 担当者: 2人
# job_id: 13
Job.create(
  category_id: 3,
  department_id: 9,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [1, 2],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部/一課: id: 9 担当者1人
# job_id: 14
Job.create(
  category_id: 3,
  department_id: 9,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [1],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部/一課: id: 9 担当者1人
# job_id: 15
Job.create(
  category_id: 3,
  department_id: 9,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [2],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第一システム技術部/二課: id: 10 担当者1人
# job_id: 16
Job.create(
  category_id: 3,
  department_id: 10,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [3],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/一課: id: 14　担当者1人
# job_id: 17
Job.create(
  category_id: 3,
  department_id: 14,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [4],
  job_status_id: 2
)

# 技術開発本部/ITソリューション技術開発部/第二システム技術部/二課: id: 15 担当者1人
# job_id: 18
Job.create(
  category_id: 3,
  department_id: 15,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [6],
  job_status_id: 2
)

# job_id: 19
Job.create(
  category_id: 3,
  department_id: 15,
  work_location_id: 11,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [6],
  job_status_id: 2
)

# 経営戦略統括部/IRグループ/IRチーム: department_id: 30 担当者1人
# job_id: 20
Job.create(
  category_id: 4,
  department_id: 30,
  work_location_id: 13,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [17],
  job_status_id: 2
)

# 内部監査室/海外チーム: department_id: 23 担当者1人
# job_id: 21
Job.create(
  category_id: 4,
  department_id: 23,
  work_location_id: 13,
  title: Faker::Job.unique.title,
  job_description: Faker::Lorem.sentence,
  application_requirement: Faker::Lorem.sentence,
  contact_person_ids: [11],
  job_status_id: 2
)


# 従業員ダミーデータ作成(2名分)
11.times do |n|
  Employee.create(
    username: "employee#{n + 1}",
    email: "sample#{n + 1}@sample.com",
    password: "password"
  )
end

# 内部監査室/海外チーム id: 23, 一般社員
EmployeeProfile.create(
  employee_id: 1,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

EmployeeProfile.create(
  employee_id: 2,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

EmployeeProfile.create(
  employee_id: 3,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

EmployeeProfile.create(
  employee_id: 4,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

EmployeeProfile.create(
  employee_id: 5,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

EmployeeProfile.create(
  employee_id: 6,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)
EmployeeProfile.create(
  employee_id: 7,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

EmployeeProfile.create(
  employee_id: 8,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

EmployeeProfile.create(
  employee_id: 9,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

EmployeeProfile.create(
  employee_id: 10,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

EmployeeProfile.create(
  employee_id: 11,
  department_id: 23,
  position_id: 2,
  first_name: Faker::Name.unique.first_name,
  last_name: Faker::Name.unique.last_name,
  qualifications: Faker::Lorem.sentence,
  skills: Faker::Lorem.sentence
)

JobContactPersonMap.create(
  job_id: 1,
  contact_person_id: 1
)

JobContactPersonMap.create(
  job_id: 2,
  contact_person_id: 1
)

JobContactPersonMap.create(
  job_id: 2,
  contact_person_id: 2
)

JobContactPersonMap.create(
  job_id: 3,
  contact_person_id: 3
)

JobContactPersonMap.create(
  job_id: 4,
  contact_person_id: 4
)

JobContactPersonMap.create(
  job_id: 4,
  contact_person_id: 5
)

JobContactPersonMap.create(
  job_id: 5,
  contact_person_id: 6
)

JobContactPersonMap.create(
  job_id: 6,
  contact_person_id: 6
)

JobContactPersonMap.create(
  job_id: 7,
  contact_person_id: 1
)

JobContactPersonMap.create(
  job_id: 8,
  contact_person_id: 2
)

JobContactPersonMap.create(
  job_id: 9,
  contact_person_id: 3
)

JobContactPersonMap.create(
  job_id: 10,
  contact_person_id: 4
)

JobContactPersonMap.create(
  job_id: 10,
  contact_person_id: 5
)

JobContactPersonMap.create(
  job_id: 11,
  contact_person_id: 6
)

JobContactPersonMap.create(
  job_id: 12,
  contact_person_id: 6
)

JobContactPersonMap.create(
  job_id: 13,
  contact_person_id: 1
)

JobContactPersonMap.create(
  job_id: 13,
  contact_person_id: 2
)

JobContactPersonMap.create(
  job_id: 14,
  contact_person_id: 1
)

JobContactPersonMap.create(
  job_id: 15,
  contact_person_id: 2
)

JobContactPersonMap.create(
  job_id: 16,
  contact_person_id: 3
)

JobContactPersonMap.create(
  job_id: 17,
  contact_person_id: 4
)

JobContactPersonMap.create(
  job_id: 18,
  contact_person_id: 6
)

JobContactPersonMap.create(
  job_id: 19,
  contact_person_id: 6
)

JobContactPersonMap.create(
  job_id: 21,
  contact_person_id: 11
)



# 応募状況ダミーデータ作成
application_statuses = [
  "応募中", "合格", "不合格"
]

application_statuses.each do |name|
  ApplicationStatus.find_or_create_by(name: name)
end

# 応募ダミーデータ作成
JobApplication.create(
  job_id: 1,
  applicant_id: 1,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 2,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 3,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 4,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 5,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 6,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 7,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 8,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 9,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 10,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

JobApplication.create(
  job_id: 1,
  applicant_id: 11,
  reason_for_application: Faker::Lorem.sentence,
  self_promotion: Faker::Lorem.sentence,
)

1.times do |n|
  Admin.create(
    username: "admin#{n + 1}",
    email: "admin#{n + 1}@admin.com",
    password: "password"
  )
end
