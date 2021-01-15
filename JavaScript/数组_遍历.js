for (let i = 0; i < arr.length; ++i) {
    console.log(arr[i]);
}

for (let i in arr) {
    console.log(arr[i]);
}

for (const v of arr) {
    console.log(v);
}

arr.forEach((v, i) => console.log(v));

// https://blog.fundebug.com/2019/03/11/4-ways-to-loop-array-inj-javascript/