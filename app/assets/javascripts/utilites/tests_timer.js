document.addEventListener('turbolinks:load', function () {
  var testTimer = document.querySelector('.test-timer')

  if (testTimer) { countDown(testTimer) }
})

function countDown (timer) {
  var limitInSeconds = timer.dataset.timeLimit
  showRemainigTime(limitInSeconds, timer)

  var timerId = setInterval(function () {
    limitInSeconds--
    showRemainigTime(limitInSeconds, timer)

    if (limitInSeconds == 0) {
      clearInterval(timerId)
      alert('Время вышло')
      submitForm()
    }
  }, 1000)
}

function submitForm () {
  var formTag = document.querySelector('#test-passage-form')
  if (formTag) { formTag.submit() }
}

function showRemainigTime (seconds, timer) {
  timer.innerHTML = parseInt(seconds / 60) + ':' + (seconds % 60) + ' до окончания теста'
}
