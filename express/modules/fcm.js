const FCM = require('fcm-node');
const config = require('./config');

let fcmService = {};
fcmService.fcm = {};

/**
 * FCM helper module to send FCM pushes from NodeJS application
 */

/**
 * Send message function
 * @param token FCM specific device token
 * @param title Push message title
 * @param body Push message body
 * @param url Push message url data for client app callback
 * @param image Image url for display in push message
 */
fcmService.sendMessage = function(token, title, body, url, image) {
    fcmService.fcm = new FCM(config.fcm.key);
    let message = {
        to: token,
        priority: "high",
        restricted_package_name: "",
        data: {
            url: url,
            body: body,
            title: title,
            image: image,
            badge: 1
        }
    };
    console.log('message', message);
    fcmService.fcm.send(message, function(err, response){
        if (err) {
            console.log('fcm error', err);
            return err;
        } else {
            console.log('fcm response', response);
            return response;
        }
    });
};

module.exports = fcmService;