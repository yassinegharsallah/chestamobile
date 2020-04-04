const mongoose = require("mongoose");

const suivisSchema = mongoose.Schema({
    objet: {
        type: String
    },
    date: {
        type: Date
    },
    details: {
        type: String
    },
    idmedecin: {
        type: String
    },
    idpatient: {
        type: String
    },
    remarque: {
        type: String
    },
},{
    collection: 'suivis'
});

// export model user with UserSchema
module.exports = mongoose.model("suivis", suivisSchema);
