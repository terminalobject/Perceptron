var http = require('http')
var fs = require('fs')

const cheerio = require('cheerio')

function parse(str) {
  const find = cheerio.load(str)

  find('h3').each(function(i, elem) {
    fs.appendFileSync('telegraph.txt', find(this).text().trim() + '\n', 'UTF8')
  });
}

var callback = function(response) {
  console.log(`Response: ${response.statusCode}`);
  var str = '';

  response.on('data', function (chunk) {
    str += chunk;
  });

  response.on('end', function () {
    parse(str);
  });
}

var i = 0;
var timer = setInterval(function() {
    i++;
    console.log('Fetched page');
    http.request({
      host: 'www.telegraph.co.uk',
      path: `/news/loadmore${i}/`
    }, callback).end();
    if (i == 100) {
      clearInterval(timer);
    }
  }, 1000);

// Cracked
// host: 'www.cracked.com',
// path: `/past_featured_ajax/?page=${i}&ajax=true&ts=1503052726005`

// Business Insider
// host: 'uk.businessinsider.com',
// path: `/?page=${i}`
