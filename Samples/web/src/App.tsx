import React from 'react';
import './App.css';
import Pricing from "./pricing";
import i18n from "./i18n";
import {Telereso} from "telereso-web";
import firebase from "firebase/app";


export default class App extends React.Component {

    state = {
        splashFinished: false
    }

    componentDidMount() {
        Telereso.enableRealTimeChanges().suspendedInit(i18n,firebase).then(() => {
            this.setState({
                splashFinished: true
            })
        });
    }

    render() {
        return (this.state.splashFinished ? <Pricing/> : <label>Loading...</label>);
    }
}

