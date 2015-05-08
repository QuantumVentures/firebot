modulejs.define('hero_content', function() {
  var initialize = function() {
    $(document).ready(function() {
      var hero = $('.hero__background__content');
      if (hero.length > 0) {
        var hero_height = hero.height();
        var hero_background_height = $('.hero__background').height();
        var endPoint = (hero_background_height - hero_height) * 0.5;
        var startPoint = endPoint + 20;
        hero.css({ "top": startPoint });

        hero.animate({ "opacity": 1, "top": endPoint }, 1000);

        $(window).resize(function() {
          var hero_height = hero.height();
          var hero_background_height = $('.hero__background').height();
          var endPoint = (hero_background_height - hero_height) * 0.5;
          hero.css({ "top": endPoint });
        });
      }
    });
  };

  return {
    initialize: initialize
  };
});
