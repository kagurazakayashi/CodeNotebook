/*
<input id="demoInput" value="hello world">
<button id="btn">点我复制</button>
*/

// 从输入框复制
const btn = document.querySelector('#btn');
btn.addEventListener('click', () => {
	const input = document.querySelector('#demoInput');
	input.select();
	if (document.execCommand('copy')) {
		document.execCommand('copy');
		console.log('复制成功');
	}
})


// 其它地方复制
// 有的时候页面上并没有 <input> 标签，我们可能需要从一个 <div> 中复制内容，或者直接复制变量。
// 还记得在 execCommand() 方法的定义中提到，它只能操作可编辑区域，也就是意味着除了 <input>、<textarea> 这样的输入域以外，是无法使用这个方法的。
const btn = document.querySelector('#btn');
btn.addEventListener('click',() => {
	const input = document.createElement('input');
    input.setAttribute('readonly', 'readonly');
    input.setAttribute('value', 'hello world');
    document.body.appendChild(input);
	input.setSelectionRange(0, 9999);
	if (document.execCommand('copy')) {
		document.execCommand('copy');
		console.log('复制成功');
	}
    document.body.removeChild(input);
})

// https://juejin.cn/post/6844903567480848391