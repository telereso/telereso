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
    Telereso
        .disableLog()
        .enableStringsLog()
        .enableDrawableLog()
        .setRemoteConfigSettings({minimumFetchIntervalMillis: 36000})
        .enableRealTimeChanges()
        .suspendedInit(i18n).then(() => {
      this.setState({
        splashFinished: true
      })
    });
  }

  render() {
    return (this.state.splashFinished ? <AppContainer /> : <Text>Loading...</Text>);
  }
}

//Telereso.init(i18n);

