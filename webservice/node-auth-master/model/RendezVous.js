const mongoose = require("mongoose");

const RendezvousSchema = mongoose.Schema({
    idpatient: {
        type: String
    },
    idmedecin: {
        type: String
    }
},{
    collection: 'Rendezvous'
});

// export model user with UserSchema
module.exports = mongoose.model("Rendezvous", RendezvousSchema);
