module.exports = Object.freeze({
    "app": {
        "path": "/angularJS",
        "port": 3000
    },
    "fcm": {
        "key": "AAAA2VcT0Us:APA91bFvwtedpzV085Juhb4KDUZVuTE6i72gzYpCoTTJtwpgAdVwK0cCRvPKiY0Qc8rXSCswJgQiU0QRc8OnOuZ59jw_bOD4YKsumJfN9volSm1Iwi3TQBBvUhJYV94ZeRcRgxT9f5S4"
    },
    "firebase": {
        "apiKey": "AIzaSyCJ77ieQUpmBm-zbP5KxJARA-Hc-bSM1TU",
        "authDomain": "timer-express.firebaseapp.com",
        "databaseURL": "https://timer-express.firebaseio.com",
        "storageBucket": "timer-express.appspot.com"
    },
    "jwt": {
        "secretOrKey": "timer-app-jwt"
    },
    "bcrypt": {
        "rounds": 10
    },
    "jade": {
        "sitename": "TimerApp",
        "description": "Time management application",
        "logo": "alarm_on",
        "titles": {
            "users": "Users",
            "add_user": "Add user",
            "edit_user": "Edit user",
            "times": "Times",
            "time": "Time",
            "set_time": "Set time",
            "closed_time": "Closed time",
            "current_time": "Current time",
            "start": "Start",
            "stop": "Stop",
            "total": "Total",
            "striked": "Striked",
            "groups": "Groups",
            "add_group": "Add group",
            "edit_groups": "Edit groups",
            "edit_group": "Edit group"
        },
        "form": {
            "submit": "Submit",
            "placeholders": {
                "name": "Name",
                "password": "Password",
                "email": "Email",
                "description": "Description",
                "select_group": "Select group",
                "comment": "Comment"
            }
        },
        "actions": {
            "refresh": {
                "title": "Refresh",
                "icon": "update"
            }
        },
        "errors": {
            "error": "Error",
            "no_location": "Start location not set"
        },
        "icons": {
            "login": "account_circle"
        },
        "copyright": "©jonnsmith @vardinika"
    },
    "fixtures": {
        "group": {
            "id": 0,
            "title": "Basic group",
            "description": "Group for initiation",
            "moderator_id": 0
        },
        "user": {
            "id": 0,
            "name": "Admin",
            "email": "admin@timer.com",
            "password": "timer!app",
            "token": null,
            "group_id": 0,
            "is_super_admin": true
        },
        "time": {
            "id": 0,
            "start": null,
            "end": null,
            "user_id": 0,
            "is_strike": false,
            "comment": "Comment",
            "start_location": {
                "latitude": "51.5285582",
                "longitude": "-0.2416796,11",
                "accuracy": "105"
            },
            "end_location": {
                "latitude": "51.5285582",
                "longitude": "-0.2416796,11",
                "accuracy": "105"
            },
            "start_ip": "127.0.0.1",
            "end_ip": "127.0.0.1"
        }
    }
});