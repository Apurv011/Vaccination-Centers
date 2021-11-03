const neo4j = require('neo4j-driver');
require("dotenv").config();

var driver = neo4j.driver(process.env.DATABASE_URL_CLOUD, neo4j.auth.basic(process.env.DATABASE_USER, process.env.DATABASE_PASSWORD));
var session = driver.session();

exports.getAllCenters = (req, res, next) => {
    const ls = [];
    session
        .run('MATCH(n: Center) RETURN n')
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
              _id: record._fields[0].identity.low,
              center_id: record._fields[0].properties.center_id.low,
							name: record._fields[0].properties.name,
              district_name: record._fields[0].properties.district_name,
              state_name: record._fields[0].properties.state_name,
              location: record._fields[0].properties.location,
              pincode: record._fields[0].properties.pincode.low,
              block_name: record._fields[0].properties.block_name,
              lat: record._fields[0].properties.lat,
              long: record._fields[0].properties.long
            });
          });
          res.status(200).json({
            count: ls.length,
            centers: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.getCenterByID = (req, res, next) => {
    const id = req.params.centerId;
    session
        .run(`MATCH(n: Center{center_id: ${id}}) RETURN n`)
        .then((result)=>{
          res.status(200).json({
            _id: result.records[0]._fields[0].identity.low,
						center_id: result.records[0]._fields[0].properties.center_id.low,
						name: result.records[0]._fields[0].properties.name,
						district_name: result.records[0]._fields[0].properties.district_name,
						state_name: result.records[0]._fields[0].properties.state_name,
						location: result.records[0]._fields[0].properties.location,
						pincode: result.records[0]._fields[0].properties.pincode.low,
						block_name: result.records[0]._fields[0].properties.block_name,
						lat: result.records[0]._fields[0].properties.lat,
						long: result.records[0]._fields[0].properties.long
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.centersInDistrict = (req, res, next) => {
    const ls = [];
    const district_name = req.params.districtName;
    session
        .run(`MATCH(n: Center{district_name: '${district_name}'}) RETURN n`)
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
							_id: record._fields[0].identity.low,
              center_id: record._fields[0].properties.center_id.low,
							name: record._fields[0].properties.name,
              district_name: record._fields[0].properties.district_name,
              state_name: record._fields[0].properties.state_name,
              location: record._fields[0].properties.location,
              pincode: record._fields[0].properties.pincode.low,
              block_name: record._fields[0].properties.block_name,
              lat: record._fields[0].properties.lat,
              long: record._fields[0].properties.long
            });
          });
          res.status(200).json({
            count: ls.length,
            district: district_name,
            centers: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.centersInState = (req, res, next) => {
    const ls = [];
    const state_name = req.params.stateName;
    session
        .run(`MATCH(n: Center{state_name: '${state_name}'}) RETURN n`)
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
							_id: record._fields[0].identity.low,
              center_id: record._fields[0].properties.center_id.low,
							name: record._fields[0].properties.name,
              district_name: record._fields[0].properties.district_name,
              state_name: record._fields[0].properties.state_name,
              location: record._fields[0].properties.location,
              pincode: record._fields[0].properties.pincode.low,
              block_name: record._fields[0].properties.block_name,
              lat: record._fields[0].properties.lat,
              long: record._fields[0].properties.long
            });
          });
          res.status(200).json({
            count: ls.length,
            state: state_name,
            centers: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.centersByPincode = (req, res, next) => {
    const ls = [];
    const pincode = req.params.pincode;
    session
        .run(`MATCH(n: Center{pincode: ${pincode}}) RETURN n`)
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
							_id: record._fields[0].identity.low,
              center_id: record._fields[0].properties.center_id.low,
							name: record._fields[0].properties.name,
              district_name: record._fields[0].properties.district_name,
              state_name: record._fields[0].properties.state_name,
              location: record._fields[0].properties.location,
              pincode: record._fields[0].properties.pincode.low,
              block_name: record._fields[0].properties.block_name,
              lat: record._fields[0].properties.lat,
              long: record._fields[0].properties.long
            });
          });
          res.status(200).json({
            count: ls.length,
            pincode: pincode,
            centers: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.centerNearMe = (req, res, next) => {
    const ls = [];
    const lat = req.params.lat;
  	const long = req.params.long;
    session
        .run(`MATCH(n: Center)
            WITH n AS center, point({longitude: n.long, latitude: n.lat}) AS p1, point({longitude: ${long}, latitude: ${lat}}) AS p2
            RETURN center, distance(p1, p2) AS distance
            ORDER BY distance
            LIMIT 30`)
        .then((result)=>{
          result.records.forEach((record, i) => {
            ls.push({
							_id: record._fields[0].identity.low,
              center_id: record._fields[0].properties.center_id.low,
							name: record._fields[0].properties.name,
              district_name: record._fields[0].properties.district_name,
              state_name: record._fields[0].properties.state_name,
              location: record._fields[0].properties.location,
              pincode: record._fields[0].properties.pincode.low,
              block_name: record._fields[0].properties.block_name,
              lat: record._fields[0].properties.lat,
              long: record._fields[0].properties.long,
              distance: parseFloat((record._fields[1])/1000).toFixed(2)
            });
          });
          res.status(200).json({
            count: ls.length,
            centers: ls
          });
        })
        .catch(error => {
          console.log(error);
        })
};

exports.centerByLatLong = (req, res, next) => {
	const lat = req.params.lat;
	const long = req.params.long;
	session
			.run(`MATCH(n: Center{lat: ${lat}, long: ${long}}) RETURN n`)
			.then((result)=>{
				res.status(200).json({
					_id: result.records[0]._fields[0].identity.low,
					center_id: result.records[0]._fields[0].properties.center_id.low,
					name: result.records[0]._fields[0].properties.name,
					district_name: result.records[0]._fields[0].properties.district_name,
					state_name: result.records[0]._fields[0].properties.state_name,
					location: result.records[0]._fields[0].properties.location,
					pincode: result.records[0]._fields[0].properties.pincode.low,
					block_name: result.records[0]._fields[0].properties.block_name,
					lat: result.records[0]._fields[0].properties.lat,
					long: result.records[0]._fields[0].properties.long
				});
			})
			.catch(error => {
				console.log(error);
			})
};
