const mongoose = require("mongoose");

const AccessPatientMedecinSchema = mongoose.Schema({
    idpatient: {
        type: String
    },
    idmedecin: {
        type: String
    },
    etat: {
        type: String
    },
    date: {
        type: Date
    }
},{
    collection: 'AccessPatientMedecin'
});

// export model user with UserSchema
module.exports = mongoose.model("AccessPatientMedecin", AccessPatientMedecinSchema);
