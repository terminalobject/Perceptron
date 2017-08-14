// http://www.reuters.com/news/archive/worldNews?view=page&page=1&pageSize=10

var https = require('https')
var fs = require('fs')

const cheerio = require('cheerio')

function parse(str) {
  const find = cheerio.load(str)

  find('a.js-headline-text').each(function(i, elem) {
    fs.appendFileSync('guardian', find(this).text().trim() + '\n', 'UTF8')
  });
}

var callback = function(response) {
  var str = '';

  //another chunk of data has been recieved, so append it to `str`
  response.on('data', function (chunk) {
    str += chunk;
  });

  //the whole response has been recieved, so we just print it out here
  response.on('end', function () {
    parse(str);
  });
}

var i = 20;
var timer = setInterval(function() {
    i++;
    console.log('Fetched page', i);
    https.request({
      host: 'www.theguardian.com',
      path: '/theguardian/2017/jul/' + i
    }, callback).end();
    if (i == 30) {
      clearInterval(timer);
    }
  }, 400);
