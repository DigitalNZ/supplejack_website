$('.toggle-add-panel').click(function() {
  $(this).parent('.add-panel').find('.add-panel-inset').slideToggle();
  $(this).parent('.add-panel').toggleClass('add-panel-active');
});
