import firebase from "firebase";
import config from '../config.json'

/**
 * Firebase DB helper module for data processing
 */

// Configure and initialize FDB
firebase.initializeApp(config.firebase.config);
let dbService = {};
const db = firebase.database().ref();
const events = db.child("events");
/**
 * Write item to db into specified folder with unique id key
 * @param layer Basic folder by REST API layer
 * @param data Item data object
 * @param folder Item storage folder
 * @param id Item unique id key
 * @returns {firebase.Promise.<void>} Fulfilled then FDB successfully add item
 */
dbService.setItemInFolder = function(layer, data, folder, id) {
    let item = db.child(layer).child(folder).child(id);
    return item.set(data);
};

/**
 * Delete item from folder by unique id key
 * @param layer Basic folder by REST API layer
 * @param data Item data object
 * @param folder Item storage folder
 * @param id Item unique id key
 * @returns {firebase.Promise.<void>} Fulfilled then FDB successfully delete item
 */
dbService.deleteItemFromFolder = function(layer, data, folder, id) {
    let item = db.child(layer).child(folder).child(id);
    return item.remove();
};

/**
 * Get items array from specified folder
 * @param layer Basic folder by REST API layer
 * @param folder Item storage folder
 * @returns {Promise}  Fulfilled then FDB successfully read items array from folder
 */
dbService.getItemsFromFolder = function(layer, folder) {
    let rows = db.child(layer).child(folder);
    return new Promise((res) => {
        rows.once("value", function (snapshot) {
            res(snapshot.val());
        });
    });
};

/**
 * Get item from specified folder by unique id key
 * @param layer Basic folder by REST API layer
 * @param folder Item storage folder
 * @param id Item unique id key
 * @returns {Promise} Fulfilled then FDB successfully read item from folder by id key
 */
dbService.getItemById = function(layer, folder, id) {
    let rows = db.child(layer).child(folder).child(id);
    return new Promise((res) => {
        rows.once("value", function (snapshot) {
            res(snapshot.val());
        });
    });
};

module.exports = dbService;
