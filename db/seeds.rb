#  Seed file to create initial data for users, courses, papers, and paper elements

# Users
5.times do |n|
  puts "Creating user #{n + 1}"
  User.create!(
    email: "user#{n + 1}@example.com",
    password: '12345678',
    user_type: n.even? ? 0 : 1, # Example user types
    phone: "858282760#{n}",
    name: "User#{n + 1}"
  )
end

# Courses
3.times do |n|
  puts "Creating course #{n + 1}"
  Course.create!(
    name: "Course#{n + 1}",
    description: "Description for Course#{n + 1}",
    course_type: n.even? ? 0 : 1, # Example course types
    active_status: n.odd?, # Example active status
    user_id: User.where(user_type: 1).first.id
  )
end

# Papers
Course.all.each do |course|
  puts "Creating paper for course #{course.name}"
  4.times do |n|
    puts "  Creating Paper#{n + 1}"
    Paper.create!(
      title: "Paper#{n + 1}",
      active_status: n.even?,
      description: "Description for Paper#{n + 1}",
      paper_type: n % 2, # Example paper types
      course_id: course.id,
      user_id: course.user_id
    )
  end
end

Paper.all.each do |paper|
  puts "Creating Sections for paper #{paper.title}"
  # 3 Sections of each paper
  3.times do |n|
    puts "  Creating Section#{n + 1}"
    PaperElement.create!(
      element_type: 0,
      text: "Section #{n + 1}",
      link: "https://example.com/question#{n + 1}",
      marks: 0, # Example marks
      negative_marks: 0,
      parent_id: paper.id
    )
  end
  sections = PaperElement.where(parent_id: paper.paper_element_id)

  sections.each do |section|
    puts "Creating Questions for section #{section.text}"
    questions = []
    5.times do |n|
      questions <<
        PaperElement.create!(
          element_type: 1,
          text: "Question #{n + 1}",
          link: "https://example.com/question#{n + 1}",
          marks: 1, # Example marks
          negative_marks: 0.334,
          parent_id: section.id
        )
    end
    questions.each do |question|
      puts "Creating Answers for question #{question.text}"
      answers = []
      4.times do |n|
        answers <<
          PaperElement.create!(
            element_type: 2,
            text: "Answer #{n + 1}",
            link: "https://example.com/question#{n + 1}",
            marks: 0, # Example marks
            negative_marks: 0,
            parent_id: question.id
          )
      end
      question.update(meta_data: [answers.sample.id])
    end
  end
end
