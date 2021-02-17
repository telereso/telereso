import React from 'react';
import {Telereso} from './telereso';


export default class RemoteImage extends React.Component {
    state = {
        imageUri: null
    }

    remoteChangeListener = () => {
        this.setState({
            imageUri: Telereso.getRemoteImageOrDefault(this.props.source)
        });
    }

    componentDidMount() {
        Telereso.addRemoteChangeListener(this.remoteChangeListener);
    }

    componentWillUnmount() {
        Telereso.removeRemoteChangeListener(this.remoteChangeListener);
    }

    constructor(props) {
        super(props);
        this.state = {
            imageUri: Telereso.getRemoteImageOrDefault(this.props.src)
        }
    }

    render() {
        const {imageUri} = this.state
        return (
            <img src={imageUri} style={this.props.style} width={this.props.width} height={this.props.height}
                 alt={this.props.alt}/>
        )
    }
}
