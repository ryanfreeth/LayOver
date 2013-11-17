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

Parse.Cloud.define("matches", function(request, response) {
  var _ = require("underscore");
  // Parse.User.logIn("ryan", "layover");
  // 
  // 
  // var latestCheckin;
  // var query = new Parse.Query(checkin);
  // query.descending("createdAt");
  // query.first({
  //   success: function(object) {
  //     latestCheckin = object;
  //   },
  //   error: function(error) {
  //     response.error("Cannot load latest Checkin");
  //   }
  // });
  
  var users = new Parse.Query(Parse.User);
  users.find({
    success: function(results) {
      response.success(results);
    },
    error: function(error) {
      response.error("Cannot load users");
    }
  });
  // get all current checkins in location 
  // return users
});

Parse.Cloud.define("latestCheckin", function(request, response) {
  console.log(Parse.User.current());
  var _ = require("underscore");
  
  var checkins = Parse.Object.extend("checkins");
  var latestCheckin;
  var query = new Parse.Query(checkins);
  query.equalTo("User", Parse.User.current());
  query.descending("createdAt");
  query.first({
    success: function(object) {
      latestCheckin = object;
      response.success(latestCheckin);
    },
    error: function(error) {
      response.error("Cannot load latest Checkin");
    }
  });
  // get all current checkins in location 
  // return users
});