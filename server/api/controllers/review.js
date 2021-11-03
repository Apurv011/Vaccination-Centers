const neo4j = require('neo4j-driver');
require("dotenv").config();

var driver = neo4j.driver(process.env.DATABASE_URL_CLOUD, neo4j.auth.basic(process.env.DATABASE_USER, process.env.DATABASE_PASSWORD));
var session = driver.session();

exports.getAllReviews = (req, res, next) => {
    const ls = [];
    session
        .run('MATCH(n: Review) RETURN n')
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
              _id: record._fields[0].identity.low,
              username: record._fields[0].properties.username,
              rating: record._fields[0].properties.rating,
              review: record._fields[0].properties.review,
              date: record._fields[0].properties.date,
              center_id: record._fields[0].properties.center_id.low
            });
          });
          res.status(200).json({
            count: ls.length,
            reviews: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.getReviewByCenter = (req, res, next) => {
    const ls = [];
    const centerId = req.params.centerId;
    session
        .run(`MATCH(n: Review{center_id: ${centerId}}) RETURN n`)
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
              _id: record._fields[0].identity.low,
              username: record._fields[0].properties.username,
              rating: record._fields[0].properties.rating,
              review: record._fields[0].properties.review,
              date: record._fields[0].properties.date,
              center_id: record._fields[0].properties.center_id.low
            });
          });
          res.status(200).json({
            count: ls.length,
            reviews: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.writeReview = (req, res, next) => {

  session
      .run(`MATCH (a:Center {center_id: ${req.body.center_id}})
            CREATE (b: Review {username:"${req.body.username}",
                              date:"${req.body.date}",
                              review: "${req.body.review}",
                              rating: "${req.body.rating}",
                              center_id: ${req.body.center_id}}),
            (b)-[:review_of]->(a) RETURN a,b`)
      .then((result)=>{
        res.status(200).json({
          message: 'Review Added Successfully!',
          review_description: {
            _id: result.records[0]._fields[0].identity.low,
            username: result.records[0]._fields[0].properties.username,
            rating: result.records[0]._fields[0].properties.rating,
            review: result.records[0]._fields[0].properties.review,
            date: result.records[0]._fields[0].properties.date,
            center_id: result.records[0]._fields[0].properties.center_id.low
          }
        });
      })
      .catch(error => {
        console.log(error);
      })
};
