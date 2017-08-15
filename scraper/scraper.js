var http = require('http')
var fs = require('fs')

const cheerio = require('cheerio')

function parse(str) {
  const find = cheerio.load(str)

  find('a.full-item-title').each(function(i, elem) {
    fs.appendFileSync('cosmopolitan', find(this).text().trim() + '\n', 'UTF8')
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

var i = 1;
var timer = setInterval(function() {
    i++;
    console.log('Fetched page', i);
    http.request({
      host: 'www.cosmopolitan.com',
      path: `/uk/ajax/infiniteload/?id=a6d2cadc-58df-4c89-9335-f429542f1066&class=CoreModels%5Csections%5CSectionModel&viewset=homepage&page=${i}`
    }, callback).end();
    if (i == 20) {
      clearInterval(timer);
    }
  }, 400);
