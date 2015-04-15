modulejs.define('hero_content', function() {
  var initialize = function() {
    $(document).ready(function() {
      var hero = $('.hero__background__content');
      if (hero.length > 0) {
        var hero_height = hero.height();
        var hero_background_height = $('.hero__background').height();
        hero.css({ "top": (hero_background_height - hero_height) * 0.5 });
        hero.animate({ "opacity": 1 }, 400);
      }
    });
  };

  return {
    initialize: initialize
  };
});
