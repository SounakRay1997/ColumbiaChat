require 'json'

class Course < ApplicationRecord
    dept_list = ['COMS', 'ACCT', 'CSOR', 'CHEN', 'CSEE', 'IEOR']

    contents = open("2022-Spring.json", "r").read()
    courses = contents.split("\n") 
    courses.each do |course|
        # course_hash = JSON.parse(course)
        # if dept_list.include? course_hash["department_code"]
        #     Course.create(course_code: course_hash["course_code"], course_title: course_hash["course_title"].titleize, class_id: course_hash["class_id"], course_subtitle: course_hash["course_subtitle"], department: course_hash["department"].titleize, department_code: course_hash["department_code"])
        #     Room.create(name: course_hash["course_title"].titleize, is_private: false, dept_code: course_hash["department_code"], distance: Float::MAX)
        # end
    end 
end
