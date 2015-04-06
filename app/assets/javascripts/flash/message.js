define(['jquery'], function($) {
  var initialize = function() {
    $(document).on('click', '.flash__close', function() {
      $('.flash').slideUp(200, function() {
        $(this).remove();
      });
      return false;
    });
  };

  return {
    initialize: initialize
  };
});
