# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# #
# user_list = [{username: 'Sounak_Ray', email: 'sr3846@columbia.edu', password: 'lollollol'},
#              {username: 'Chinmay_Garg', email: 'cg2486@columbia.edu', password: 'lolcube'},
#              {username: 'Umang_Raj', email: 'ur1236@columbia.edu', password: 'lolcube'},
#              {username: 'Harrison_Groll', email: 'hsg2136@columbia.edu', password: 'lolcube'}
# ]
#
# user_list.each do |user|
#   User.create!(user)
# end
require 'json'

dept_list = ['COMS', 'ACCT', 'CSOR', 'CHEN', 'CSEE', 'IEOR']

contents = open("2022-Spring.json", "r").read()
courses = contents.split("\n")
courses.each do |course|
  course_hash = JSON.parse(course)
  if dept_list.include? course_hash["department_code"]
    Course.create(course_code: course_hash["course_code"], course_title: course_hash["course_title"].titleize, class_id: course_hash["class_id"], course_subtitle: course_hash["course_subtitle"], department: course_hash["department"].titleize, department_code: course_hash["department_code"])
    Room.create(name: course_hash["course_title"].titleize, is_private: false, dept_code: course_hash["department_code"], distance: Float::MAX)
  end
end