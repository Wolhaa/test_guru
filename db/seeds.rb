# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create([
  { login: 'user1', password: 'password1' },
  { login: 'user2', password: 'password2' }
])

categories = Category.create([
  { title: 'Математика' },
  { title: 'Русский язык' }
])

tests = Test.create([
  { title: 'Вычитание', level: 1, category_id: 1 },
  { title: 'Сложение', category_id: 1 },
  { title: 'Правописание', level: 2, category_id: 2 }
])

questions = Question.create([
  { body: '5+5?', test_id: 1 },
  { body: '4-2?', test_id: 2 },
  { body: 'После Ж и Ш пишется И или Ы?', test_id: 3 }
])

answers = Answer.create([
  { body: '10', correct: true, question_id: 1 },
  { body: '2', correct: true, question_id: 2 },
  { body: 'И', correct: true, question_id: 3 }

])

test_users = TestsUser.create([
  { user: users[0], test: tests[0] },
  { user: users[0], test: tests[1]}
])
