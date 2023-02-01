const fs = require("fs");
const { parse } = require("csv-parse");
const serviceAccount = require('./firestore-key.json');
const admin = require('firebase-admin');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

if (process.argv.length < 3) {
  console.error('Please include a path to a csv file');
  process.exit(1);
}

const db = admin.firestore();

const records = [];

function writeToFirestore(csvRecords) {
  const batchCommits = [];
  let batch = db.batch();

  let lastCountry = '';
  let cities = [];
  csvRecords.forEach((record, i) => {
    const [ name, country, subcountry, geonameid ] = record;

    const city = {
      name,
      province: subcountry,
      geonameid,
    }

    if (lastCountry != country) {
      var countryRef = db.collection('countries').doc();
      batch.set(countryRef, { country: lastCountry, cities: [...cities] });

      lastCountry = country;
      cities = [];
    }

    cities.push(city);

    if ((cities.length + 1) % 500 === 0) {
      console.log(`Writing batch ${i + 1}`);
      batchCommits.push(batch.commit());
      batch = db.batch();
    }
  });

  batchCommits.push(batch.commit());
  return Promise.all(batchCommits);
}

async function importCsv(csvFileName) {
  try {
    stream = fs.createReadStream(csvFileName).pipe(parse({ delimiter: ",", from_line: 2 }));

    stream.on("data", function (row) {
      records.push(row);
    }).on("end", async function () {
      await writeToFirestore(records);
    });

    stream.on("error", function (error) {
      console.log(error.message);
    })
  }
  catch (e) {
    console.error(e);
    process.exit(1);
  }
  console.log(`Wrote ${records.length} records`);
}

importCsv(process.argv[2]).catch(e => console.error(e));