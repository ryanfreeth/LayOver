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
      response.error("users lookup failed");
    }
  });
});

Parse.Cloud.define("matches", function(request, response) {  
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
  // console.log(Parse.User.current());
  var _ = require("underscore");
  
  var checkins = Parse.Object.extend("checkins");
  var query = new Parse.Query(checkins);
  query.equalTo("User", Parse.User.current());
  query.descending("createdAt");
  query.first({
    success: function(checkin) {
      var checkins = Parse.Object.extend("checkins");
      var query = new Parse.Query(checkins);
      query.equalTo("airport",checkin.get('airport'));
      query.find({
        success: function(results) {
          // console.log(results);
          var returnData = [];
          for( var i = 0; i < results.length; i++)
          {
            console.log(results[i]);
            // var otherStart = results[i].get("started_at");
            // console.log(otherStart);
            // var otherEnd = results[i].get("ended_at");
            // console.log(otherEnd);
            var user = results[i].get("user");
            returnData.push(user);
          }
          response.success(returnData);
        },
        error: function(error) {
          response.error("Cannot load latest Checkin");
        }
      });
    },
    error: function(error) {
      response.error("Cannot load latest Checkin");
    }
  });
});

function getUser(id)
{
  var query = new Parse.Query(Parse.User);
  query.get(id, {
      success: function(result) {
        return result;
      },
      error: function(error) {
        reponse.error(error);
      }
  });
}