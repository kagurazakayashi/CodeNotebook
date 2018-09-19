// updatedata(info)收到一个数组，更新显示：
import React, { Component } from 'react';

export default class NCHistogramInfo extends Component {
    constructor(props) {
        super(props);
        this.state = {
            info:[]
        };
    }
    updatedata(info) {
        this.setState({
            info:info
        });
        //info: [ ["进货", "skyblue"], ["出货", "orange"] ]
    }
    render() {
        var self = this;
        return (
            <div className="NCHistogramColorInfo">
                {
                    self.state.info.map(function(v,i){
                        // v数组直接传给子类处理
                        return <NCHistogramInfoName key={i} data={v} ref="NCHistogramInfoName" />;
                    })
                }
            </div>
        );
    }
}
