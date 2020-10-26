document.addEventListener('turbolinks:load', function () {
  var control = document.getElementById('badge_rule')

  if (control) { control.addEventListener('click', setVisible) }
})

function setVisible () {
  var levelFiled = document.querySelector('.fieldset_level')
  var categoryFiled = document.querySelector('.fieldset_category')

  switch (this.value) {
    case 'Все тесты уровня':
      categoryFiled.disabled = true
      levelFiled.disabled = false
      break
    case 'Все тесты категории':
      categoryFiled.disabled = false
      levelFiled.disabled = true
      break
    default:
      levelFiled.disabled = true
      categoryFiled.disabled = true
  }
}
