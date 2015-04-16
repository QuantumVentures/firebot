modulejs.define('button_scroll_to', function() {
  var initialize = function() {
    $(document).on('click', '.js-scroll-to', function() {
      var key = $(this).data('scroll-to-key');
      var top = $('.' + key).offset().top;
      $('html, body').animate({ scrollTop: top }, 300);
      return false;
    });
  };

  return {
    initialize: initialize
  };
});
