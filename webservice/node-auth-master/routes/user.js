const express = require("express");
const { check, validationResult } = require("express-validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const router = express.Router();
const auth = require("../middleware/auth");
var cors = require('cors'); // We will use CORS to enable cross origin domain requests.
const User = require("../model/User");
const Rendezvous = require("../model/RendezVous");
const Reminder = require("../model/Reminder");
const Suivi = require("../model/Suivi");
const AccessPatientMedecin  = require("../model/AccessPatientMedecin");
/**
 * @method - POST
 * @param - /signup
 * @description - User SignUp
 */

router.post(
  "/signup",
  [
    check("username", "Please Enter a Valid Username")
      .not()
      .isEmpty(),
    check("email", "Please enter a valid email").isEmail(),
    check("password", "Please enter a valid password").isLength({
      min: 6
    })
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        errors: errors.array()
      });
    }

    const { username, email, password } = req.body;
    try {
      let user = await User.findOne({
        email
      });
      if (user) {
        return res.status(400).json({
          msg: "User Already Exists"
        });
      }

      user = new User({
        username,
        email,
        password
      });

      const salt = await bcrypt.genSalt(10);
      user.password = await bcrypt.hash(password, salt);

      await user.save();

      const payload = {
        user: {
          id: user.id
        }
      };

      jwt.sign(
        payload,
        "randomString",
        {
          expiresIn: 10000
        },
        (err, token) => {
          if (err) throw err;
          res.status(200).json({
            token
          });
        }
      );
    } catch (err) {
      console.log(err.message);
      res.status(500).send("Error in Saving");
    }
  }
);

router.post(
  "/login",
  [
    check("email", "Please enter a valid email").isEmail(),
    check("password", "Please enter a valid password").isLength({
      min: 6
    })
  ],
  async (req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(400).json({
        errors: errors.array()
      });
    }

    const { email, password } = req.body;
    try {
      let user = await User.findOne({
        email
      });
      if (!user)
        return res.status(400).json({
          message: "User Not Exist"
        });

      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch)
        return res.status(400).json({
          message: "Incorrect Password !"
        });

      const payload = {
        user: {
          id: user.id
        }
      };

      jwt.sign(
        payload,
        "randomString",
        {
          expiresIn: 3600
        },
        (err, token) => {
          if (err) throw err;
          res.status(200).json({
            token
          });
        }
      );
    } catch (e) {
      console.error(e);
      res.status(500).json({
        message: "Server Error"
      });
    }
  }
);

/**
 * @method - POST
 * @description - Get LoggedIn User
 * @param - /user/me
 */

router.get("/me", auth, async (req, res) => {
  try {
    // request.user is getting fetched from Middleware after token authentication
    const user = await User.findById(req.user.id);
    res.json(user);
  } catch (e) {
    res.send({ message: "Error in Fetching user" });
  }
});

/**
 * @method - GET
 * @description - Get LoggedIn User
 * @param - /user/GetAllMedecins
 */
router.get("/GetAllMedecins", cors(), async (req, res) => {
  try {
    // request.user is getting fetched from Middleware after token authentication
    res.setHeader('Access-Control-Allow-Origin', 'http://localhost:4200');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE'); // If needed
// res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type'); // If needed
    res.setHeader('Access-Control-Allow-Credentials', true); // If needed


    console.log(res.headers);
    var query = { adresse: "ouardia" };
    const user = await User.find(query);
    res.json(user);
  } catch (e) {
    res.send({ message: "Error in Fetching user" });
  }
});

/**
 * @method - POST
 * @param - /AddRdv
 * @description - Rendezvous AddRdv
 */

router.post(

    "/AddRdv",
    async (req, res) => {
console.log(req.body);
      const { idmedecin, idpatient } = req.body;
      try {


        Rdv = new Rendezvous({
          idpatient,
          idmedecin
        });

        var mongoose = require('mongoose');

        mongoose.connect('mongodb+srv://root:root@cluster0-h1nmu.mongodb.net/angular-node?retryWrites=true&w=majority');
        var conn = mongoose.connection;
        conn.collection('Rendezvous').insert(Rdv);

     res.send('Rendez vous added successfully');

      } catch (err) {
        console.log(err.message);
        res.status(500).send("Error in Saving");
      }
    }
);

/**
 * @method - POST
 * @param - /AddRdv
 * @description - Rendezvous AddRdv
 */

router.post(

    "/AddRdv",
    async (req, res) => {
      console.log('HERE HERE HERE HERE HERE');

      console.log(req.body);
      const { idmedecin, idpatient } = req.body;
      try {

        Rdv = new Rendezvous({
          idpatient,
          idmedecin
        });

        var mongoose = require('mongoose');

        mongoose.connect('mongodb+srv://root:root@cluster0-h1nmu.mongodb.net/angular-node?retryWrites=true&w=majority');
        var conn = mongoose.connection;
        conn.collection('Rendezvous').insert(Rdv);

        res.send('Rendez vous added successfully');

      } catch (err) {
        console.log(err.message);
        res.status(500).send("Error in Saving");
      }
    }
);

