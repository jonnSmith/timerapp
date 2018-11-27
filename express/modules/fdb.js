const firebase = require('firebase');
const config = require('./config');

/**
 * Firebase DB helper module for data processing
 */

// Configure and initialize FDB
firebase.initializeApp(config.firebase);
let dbService = {};
const db = firebase.database().ref();
/**
 * Write item to db into specified folder with unique id key
 * @param data Item data object
 * @param path Item storage path
 * @param id Item unique id key
 * @returns {firebase.Promise.<void>} Fulfilled then FDB successfully add item
 */
dbService.setItemInFolder = function(data, path, id) {
    let item = db.child(path).child(id);
    return item.set(data);
};

/**
 * Delete item from folder by unique id key
 * @param path Item storage path
 * @param id Item unique id key
 * @returns {firebase.Promise.<void>} Fulfilled then FDB successfully delete item
 */
dbService.deleteItemFromFolder = function(path, id) {
    let item = db.child(path).child(folder).child(id);
    return item.remove();
};

/**
 * Get items array from specified folder
 * @param path Item storage path
 * @returns {Promise}  Fulfilled then FDB successfully read items array from folder
 */
dbService.getItemsFromFolder = function(path) {
    let rows = db.child(path);
    return new Promise((res) => {
        rows.once("value", (snapshot) => {
            res(snapshot.val());
        });
    });
};

/**
 * Get item from specified folder by unique id key
 * @param path Item storage path
 * @param id Item unique id key
 * @returns {Promise} Fulfilled then FDB successfully read item from folder by id key
 */
dbService.getItemById = function(path, id) {
    let rows = db.child(path).child(id);
    return new Promise((res) => {
        rows.once("value", (snapshot) => {
            res(snapshot.val());
        });
    });
};

/**
 * Get item from specified folder by key-value pare
 * @param path Item storage path
 * @param key Field key
 * @param value Field value
 * @returns {Promise} Fulfilled then FDB successfully read item from folder
 */
dbService.getItemByField = function(path, key, value) {
    let rows = db.child(path).orderByChild(key).equalTo(value);
    return new Promise((res) => {
        rows.once("value", (snapshot) => {
            res(snapshot.val()[0]);
        });
    });
};

/**
 * Update item from specified folder by key with new value
 * @param path Item storage path
 * @param id Item unique id key
 * @param key Field key
 * @param value Field value
 * @returns {Promise} Fulfilled then FDB successfully update item
 */
dbService.updateItemFieldById = function(path, id, key, value) {
    let rows = db.child(path).child(id);
    return rows.update({key: value});
};

/**
 * Update item from specified folder by key with new value
 * @param path Item storage path
 * @param field Search field
 * @param val Search val
 * @param key Field key
 * @param value Field value
 * @returns {Promise} Fulfilled then FDB successfully update item
 */
dbService.updateItemFieldByKey = function(path, field, val, key, value) {
    let rows = db.child(path).orderByChild(field).equalTo(val);
    return rows.update({key: value});
};

/**
 * Update item from specified folder
 * @param path Item storage path
 * @param id Item unique id key
 * @param item Item object
 * @returns {Promise} Fulfilled then FDB successfully update item
 */
dbService.updateItemById = function(path, id, item) {
    let rows = db.child(path).child(id);
    return rows.update(item);
};

module.exports = dbService;
