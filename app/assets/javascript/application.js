// = require jquery
// = require jquery_ujs
// = require bootstrap
//
// = require_tree .
// = require_self

$('*').on('ajax:success', function (event, data, status, xhr) {
  eval(xhr.responseText);
});