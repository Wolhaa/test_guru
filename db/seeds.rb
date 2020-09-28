# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([
  { email: 'devskoronata@gmail.com', password: '123aaa', type: "Admin", first_name: 'Nataliya', last_name: 'Skorobogatko'}
  { email: 'admin@guru.com', password: '123456', first_name: 'Ivan', last_name: 'Ivanov'},
])

categories = Category.create([
  { title: 'Математика' },
  { title: 'Русский язык' }
])

tests = Test.create([
  { title: 'Вычитание', level: 1, category: categories[0], user: users[0] },
  { title: 'Сложение', level: 2, category: categories[1], user: users[0] },
  { title: 'Правописание', level: 2, category: categories[1], user: users[0] }
])

questions = Question.create([
  { body: '5+5?', test: tests[0] },
  { body: '4-2?', test: tests[1] },
  { body: 'После Ж и Ш пишется И или Ы?', test: tests[2] }
])

answers = Answer.create([
  { body: '10', correct: true, question: questions[0] },
  { body: '2', correct: true, question: questions[1] },
  { body: 'И', correct: true, question: questions[2] }

])
