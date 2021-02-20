import React from 'react';
import { Telereso } from './telereso';


export default class RemoteComponent extends React.Component {

    remoteChangeListner = () => {
        this.setState();
    }

    componentDidMount() {
        Telereso.addRemoteChangeListener(this.remoteChangeListner);
    }
    componentWillUnmount() {
        Telereso.removeRemoteChangeListener(this.remoteChangeListner);
    }

}
