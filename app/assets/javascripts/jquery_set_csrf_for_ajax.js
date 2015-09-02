$.ajaxPrefilter(function(options) {
  if (!options.beforeSend) {
    options.beforeSend = function(xhr) { 
      xhr.setRequestHeader('X-CSRF-Token', $("meta[name='csrf-token']").attr("content"));
    }
  }
});
