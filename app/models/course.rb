require 'json'

class Course < ApplicationRecord
    scope :all_courses, -> {}

    contents = open("/Users/Chinmay/Desktop/Columbia/Fall21/COMSW4995/Project/ESaaS-Project-iter1-submission/2022-Spring.json", "r").read()
    courses = contents.split("\n") 
    courses.each do |course|
        course_hash = JSON.parse(course)
        # Course.create(course_code: course_hash["course_code"], course_title: course_hash["course_title"], class_id: course_hash["class_id"], course_subtitle: course_hash["course_subtitle"], department: course_hash["department"], department_code: course_hash["department_code"])
        # if course_hash["department_code"] == "COMS" then 
        #     Room.create(name: course_hash["course_title"], is_private: false)
        # end 
    end 
end
