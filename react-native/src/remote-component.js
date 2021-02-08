import React from 'react';
import { Telereso } from './telereso';


export default class RemoteComponent extends React.Component {

    remoteChangeListner = () => {
        this.setState();
    }
    
    componentDidMount() {
        Telereso.addRemoteChangeListner(this.remoteChangeListner);
    }
    componentWillUnmount() {
        Telereso.removeRemoteChangeListner(this.remoteChangeListner);
    }

}