const neo4j = require('neo4j-driver');
require("dotenv").config();

var driver = neo4j.driver(process.env.DATABASE_URL, neo4j.auth.basic(process.env.DATABASE_USER, process.env.DATABASE_PASSWORD));
var session = driver.session();

exports.getAllDistricts = (req, res, next) => {
    const ls = [];
    session
        .run('MATCH(n: District) RETURN n')
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
              _id: record._fields[0].identity.low,
              district_name: record._fields[0].properties.district_name,
              state_name: record._fields[0].properties.state_name
            });
          });
          res.status(200).json({
            count: ls.length,
            districts: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.getOneDistrict = (req, res, next) => {
    const dName = req.params.dName;
    session
        .run(`MATCH(n: District{district_name: '${dName}'}) RETURN n`)
        .then((result)=>{
          res.status(200).json({
            _id: result.records[0]._fields[0].identity.low,
            district_name: result.records[0]._fields[0].properties.district_name,
            state_name: result.records[0]._fields[0].properties.state_name
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.getDistrictsInState = (req, res, next) => {
    const ls = [];
    const stateName = req.params.stateName;
    session
        .run(`MATCH(n: District{state_name: '${stateName}'}) RETURN n`)
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
              _id: record._fields[0].identity.low,
              district_name: record._fields[0].properties.district_name,
              state_name: record._fields[0].properties.state_name
            });
          });
          res.status(200).json({
            count: ls.length,
            state: stateName,
            districts: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};