/* Get Rendez Vous By id*/
/**
 * @method - GET
 * @description - Get Rendez vous Medecin
 * @param - /user/GetRdvMedecin
 */
router.get("/GetRdvMedecin", async (req, res) => {
  try {
    var host = req.headers['token'];
    console.log(host);
    var query = { idmedecin : host };
    const rdv = await Rendezvous.find(query);
    console.log(rdv);
    res.json(rdv);
  } catch (e) {
    res.send({ message: "Error in Fetching rendez vous" });
  }
});
/* Get Rendez Vous By id*/


//GET USER INFO BY ID
/**
 * @method - GET
 * @description - GetUserByID
 * @param - /user/GetUserByID
 */
router.get("/GetUserByID", async (req, res) => {
  try {
    var host = req.headers['token'];
    var query = { _id : host };
    const rdv = await User.find(query);
    res.json(rdv);
  } catch (e) {``
    res.send({ message: "Error in Fetching rendez vous" });
  }
});
//GET USER INFO BY ID

//Get Rendez Vous info
/**
 * @method - GET
 * @description - GetUserByID
 * @param - /user/GetUserByID
 */
router.get("/GetRdvByID", async (req, res) => {
  try {
    var host = req.headers['token'];
    var query = { _id : host };
    const rdv = await Rendezvous.find(query);
    res.json(rdv);
  } catch (e) {``
    res.send({ message: "Error in Fetching rendez vous" });
  }
});
//Get Rendez vous info

//supprimer rendez vous
/**
 * @method - DELETE
 * @description - DeleteRdvByID
 * @param - /user/DeleteRdvByID
 */
router.delete("/DeleteRdvByID", async (req, res) => {
  try {
    var host = req.headers['token'];
    var query = { _id : host };
    const rdv = await Rendezvous.deleteOne(query);
    res.json(rdv);
  } catch (e) {``
    res.send({ message: "Error in Fetching rendez vous" });
  }
});
//supprimer rendez vous

//update rendez vous
/**
 * @method - PUT
 * @description - UpdateRdvByID
 * @param - /user/UpdateRdvByID
 */
router.put("/UpdateRdvByID", async (req, res) => {
  try {
    var host = req.headers['token'];
    var etat = req.headers['etat'];
    var query = { _id : host };
console.log('id'+host);
console.log('etat'+etat);
    const rdv = await Rendezvous.updateOne(query,{etat:etat.toString()});
    res.json(rdv);
  } catch (err) {
    console.log(err) ;
    console.log(err) ;
    res.send({ message: "Error in Fetching rendez vous"+err});
  }
});
//update rendez vous

//Get Rendez Vous by date
/**
 * @method - GET
 * @description - GetRdvByDate
 * @param - /user/GetRdvByDate
 */
router.get("/GetRdvByDate", async (req, res) => {
  try {
    var host = req.headers['token'];
     host = host.substring(0,23)+'+00:00';
     console.log(host);
    var query = {date : host };
    const rdv = await Rendezvous.find(query);
    res.json(rdv);
  } catch (e) {
    res.send({ message: "Error in Fetching rendez vous"+e});
  }
});
//Get Rendez vous by date

//add Reminder
/**
 * @method - POST
 * @description - AddReminder
 * @param - /user/AddReminder
 */
router.post("/AddReminder", async (req, res) => {

    console.log(req.body) ;
    const {texte, iduser, date , heure } = req.body;
    try {

      Rdv = new Reminder({
        texte, iduser, date , heure
      });

      var mongoose = require('mongoose');
      mongoose.connect('mongodb+srv://root:root@cluster0-h1nmu.mongodb.net/angular-node?retryWrites=true&w=majority');
      var conn = mongoose.connection;
      conn.collection('Reminder').insert(Rdv);

      res.send('Rendez vous added successfully');

  } catch (e) {
    res.send({ message: "Error in Fetching rendez vous"+e});
  }
});
//Add Reminder

//Add Suivi
/**
 * @method - POST
 * @description - AddSuivi
 * @param - /user/AddSuivi
 */
router.post("/AddSuivi", async (req, res) => {

  console.log(req.body) ;
  const {description,dueDate,dueTime } = req.body;
  try {

    Suv = new Suivi({
      description,dueDate,dueTime
    });

    var mongoose = require('mongoose');
    mongoose.connect('mongodb+srv://root:root@cluster0-h1nmu.mongodb.net/angular-node?retryWrites=true&w=majority');
    var conn = mongoose.connection;
    conn.collection('suivis').insert(Suv);

    res.send('Suivi vous added successfully');

  } catch (e) {
    res.send({ message: "Error in Fetching suivis"+e});
  }
});
//Add Suivi


