# Telereso


[![npm](https://img.shields.io/npm/v/telereso-web.svg)](https://www.npmjs.com/package/telereso-web)

npm package to use [Telereso](https://telereso.io?utm_source=npm&utm_medium=readme-web&utm_campaign=normal),

[Telereso](https://telereso.io?utm_source=npm&utm_medium=readme-web&utm_campaign=normal) will allow you to control your app
resources (strings,images) remotely and out of the box , without the need to add extra logic.

## Installation

[Telereso](https://telereso.io?utm_source=npm&utm_medium=readme-web&utm_campaign=normal) depends on Firebase to
use [Remote Config](https://firebase.google.com/docs/remote-config/) for resource management<br>

All you need to get started is make sure your project has set up firebase ([check docs](https://firebase.google.com/docs/web/setup)), <br>
Setup `i18n` as usual ([check package](https://www.npmjs.com/package/i18n-js))
<br>
Then add `Telereso` dependency to your project

```shell
# Using npm
npm install telerso-web
```

```shell
# Using Yarn
yarn add telerso-web
```

## Usage

### Initialization

Make sure your already set up your normal localization
using [i18n](https://www.npmjs.com/package/i18n-js)

There are 2 options to initialization :

1. `init()`  
   Will not make api calls, it's just to set up resources, In your `index.js` file, call `init()` and make sure to
   pass `i18n` and `firebase` object:

   ```
   import i18n from "./i18n";
   import {Telereso} from "telereso-web";
   import firebase from "firebase/app";
   import App from "./App";
   
   // Initialize Firebase
   const firebaseConfig = {
       apiKey: process.env.REACT_APP_FIREBASE_APIKEY,
       authDomain: process.env.REACT_APP_FIREBASE_AUTH_DOMAIN,
       projectId: process.env.REACT_APP_FIREBASE_PROJECT_ID,
       storageBucket: process.env.REACT_APP_FIREBASE_STORAGE_BUCKET,
       messagingSenderId: process.env.REACT_APP_FIREBASE_MESSAGING_SENDER_ID,
       appId: process.env.REACT_APP_FIREBASE_APP_ID,
       measurementId: process.env.REACT_APP_FIREBASE_MEASUREMENT_ID,
   };
   firebase.initializeApp(firebaseConfig)
   Telereso.init(i18n,firebase);

   ReactDOM.render(
   <React.StrictMode>
        <App/>
   </React.StrictMode>,
   document.getElementById('root')
   );
      
   ```

2. `susbundedinit()`  
   Will make sure to fetch the latest changes from Remote Config and not to start the app unless all resources are
   ready.
   firebase should be setup in `index.js` check previous option

   ```
   import i18n from "./i18n";
   import {Telereso} from "telereso-web";
   import firebase from "firebase/app";
   
   
   export default class App extends React.Component {
   
       state = {
           splashFinished: false
       }
   
       componentDidMount() {
           Telereso.suspendedInit(i18n,firebase).then(() => {
               this.setState({
                   splashFinished: true
               })
           });
       }
   
       render() {
           return (this.state.splashFinished ? <Home/> : <label>Loading...</label>);
       }
   }
   ```
   For loading state you can choose your own splash.

Full initialization options:
```typescript
Telereso
   .disableLog() // disable genral and main logs
   .enableStringsLog() // enalbe initialization strings logs to debug current local and remote fetch
   .enableDrawableLog() // enable drawable logs
   .enableRealTimeChanges() // enable real time changes , by default remote cache is 12 hours , once enalbed will be 1 sec
   .init(i18n,firebase);
```
Skipping the Initialization will not cause crashes, but the app will not be able to use the remote version of the
resources, So it is a way to disable remote functionality.

### Firebase

Please follow the steps found [here](https://telereso.io/#firebase) to set up
your [Remote Config](https://firebase.google.com/docs/remote-config/) correctly.

### Localization

Now you can extend your localization in one language or even more languages by adding them directly to Remote
Config, <br>
No extra steps needed from client.

### Images

You can make your asset images dynamic with one simple change, <br>
Use `RemoteImage` instead of `img`

**Example**
_Before_

```
import logo from "./assets/images/img.png";

export default class MyComponent extends React.Component {
  render() {
    return (
          <img src={logo} />
    );
  }
}
```
_After_
```
import logo from "./assets/images/img.png";

export default class MyComponent extends React.Component {
  render() {
    return (
          <RemoteImage src={logo} />
    );
  }
}
```

In Remote config console make sure to use full path after the assets like `icons/image.png` as your key in your `drawable` json, like:

```json
{
  "img.png": "<url>"
}
```
