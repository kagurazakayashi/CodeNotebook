class Content extends React.Component {
    componentWillMount() {
        console.log('开始载入')
    }
    componentDidMount() {
        console.log('载入完成')
    }
    componentWillReceiveProps(newProps) {
        console.log('收到对象属性变化')
    }
    shouldComponentUpdate(newProps, newState) {
        return true;
    }
    componentWillUpdate(nextProps, nextState) {
        console.log('准备重载');
    }
    componentDidUpdate(prevProps, prevState) {
        console.log('完成重载')
    }
    componentWillUnmount() {
        console.log('准备移除对象')
    }
}
