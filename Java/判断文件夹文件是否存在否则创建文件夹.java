// 1、判断文件是否存在，不存在创建文件

File file=new File("C:\\Users\\QPING\\Desktop\\JavaScript\\2.htm");    
if(!file.exists())    
{    
    try {    
        file.createNewFile();    
    } catch (IOException e) { 
        e.printStackTrace();    
    }    
}

// 2、判断文件夹是否存在，不存在创建文件夹

File file =new File("C:\\Users\\QPING\\Desktop\\JavaScript");    
//如果文件夹不存在则创建    
if  (!file .exists()  && !file .isDirectory())      
{       
    System.out.println("//不存在");  
    file .mkdir();    
} else   
{  
    System.out.println("//目录存在");  
}
