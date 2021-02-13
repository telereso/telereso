# Telereso


[![npm](https://img.shields.io/npm/v/telereso.svg)](https://www.npmjs.com/package/telereso)

npm package to use [Telereso](https://telereso.io?utm_source=npm&utm_medium=readme&utm_campaign=normal),

[Telereso](https://telereso.io?utm_source=npm&utm_medium=readme&utm_campaign=normal) will allow you to control your app
resources (strings,images) remotely and out of the box , without the need to add extra logic ,

## Installation

[Telereso](https://telereso.io?utm_source=npm&utm_medium=readme&utm_campaign=normal) depends on Firebase to
use [Remote Config](https://firebase.google.com/docs/remote-config/) for resource management<br>
And [Cloud Messaging](https://firebase.google.com/docs/cloud-messaging) for realtime changes (_optional_)

All you need to get started is make sure your project has set up firebase ([check docs](https://rnfirebase.io/)), <br>
Setup `i18n` as usual ([check expo setup](https://docs.expo.io/versions/latest/sdk/localization/))
<br>
Then add `Telereso` dependency to your project

```shell
# Using npm
npm install telerso
```

```shell
# Using Yarn
yarn add telerso
```

## Usage

### Initialization

Make sure your already set up your normal localization
using [i18n](https://docs.expo.io/versions/latest/sdk/localization/)

There is 2 option to initialization :

1. `init()`  
   Will not make api calls it's just to set up resources, In your `App.dart` file, call `init()` and make sure to
   pass `i18n` object:

   ```
   import React, { useState } from 'react';
   import { StyleSheet, Text, View } from 'react-native';
   import i18n from './i18n';
   import AppContainer from './src/navigations/AppNavigation';
   import { Telereso } from 'telereso';
   
   export default class App extends React.Component {
      render() {
         return (<AppContainer/>);
      }
   }
   
   Telereso.init(i18n);
   ```

2. `susbundedinit()`  
   Will make sure to fetch the latest changes from Remote Config and not to start the app unless all resources are
   ready.

   ```
   import React, { useState } from 'react';
   import { StyleSheet, Text, View } from 'react-native';
   import i18n from './i18n';
   import AppContainer from './src/navigations/AppNavigation';
   import { Telereso } from 'telereso';
   
   export default class App extends React.Component {
     state = {
       splashFinished: false
     }
     constructor(props) {
       super(props);
       Telereso.suspendedInit(i18n).then(() => {
         this.setState({
           splashFinished: true
         })
       });
     }
   
     render() {
       return (this.state.splashFinished ? <AppContainer /> : <Text>Loading...</Text>);
     }
   }
   ```
   For loading state you can choose your own splash.

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
Use `RemoteImage` instead of `image`

**Example**
_Before_

```
export default class MyComponent extends React.Component {
  render() {
    return (
        <View>
          <image source={../assets/icons/image.png} />
        </View>
    );
  }
}
```
_After_
```
export default class MyComponent extends React.Component {
  render() {
    return (
        <View>
          <ImageView source={../assets/icons/image.png} />
        </View>
    );
  }
}
```

In Remote config console make sure to use full path after the assets like `icons/image.png` as your key in your `drawable` json, like:

```json
{
  "icons/image.png": "<url>"
}
```