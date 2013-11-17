require('cloud/app.js');
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

Parse.Cloud.define("users", function(request, response) {
  var query = new Parse.Query("User");
  query.find({
    success: function(results) {
      response.success(query);
    },
    error: function() {
      response.error("movie lookup failed");
    }
  });
});