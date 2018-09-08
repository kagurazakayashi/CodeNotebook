// 父类：

import 子类名 from './子类名.js';
class App extends Component {
    componentDidMount() {
        this.refs.为子类定义的名称.子类中的方法();
    }
    render() {
        <子类名 传入变量名="变量内容"{或方法} ref="为子类定义的名称" />
    }
}

// 子类：

export default class 子类名 extends Component {
    constructor(props) {
        super(props);
        this.state = {
            子类属性:this.props.传入变量名
        };
    }
    子类中的方法() {
        console.log("");
    }
    render() {
        console.log(this.props.传入变量名);
        console.log(this.state.子类属性);
    }
}
