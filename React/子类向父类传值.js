// 父类：

import 子类名 from './子类名.js';
class App extends Component {
    父类方法(e) {
        console.log(e);
    }
    render() {
        <子类名 子类变量名={this.父类方法.bind(this)} />
    }
}

// 子类：

export default class 子类名 extends Component {
    componentDidMount() {
        this.props.子类变量名("内容");
    }
    render() {
    }
}
