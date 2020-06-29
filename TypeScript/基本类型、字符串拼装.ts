function 基本类型() {
    console.log("基本类型：")
    let a: boolean = true
    let b: number = 9
    let c: number = 1_000_000
    let d: null = null
    let e: string = "yashi"
    console.log(a, b, c, d, e)
    console.log("字符串组装：")
    let info: string = `名字：${e}，编号：${c + 1}`
    let info2: string = "名字：" + e + "，编号：" + (c + 1)
    console.log(info, info2)
}