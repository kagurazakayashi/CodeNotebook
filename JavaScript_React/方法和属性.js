class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            属性名:"属性内容"
        };
    }
    f方法名(e) {
        console.log(e); //自身
        console.log(e[0]); //[参数数组]
    }
    render() {
        return (
            如果不加 [参数数组] 则 e 取到自身
            <textarea className="code" onChange={this.f方法名.bind(this,[参数数组])} value={this.state.属性名}></textarea>
        );
    }
}
