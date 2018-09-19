// 深复制（deepCopy）

  // 代码三的例子是一次显而易见的深复制，先分配一个内存地址然后再赋值。除了这种方法，我们还可以使用es6中的Object.assign()方法实现深复制。

/*代码四*/
let obj = {a: 1, b:{ c: 2}};
let newObj = Object.assign({},obj);

newObj.a = 2;
newObj.b.c = 3;

console.log(obj.a);
//log输出为 1,obj的值没有改变
console.log(obj.b.c)
//log输出为 3,obj的值改变1234567891011

  // 可以看到对 newObj.a 赋值后obj并没有改变，然而对 newObj.b.c 赋值之后， obj的值却改变了。这是因为 Object.assign() 方法只能深复制第一层的变量，所以第二层其实是一次浅复制。我们需要对obj.b也用一次Object.assign()才能完成一次完整的深复制。如果obj里面有很多层，就要循环嵌套使用Object.assign()方法很多次。代码三中的方法也只能深复制一层。
  // 在ES7中可以利用 … 对对象解构并且对对象中需要深复制的变量进行拷贝。

/*代码五*/
let obj = {a:1,b:2};

let newObj = {...obj,a:2};//对a深复制
newObj.b = 3;//对b浅复制

console.log(obj);
//{a:1,b:3}
console.log(newObj);
//{a:2,b:3}
  // 在reducer中经常会用到这种方式来更新我们的state，从而达到重新渲染的目的。

/*代码六*/
const initialState = {
    count: 1,
    value: { name : "Michael" }
}
function reducer(state = initialState, action){
    switch(action.type){
        case ADD_COUNT:
        return { ...state, count: state.count + 1 };
        case CHANGE_NAME:
        return { ...state, value : { name : "Lyle" } }
        default:
        return state;
    }
}

// state & props
  // 改变state需要用到 setState() 方法，setState() 方法属于深复制，最常用的写法就是

/*代码七*/
this.state = {
    value: { a: 1 }
}
const { value } = this.state;//浅复制
value.a = 2;
console.log(this.state.value.a);//输出2，但dom不更新
this.setState({ value });//dom更新12345678

  // 这里 value.a = 2 虽然已经改变了state中value的值，但由于是浅复制，新旧value指向的是同一块内存地址，组件更新时（state，props改变）默认只比较新旧对象的内存地址是否一致，如果一致则不更新。同理，如果在reducer中，直接对当前的state进行修改并返回props，相应的调用该props的组件不会更新渲染。

/*代码八*/
const initialState = {
    count: 1
}
function reducer(state = initialState, action){
    switch(action.type){
        case ADD_COUNT:
        state.count += 1;
        return { ...state }; //state改变，用到该state的组件不更新渲染
        default:
        return state;
    }
}

  // 基于组件更新的原理，即比较新旧state或props是否指向同一块内存地址，如果是则不更新，如果不是则更新。也就是说就算是两个对象的值相等但不指向同一地址，dom也会重新渲染。这并不是我们想要看到的，我们需要的是当props的值改变的时候dom重新渲染。我们可以在shouldComponentUpdate()方法里面定义dom是否更新的条件，如 if ( props === nextProps ) return true。


// 完全的深复制
  // 之前谈到的深复制基本是只能复制一层变量，或者必须嵌套着复制多层变量。如果想要更方便的完全复制一个对象，我们可以使用以下方法。

// 1.使用JSON.stringify()和parse()方法，如：
const newValue = JSON.parse(JSON.stringify(value));1

// 2.lodash —— .clone(obj, true) / .cloneDeep(obj)

// 总结
  // 1.在reducer中更新state的时候尽量确保每次都返回一个新（深复制）的对象；
  // 2.在常用的组件中使用shouldComponentUpdate()方法提高渲染效率；

// https://blog.csdn.net/babyfaceqian/article/details/72330212?utm_source=copy
