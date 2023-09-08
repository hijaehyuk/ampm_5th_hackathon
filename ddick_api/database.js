const { MongoClient } = require('mongodb');

const url = 'mongodb+srv://hjs123:qwer1234@cluster0.ymcer3e.mongodb.net/?authMechanism=DEFAULT';
const options = { useNewUrlParser: true };

let connectDB;

if (process.env.NODE_ENV === 'development') {
  if (!global._mongo) {
    global._mongo = new MongoClient(url, options).connect();
  }
  connectDB = global._mongo;
} else {
  connectDB = new MongoClient(url, options).connect();
}

module.exports = { connectDB };