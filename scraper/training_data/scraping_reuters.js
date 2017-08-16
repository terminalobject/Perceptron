// http://www.reuters.com/news/archive/worldNews?view=page&page=1&pageSize=10

var http = require('http')
var fs = require('fs')

const cheerio = require('cheerio')

function parse(str) {
  const find = cheerio.load(str)

  find('a.data-link-name').each(function(i, elem) {
    fs.appendFileSync('guardian.txt', find(this).text().trim() + '\n', 'UTF8')
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

var i = 0;
var timer = setInterval(function() {
    i++;
    console.log('Fetched page', i);
    http.request({
      host: 'https://www.theguardian.com',
      path: 'https://www.theguardian.com/theguardian/2017/aug/' + i;
    }, callback).end();
    if (i == 14) {
      clearInterval(timer);
    }
  }, 400);
