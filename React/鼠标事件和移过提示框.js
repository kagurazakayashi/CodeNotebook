//单条
import React, { Component } from 'react';

export default class NCHistogramHis extends Component {
    constructor(props) {
        super(props);
        this.state = {
            detailShow: 'none',
            x: 0,
            y: 0
        };
    }
    handleMouseOver(e) {
        this.setState({
            detailShow: 'block',
            x: e.pageX + 16, //pageX是以html左上角为原点，相应的clientX是以浏览器左上角为原点
            y: e.pageY + 16,
        })
    }

    handleMouseOut() {
        this.setState({
            detailShow: 'none',
            x: 0,
            y: 0
        })
    }

    render() {
        return (
            <div className="NCHistogramHis" style={{'width':this.props.hiswidth,'height':this.props.pheight,'top':this.props.ptop,'backgroundColor':this.props.colordata[1]}}>
                <div className="NCHistogramHisF" onMouseOver={this.handleMouseOver.bind(this)} onMouseMove={this.handleMouseOver.bind(this)} onClick={this.handleMouseOver.bind(this)} onMouseOut={this.handleMouseOut.bind(this)}></div>
                <div className="NCHistogramFixedView" style={{'top':this.state.y,'left':this.state.x,'display':this.state.detailShow,'backgroundColor':this.props.colordata[1]}}><code>{this.props.groupname} {this.props.colordata[0]}<br/>{this.props.tval}</code></div>
            </div>
        );
    }
}
