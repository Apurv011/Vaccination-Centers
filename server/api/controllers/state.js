const neo4j = require('neo4j-driver');
require("dotenv").config();

var driver = neo4j.driver(process.env.DATABASE_URL_CLOUD, neo4j.auth.basic(process.env.DATABASE_USER, process.env.DATABASE_PASSWORD));
var session = driver.session();

exports.getAllStates = (req, res, next) => {
    const ls = [];
    session
        .run('MATCH(n: State) RETURN n')
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
              _id: record._fields[0].identity.low,
              state_name: record._fields[0].properties.state_name
            });
          });
          res.status(200).json({
            count: ls.length,
            states: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.getOneState = (req, res, next) => {
    const stateName = req.params.stateName;
    session
        .run(`MATCH(n: State{state_name: '${stateName}'}) RETURN n`)
        .then((result)=>{
          res.status(200).json({
            _id: result.records[0]._fields[0].identity.low,
            state_name: result.records[0]._fields[0].properties.state_name
          });
        })
        .catch(error => {
          console.log(error);
        })
};
