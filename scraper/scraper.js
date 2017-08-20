var https = require('https')
var fs = require('fs')

const cheerio = require('cheerio')

function parse(str) {
  const find = cheerio.load(str)

  find('h3.title').each(function(i, elem) {
    fs.appendFileSync('collegehumor.txt', find(this).text().trim() + '\n', 'UTF8')
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

var i = 20;
var timer = setInterval(function() {
    i++;
    console.log('Fetched page');
    https.request({
      host: 'www.collegehumor.com',
      path: `/articles/page:${i}`
    }, callback).end();
    if (i == 50) {
      clearInterval(timer);
    }
  }, 500);

// Cracked
// host: 'www.cracked.com',
// path: `/past_featured_ajax/?page=${i}&ajax=true&ts=1503052726005`

// Business Insider
// host: 'uk.businessinsider.com',
// path: `/?page=${i}`
