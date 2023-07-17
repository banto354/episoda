$(document).ready(function() {
  $('#datetimepicker').datetimepicker({
    // requires moment-timezone.js
    timeZone: '',
    // date format
    // http://momentjs.com/docs/#/displaying/format/
    format: false,
    dayViewHeaderFormat: 'MMMM YYYY',
    extraFormats: false,
    // step size
    stepping: 1,
    // min/max dates
    minDate: false,
    maxDate: false,
    // uses current date/time
    useCurrent: true,
    // uses Bootstraps collapse to switch between date/time pickers
    collapse: true,
    // https://github.com/moment/moment/tree/develop/locale
    locale: moment.locale(),
    // default date
    defaultDate: false,
    // disabled dates
    // array of [date, moment, string]
    disabledDates: false,
    // enabled dates
    // array of [date, moment, string]
    enabledDates: false,
    // default icons
    icons: {
      time: 'fa fa-clock-o',
      date: 'fa fa-calendar',
      up: 'fa fa-arrow-up',
      down: 'fa fa-arrow-down',
      previous: 'fa fa-chevron-left',
      next: 'fa fa-chevron-right',
      today: 'fa fa-calendar-check-o',
      clear: 'fa fa-delete',
      close: 'fa fa-times'
    },
    // tooltip options
    tooltips: {
      today: 'Go to today',
      clear: 'Clear selection',
      close: 'Close the picker',
      selectMonth: 'Select Month',
      prevMonth: 'Previous Month',
      nextMonth: 'Next Month',
      selectYear: 'Select Year',
      prevYear: 'Previous Year',
      nextYear: 'Next Year',
      selectDecade: 'Select Decade',
      prevDecade: 'Previous Decade',
      nextDecade: 'Next Decade',
      prevCentury: 'Previous Century',
      nextCentury: 'Next Century',
      pickHour: 'Pick Hour',
      incrementHour: 'Increment Hour',
      decrementHour: 'Decrement Hour',
      pickMinute: 'Pick Minute',
      incrementMinute: 'Increment Minute',
      decrementMinute: 'Decrement Minute',
      pickSecond: 'Pick Second',
      incrementSecond: 'Increment Second',
      decrementSecond: 'Decrement Second',
      togglePeriod: 'Toggle Period',
      selectTime: 'Select Time',
      selectDate: 'Select Date'
    },
    // uses strict
    useStrict: false,
    // displays side by side
    sideBySide: false,
    // disabled days of the week
    daysOfWeekDisabled: false,
    // shows the week of the year
    calendarWeeks: false,
    // 'decades','years','months','days'
    viewMode: 'days',
    // toolbar placement
    toolbarPlacement: 'default',
    // enable/disable buttons
    buttons: {
      showToday: false,
      showClear: false,
      showClose: false
    },
    // widget position
    widgetPositioning: {
      horizontal: 'auto',
      vertical: 'auto'
    },
    // string or jQuery object
    widgetParent: null,
    // ignore read only input
    ignoreReadonly: false,
    // always keep open
    keepOpen: false,
    // shows on focus
    focusOnShow: true,
    // inline mode
    inline: false,
    // makes the date picker not revert or overwrite invalid dates
    keepInvalid: false,
    // debug mode
    debug: false,
    // shows on focus and icon click
    allowInputToggle: false,
    // disables time selection
    disabledTimeIntervals: false,
    // disables/enables hours
    disabledHours: false,
    enabledHours: false,
    // changes the viewDate without changing or setting the selected date
    viewDate: false,
    // allows multiple dates
    allowMultidate: false,
    // custom separator
    multidateSeparator: ','
  });
});