// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jsapi
//= require chartkick
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
//= require underscore
//= require gmaps/google


function checkAll(check_all) {
  // Pass in a named "Check All" checkbox that appears on the same form where All
  // checkboxes should be checked.

  // Loop through an array containing ALL inputs on the same form as check_all
  var inputs = check_all.form.getElementsByTagName('input');
  for (var i = 0; i < inputs.length; i++) {
    // Only work on checkboxes, and NOT on the "Check All" checkboxes
    if (inputs[i].type == 'checkbox') {
      if (check_all.checked == true) {
        inputs[i].checked = true;
      } else {
        inputs[i].checked = false;
      }
    }
  }
}

// ========== Core JS Buttons ==========
var cores = new Array();

function changeStatusCore(el) {
  var tr = el.parentNode;
  var stat = el.getElementsByClassName('stat-btn')[0];
  var core_id = $(el).data("id");

  if (stat.className.includes('fa-green')) {
    tr.className = ""
    stat.className = "fa fa-check fa-lg stat-btn fa-clear"
    var index = cores.indexOf(core_id);
    cores.splice(index, 1);
  } else {
    tr.className = "bg-yellow"
    stat.className = "fa fa-check fa-lg stat-btn fa-green"
    cores.push(core_id);
  }
}

function mergeDataCore() {
  console.log("mergeData Clicked", cores);
  $.ajax({
    url: "/cores/merge_data",
    data: {cores: cores},
    success: function() { location.reload(); }
  });
}

function flagDataCore() {
  console.log("flagData Clicked", cores);
  $.ajax({
    url: "/cores/flag_data",
    data: {cores: cores},
    success: function() { location.reload(); }
  });
}

function dropDataCore() {
  console.log("dropData Clicked", cores);
  $.ajax({
    url: "/cores/drop_data",
    data: {cores: cores},
    success: function() { location.reload(); }
  });
}

// ========== Location JS Buttons ==========
var selects = new Object();
var rows = new Array();

function changeAllStatus(el) {
  var stat = el.getElementsByClassName('stat-btn')[0];
  var location_id = $(el).data("id");

  if (stat.className.includes('fa-circle-thin')) {
    stat.className = "fa fa-check-circle fa-lg fa-orange stat-btn";
    rows.push(location_id);
  } else if (stat.className.includes('fa-check-circle')) {
    stat.className = "fa fa-circle-thin fa-lg fa-clear stat-btn";
    var index = rows.indexOf(location_id);
    rows.splice(index, 1);
  }
}

function changeStatus(el) {
  var stat = el.getElementsByClassName('stat-btn')[0];
  var location_id = $(el).data("id");
  var location_col = $(el).data("col");

  if (stat.className.includes('fa-circle-thin')) {
    stat.className = "fa fa-check-circle fa-lg fa-orange stat-btn";
    if (selects[location_col]) {
      selects[location_col].push(location_id);
    } else {
      selects[location_col] = [location_id];
    }
  } else if (stat.className.includes('fa-check-circle')) {
    stat.className = "fa fa-circle-thin fa-lg fa-clear stat-btn";
    var index = selects[location_col].indexOf(location_id);
    selects[location_col].splice(index, 1);
  }
}

function mergeData() {
  // console.log("mergeData Clicked", selects, rows);
  $.ajax({
    url: "/locations/merge_data",
    data: {selects: selects, rows: rows},
    success: function() { location.reload(); }
  });
}

function flagData() {
  // console.log("flagData Clicked", selects, rows);
  $.ajax({
    url: "/locations/flag_data",
    data: {selects: selects, rows: rows},
    success: function() { location.reload(); }
  });
}

// function changeStatus(el) {
//     var stat = el.getElementsByClassName('stat-btn')[0];
//     var location_id = $(el).data("id");
//     var location_col = $(el).data("col");
//
//     if (stat.className.includes('fa-circle-thin')) {
//         stat.className = "fa fa-check-circle fa-lg fa-blue stat-btn";
//         $(stat).attr('data-original-title', 'Update Cell');
//     } else if (stat.className.includes('fa-check-circle')) {
//         stat.className = "fa fa-plus-circle fa-lg fa-green stat-btn";
//         $(stat).attr('data-original-title', 'Update Row');
//         merge_data(location_id, location_col);
//     } else if (stat.className.includes('fa-plus-circle')) {
//         stat.className = "fa fa-minus-circle fa-lg fa-red stat-btn";
//         $(stat).attr('data-original-title', 'Remove Row');
//     } else if (stat.className.includes('fa-minus-circle')) {
//         stat.className = "fa fa-circle-thin fa-lg fa-clear stat-btn";
//         $(stat).attr('data-original-title', 'Reset');
//     }
// }
//
// function merge_data(location_id, location_col) {
//     $.ajax({
//         url: "/locations/merge_data",
//         data: {location_id: location_id, location_col: location_col}
//     });
// }


$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})


function changeHierarchy(el) {
  var hier = el.getElementsByClassName('hier-btn')[0];
  if (hier.className.includes('fa-dot-circle-o')) {
    hier.className = "fa fa-arrow-circle-up fa-lg fa-blue hier-btn";
    $(hier).attr('data-original-title', 'Parent');
  } else if (hier.className.includes('fa-arrow-circle-up')) {
    hier.className = "fa fa-arrow-circle-down fa-lg fa-green hier-btn";
    $(hier).attr('data-original-title', 'Child');
  } else if (hier.className.includes('fa-arrow-circle-down')) {
    hier.className = "fa fa-exclamation-circle fa-lg fa-red hier-btn";
    $(hier).attr('data-original-title', 'Alert');
  } else if (hier.className.includes('fa-exclamation-circle')) {
    hier.className = "fa fa-dot-circle-o fa-lg fa-clear hier-btn";
    $(hier).attr('data-original-title', 'None');
  }
}


( function($) {
  function iframeModalOpen(){
    $('.modalButton').on('click', function(e) {
      // console.log(this);
      var src = $(this).attr('data-src');

      $("#previewModal iframe").attr({
        'src': src
      });
    });

    $('#previewModal').on('hidden.bs.modal', function(){
      $(this).find('iframe').html("");
      $(this).find('iframe').attr("src", "");
    });
  }

  $(document).ready(function(){
    iframeModalOpen();
  });
} ) ( jQuery );

( function($) {
  function iframeModalOpen(){
    $('.modalButton').on('click', function(e) {
      // console.log(this);
      var src = $(this).attr('data-src');

      $("#scrapedModal iframe").attr({
        'src': src
      });
    });

    $('#scrapedModal').on('hidden.bs.modal', function(){
      $(this).find('iframe').html("");
      $(this).find('iframe').attr("src", "");
    });
  }

  $(document).ready(function(){
    iframeModalOpen();
  });
} ) ( jQuery );


// ========== Admin's user level changer buttons ==========
var users = new Array();

function selectUsers(el) {
  var tr = el.parentNode;
  var stat = el.getElementsByClassName('stat-btn')[0];
  var user_id = $(el).data("id");

  if (stat.className.includes('fa-green')) {
    tr.className = ""
    stat.className = "fa fa-check fa-lg stat-btn fa-clear"
    var index = users.indexOf(user_id);
    users.splice(index, 1);
  } else {
    tr.className = "bg-yellow"
    stat.className = "fa fa-check fa-lg stat-btn fa-green"
    users.push(user_id);
  }
}

function changeUserLevel(el) {
  var level = $(el).data("level");
  $.ajax({
    url: "/admin/change_user_level",
    data: {users: users, level: level},
    success: function() { location.reload(); }
  });
}
