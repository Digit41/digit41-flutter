importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyBgeGijVEBkSa80UnbTmTULVITOlzJlxgo",
    authDomain: "digit41.firebaseapp.com",
    projectId: "digit41",
    storageBucket: "digit41.appspot.com",
    messagingSenderId: "321902183870",
    appId: "1:321902183870:web:625724399fb66c450765ef",
    measurementId: "G-2Y8KKDGS1E"
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});