//Get Suivis
/**
 * @method - GET
 * @description - GetSuivi
 * @param - /user/GetSuivi
 */
router.get("/GetSuivi", async (req, res) => {
  try {
    /*var host = req.headers['token'];
    host = host.substring(0,23)+'+00:00';
    console.log(host);
    var query = {date : host }; */
    const rdv = await Suivi.find();
    res.json(rdv);
  } catch (e) {
    res.send({ message: "Error in Fetching Suivis"+e});
  }
});
//Get Suivis

//GET RENDEZ VOUS BY ID PATIENT
/**
 * @method - GET
 * @description - Get Rendez vous patient
 * @param - /user/GetRdvPatient
 */
router.get("/GetRdvPatient", async (req, res) => {
  try {
    var host = req.headers['token'];
    console.log(host);
    var query = { idpatient : host };
    const rdv = await Rendezvous.find(query);
    console.log(rdv);
    res.json(rdv);
  } catch (e) {
    res.send({ message: "Error in Fetching rendez vous" });
  }
});
//GET RENDEZ VOUS BY ID PATIENT


//get all patients
/**
 * @method - GET
 * @description - Get all Rendez vous
 * @param - /user/GetAllPatients
 */
router.get("/GetAllPatients", async (req, res) => {
  try {
    var host = req.headers['token'];
    console.log(host);
    var query = { nom : host };
    const rdv = await User.find(query);
    res.json(rdv);
  } catch (e) {
    res.send({ message: "Error in Fetching GetAllPatients" });
  }
});
//get all patients

//Add new Access invitation Medecin Patient
/**
 * @method - POST
 * @param - /AddAccess
 * @description - Rendezvous AddRdv
 */

router.post(
    "/AddAccessPatientMedecin",
    async (req, res) => {
      console.log(req.body);
      const { idmedecin, idpatient } = req.body;
      var etat = 'Annuler' ;
      var currenDate = new Date() ;
      try {
        Rdv = new AccessPatientMedecin({
          idpatient,
          idmedecin,
          etat,
          currenDate
        });

        var mongoose = require('mongoose');

        mongoose.connect('mongodb+srv://root:root@cluster0-h1nmu.mongodb.net/angular-node?retryWrites=true&w=majority');
        var conn = mongoose.connection;
        conn.collection('AccessPatientMedecin').insert(Rdv);

        res.send('AccessPatientMedecin added successfully');

      } catch (err) {
        console.log(err.message);
        res.status(500).send("Error in Saving");
      }
    }
);

//Add new Access invitation Medecin Patient

//GET ALL ACCESS MEDECIN PATIENT
/**
 * @method - GET
 * @description - Get all Rendez vous
 * @param - /user/GetAccessedPatients
 */
router.get("/GetAccessedPatients", async (req, res) => {
  try {
    var idmedecin = req.headers['idmedecin'];
    var query = { idmedecin : idmedecin , etat : 'confirmer'};
    const rdv = await AccessPatientMedecin.find(query);
    res.json(rdv);
  } catch (e) {
    res.send({ message: "Error in Fetching GetAllPatients" });
  }
});
//GET ALL ACCESS MEDECIN PATIENT


//Get Suivis by id patient
/**
 * @method - GET
 * @description - GetSuiviByidPatient
 * @param - /user/GetSuiviByidPatient
 */
router.get("/GetSuiviByidPatient", async (req, res) => {
  try {
    var host = req.headers['token'];
    console.log(host);
    var query = {idPatient : host };
    const rdv = await Suivi.find(query);
    res.json(rdv);
  } catch (e) {
    res.send({ message: "Error in Fetching Suivis"+e});
  }
});
//Get Suivis by id patient


//Add Remarque Suivi Patient

/**
 * @method - PUT
 * @description - UpdateSuiviRemarque
 * @param - /user/UpdateSuiviRemarque
 */
router.put("/UpdateSuiviRemarque", async (req, res) => {
  try {
    var host = req.headers['token'];
    var remarque = req.headers['remarque'];
    var query = { _id : host };
    console.log(host+remarque);
    const rdv = await Suivi.updateOne(query,{remarque: remarque });
    res.json(rdv);
  } catch (err) {
    console.log(err) ;
    res.send({ message: "Error in updating suivis"+err});
  }
});

//Add Remarque Suivi Patient

//Get invitations Access patient
/**
 * @method - GET
 * @description - GetInvitation
 * @param - /user/GetInvitation
 */
router.get("/GetInvitation", async (req, res) => {
  try {
    var host = req.headers['token'];
    console.log(host);
    var query = {idpatient : host };
    const rdv = await AccessPatientMedecin.find(query);
    res.json(rdv);
  } catch (e) {
    res.send({ message: "Error in Fetching Access patient"+e});
  }
});
//Get invitations  Access patient


module.exports = router;
