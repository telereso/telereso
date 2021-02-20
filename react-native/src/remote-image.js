import React from 'react';
import { Image } from 'react-native';
import { Asset } from 'expo-asset';
import { Telereso } from './telereso';


export default class RemoteImage extends React.Component {
    state = {
        imageUri: null
    }
    remoteChangeListner = () => {
        this.setState({
            imageUri: Telereso.getRemoteImageOrDefault(this.props.source)
        });
    }

    componentDidMount() {
        Telereso.addRemoteChangeListener(this.remoteChangeListner);
    }
    componentWillUnmount() {
        Telereso.removeRemoteChangeListener(this.remoteChangeListner);
    }

    constructor(props) {
        super(props);
        this.state = {
            imageUri: Telereso.getRemoteImageOrDefault(this.props.source)
        }
    }

    render() {
        const { imageUri } = this.state
        return (
            <Image source={{ uri: `${imageUri}` }} style={this.props.style} />
        )
    }
}
