'use strict';
const http = require('http');
const host = 'http://www.recipepuppy.com/api/';
exports.recipe3 = function recipei3(req, res) {
  // Get the city and date from the request
  let food = req.body.result.parameters['food']; // city is a required param
  
  // Call the weather API
  callRecipeApi(food).then((output) => {
    // Return the results of the recipe API to Dialogflow
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify({ 'speech': output, 'displayText': output }));
  }).catch((error) => {
    // If there is an error let the user know
    res.setHeader('Content-Type', 'application/json');
    res.send(JSON.stringify({ 'speech': error, 'displayText': error }));
  });
};
function callRecipeApi (food) {
  return new Promise((resolve, reject) => {
    let path = "?&q=" + food ;

      
    console.log('API Request: ' + host + path);
    // Make the HTTP request to get the weather
    http.get({host+path }, (res) => {
      let body = ''; // var to store the response chunks
      res.on('data', (d) => { body += d; }); // store each response chunk
      res.on('end', () => {
        // After all the data has been received parse the JSON for desired data
        let response = JSON.parse(body);
        let title = response['results'][0]['title'];
        let ingredients = response['results'][0]['ingredients'];
        // Create response
        let output = "The recipe for " + title + " is " + ingredients;
	// Resolve the promise with the output text
        console.log(output);
        resolve(output);
      });
      res.on('error', (error) => {
        reject(error);
      });
    });
  });
}




