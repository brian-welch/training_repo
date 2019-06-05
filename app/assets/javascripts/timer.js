var session_timer = document.querySelector('#session_timer_inner');

function session_timer_start() {
  session_timer_run();
  setInterval(session_timer_run, 1000);
}

function session_timer_run() {
  session_timer.textContent = (h < 10 ? "0" + h : h) + ":" + (m < 10 ? "0" + m : m) + ":" + (s < 10 ? "0" + s : s);
  s++;

  if(s == 60) {
    s = 0;
    m++;
  }
  if(m == 60) {
    m = 0;
    h++;
  }
}

function show_hide_session_timer() {
  $(".timer_clock_container").toggleClass("reveal_session_timer");
}
