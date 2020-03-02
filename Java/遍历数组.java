// for 遍历
int arr[][] = new int[][]{{1},{2,3},{4,5,6}};
for(int i = 0; i < arr.length; i++){  
    for(int j = 0; j < arr[i].length; j++){  
        System.out.print(arr[i][j]);  
    }  
    System.out.println();  
}

// foreach 遍历
int arr[][] = new int[][]{{4,3},{1,5}};
for(int x[]:arr){  //外层遍历得到一维数组  
    for(int e:x){  //内层遍历得到数组元素  
        System.out.print(e);
    }
    System.out.println();
}

// Arrays toString 遍历
int arr[][] = new int[][]{{9,8},{7,6,5}};  
for(int i = 0; i < arr.length; i++){ //循环得到一维数组  
    System.out.println(Arrays.toString(arr[i])); //将一维数组转化为字符串输出  
}

// https://blog.csdn.net/hujutaoseu/article/details/70777774