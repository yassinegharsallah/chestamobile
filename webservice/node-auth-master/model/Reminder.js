const mongoose = require("mongoose");

const ReminderSchema = mongoose.Schema({
    texte: {
        type: String
    },
    iduser: {
        type: String
    },
    date: {
        type: String
    },
    heure: {
        type: String
    }
},{
    collection: 'Reminder'
});

// export model user with UserSchema
module.exports = mongoose.model("Reminder", ReminderSchema);
