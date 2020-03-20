const express = require("express");
const { check, validationResult } = require("express-validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const router = express.Router();
const auth = require("../middleware/auth");

const User = require("../model/User");
const Rendezvous = require("../model/RendezVous");

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
router.get("/GetAllMedecins", async (req, res) => {
  try {
    // request.user is getting fetched from Middleware after token authentication

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
/*find user by id*/
/**
 * @method - GET
 * @description - Get Logged
 * @param - /user/GetAllMedecins
 */
router.get("/GetAllMedecins", async (req, res) => {
  try {
    // request.user is getting fetched from Middleware after token authentication

    var query = { adresse: "ouardia" };
    const user = await User.find(query);
    res.json(user);
  } catch (e) {
    res.send({ message: "Error in Fetching user" });
  }
});

/* Get Rendez Vous By id */
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
    res.json(rdv);
  } catch (e) {
    res.send({ message: "Error in Fetching rendez vous" });
  }
});
/* Get Rendez Vous By id*/

module.exports = router;
