// 父文件 index.ts:
// import PageLogin, { PageLoginDelegate } from './login';
class Main implements PageLoginDelegate { // 使用子代理名
    loginPage = new PageLogin();
    constructor() {
        this.loginPage.delegate = this;
    }
    pageLoginStatus(status: number): void { // 使用子代理方法
        console.log(status);
    }
}
window.onload = () => {
    new Main()
}

// 子文件 login.ts：
export interface PageLoginDelegate {
    pageLoginStatus(status: number): void
}
export default class PageLogin {
    delegate: PageLoginDelegate | null = null
    constructor() {
        // 在需要的地方调用，执行父的方法
        this.delegate?.pageLoginStatus(0);
    }
}