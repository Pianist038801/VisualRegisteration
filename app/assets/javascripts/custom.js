var App = {
  _isWithTooltips: false,

  init: function () {
    App._tableSorters()
    App._tooltips()
    App._navDoc()

    $(window).on('resize', App._tooltips)
    $(document).on('shown.bs.tab', function () {
      $(document).trigger('redraw.bs.charts')
    })

    // docs top button
    if ($('.docs-top').length) {
      App._backToTopButton()
      $(window).on('scroll', App._backToTopButton)
    }
  },

  _navDoc: function () {
    // doc nav js
    var $toc    = $('#markdown-toc')
    var $window = $(window)

    if ($toc[0]) {
      maybeActivateDocNavigation()
      $window.on('resize', maybeActivateDocNavigation)

      function maybeActivateDocNavigation () {
        if ($window.width() > 768) {
          activateDocNavigation()
        } else {
          deactivateDocNavigation()
        }
      }

      function deactivateDocNavigation() {
        $window.off('resize.theme.nav')
        $window.off('scroll.theme.nav')
        $toc.css({
          position: '',
          left: '',
          top: ''
        })
      }

      function activateDocNavigation() {
        var cache = {}

        function updateCache() {
          cache.containerTop   = $('.docs-content').offset().top - 40
          cache.containerRight = $('.docs-content').offset().left + $('.docs-content').width() + 45
          measure()
        }

        function measure() {
          var scrollTop = $window.scrollTop()
          var distance =  Math.max(scrollTop - cache.containerTop, 0)

          if (!distance) {
            $($toc.find('li')[1]).addClass('active')
            return $toc.css({
              position: '',
              left: '',
              top: ''
            })
          }

          $toc.css({
            position: 'fixed',
            left: cache.containerRight,
            top: 40
          })
        }

        updateCache()

        $(window)
          .on('resize.theme.nav', updateCache)
          .on('scroll.theme.nav', measure)
        $('body').scrollspy({
          target: '#markdown-toc',
          selector: 'li > a'
        })
        setTimeout(function () {
          $('body').scrollspy('refresh')
        }, 1000)
      }
    }
  },

  _backToTopButton: function () {
    if ($(window).scrollTop() > $(window).height()) {
      $('.docs-top').fadeIn()
    } else {
      $('.docs-top').fadeOut()
    }
  },

  _tooltips: function () {
    if ($(window).width() > 768) {
      if (App._isWithTooltips) return
      App._isWithTooltips = true
      $('[data-toggle="tooltip"]').tooltip()

    } else {
      if (!App._isWithTooltips) return
      App._isWithTooltips = false
      $('[data-toggle="tooltip"]').tooltip('destroy')
    }
  },

  _tableSorters: function () {
    $('[data-sort="table"]').tablesorter( {sortList: [[1,0]]} )
  }
}
App.init()


$(document).ready(function(){

  $('.select2').select2()

  $('.time').datetimepicker({
    format: 'HH:mm'
  });

  $(document).on('dp.change', 'input.time_change', function() {
    var time_from = $("#hour_time_from").val();
    var time_to = $("#hour_time_to").val();

    var startDate = new Date("1970-1-1 " + time_from)
    var endDate   = new Date("1970-1-1 " + time_to)
    var diff = (endDate.getTime() - startDate.getTime())/1000/3600
    var round_diff = Math.round(diff *100)/100
    $("#hour_amount").val(round_diff)
  });

  $('#monthlyDatePicker').datepicker({
    minViewMode: 1,
    format: "MM-yyyy"
  });

  $('#monthlyDatePicker').on('changeDate', function(){
    $('#date_filter_form').submit();
  });

  $('.weeklyDatePicker').datepicker();

  $('#start_date').on('changeDate', function(){
    var value = $("#start_date").val();
    var firstDate = moment(value, "MM/DD/YYYY").day(1).format("MM/DD/YYYY");
    var lastDate =  moment(value, "MM/DD/YYYY").day(7).format("MM/DD/YYYY");
    $('#start_date').val(firstDate);
    $('#end_date').val(lastDate);
    $('#date_filter_form').submit();
  });

  $('#end_date').on('changeDate', function(){
    var value = $("#end_date").val();
    var firstDate = moment(value, "MM/DD/YYYY").day(1).format("MM/DD/YYYY");
    var lastDate =  moment(value, "MM/DD/YYYY").day(6).format("MM/DD/YYYY");
    $('#start_date').val(firstDate);
    $('#end_date').val(lastDate);
    $('#date_filter_form').submit();
  });

  // Init Dependable Dropdown
  if($(".autocomplete-drop-down").length != 0){
    $('.autocomplete-drop-down').change(function() {
      var element_id = $(this).attr('data-target');
      target_id = $("#" + element_id).attr('data-target');
      if ($("#" + target_id)){
        $("#" + element_id).empty();
        $("#" + target_id).empty();
      }
      $("#" + element_id).empty();
      if($(this).val() != ""){
        var url = $(this).attr('data-url') + $(this).val();
        $.get(url, function(datas){
          if(datas){
            $.each(datas, function(index, value){
              $("#" + element_id).append(
                "<option value ='" + value['id'] + "'>" +
                  value['name'] +
                "</option>"
              );
            });
          }
        });
      }
    });
  }
  if($(".footable").length != 0){
    $('.footable').footable();
  }
});