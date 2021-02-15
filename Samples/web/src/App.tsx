import React from 'react';
import './App.css';
import Pricing from "./pricing";
import i18n from "./i18n";
import * as Telereso from "telereso-web";

export default class App extends React.Component {

    state = {
        splashFinished: false
    }

    componentDidMount() {
        // Telereso.suspendedInit(i18n).then(() => {
        //     this.setState({
        //         splashFinished: true
        //     })
        // });
        console.log(Telereso)
    }

    render() {
        return (this.state.splashFinished ? <Pricing/> : <label>Loading...</label>);
    }
}

