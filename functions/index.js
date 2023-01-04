const functions = require('firebase-functions');
const admin = require('firebase-admin')
admin.initializeApp();

const fireStore = admin.fireStore();

exports.onUserStatusChange = functions.database
  .ref('/{uid}/active')
  .onUpdate(async (change, context) => {
    // Get the data written to Realtime Database
    const isOnline = change.after.val();

    // Get a reference to the Firestore document
    const userStatusFireStoreRef = fireStore.doc(`users/${context.params.uid}`);

    console.log(`status: ${isOnline}`);

    // Update the values on Firestore
    return userStatusFireStoreRef.update({
      active: isOnline,
      lastSeen: Date.now(),
    });
  });