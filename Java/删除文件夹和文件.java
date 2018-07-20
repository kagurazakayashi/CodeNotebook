// 1，验证传入路径是否为正确的路径名(Windows系统，其他系统未使用)

// 验证字符串是否为正确路径名的正则表达式  
private static String matches = "[A-Za-z]:\\\\[^:?\"><*]*";  
// 通过 sPath.matches(matches) 方法的返回值判断是否正确  
// sPath 为路径字符串

// 2，通用的文件夹或文件删除方法，直接调用此方法，即可实现删除文件夹或文件，包括文件夹下的所有文件

/** 
 *  根据路径删除指定的目录或文件，无论存在与否 
 *@param sPath  要删除的目录或文件 
 *@return 删除成功返回 true，否则返回 false。 
 */  
public boolean DeleteFolder(String sPath) {  
    flag = false;  
    file = new File(sPath);  
    // 判断目录或文件是否存在  
    if (!file.exists()) {  // 不存在返回 false  
        return flag;  
    } else {  
        // 判断是否为文件  
        if (file.isFile()) {  // 为文件时调用删除文件方法  
            return deleteFile(sPath);  
        } else {  // 为目录时调用删除目录方法  
            return deleteDirectory(sPath);  
        }  
    }  
}

// 3，实现删除文件的方法，

/** 
 * 删除单个文件 
 * @param   sPath    被删除文件的文件名 
 * @return 单个文件删除成功返回true，否则返回false 
 */  
public boolean deleteFile(String sPath) {  
    flag = false;  
    file = new File(sPath);  
    // 路径为文件且不为空则进行删除  
    if (file.isFile() && file.exists()) {  
        file.delete();  
        flag = true;  
    }  
    return flag;  
}

// 4，实现删除文件夹的方法，

/** 
 * 删除目录（文件夹）以及目录下的文件 
 * @param   sPath 被删除目录的文件路径 
 * @return  目录删除成功返回true，否则返回false 
 */  
public boolean deleteDirectory(String sPath) {  
    //如果sPath不以文件分隔符结尾，自动添加文件分隔符  
    if (!sPath.endsWith(File.separator)) {  
        sPath = sPath + File.separator;  
    }  
    File dirFile = new File(sPath);  
    //如果dir对应的文件不存在，或者不是一个目录，则退出  
    if (!dirFile.exists() || !dirFile.isDirectory()) {  
        return false;  
    }  
    flag = true;  
    //删除文件夹下的所有文件(包括子目录)  
    File[] files = dirFile.listFiles();  
    for (int i = 0; i < files.length; i++) {  
        //删除子文件  
        if (files[i].isFile()) {  
            flag = deleteFile(files[i].getAbsolutePath());  
            if (!flag) break;  
        } //删除子目录  
        else {  
            flag = deleteDirectory(files[i].getAbsolutePath());  
            if (!flag) break;  
        }  
    }  
    if (!flag) return false;  
    //删除当前目录  
    if (dirFile.delete()) {  
        return true;  
    } else {  
        return false;  
    }  
}

// 5，main() 方法

public static void main(String[] args) {  
    HandleFileClass hfc = new HandleFileClass();  
    String path = "D:\\Abc\\123\\Ab1";  
    boolean result = hfc.CreateFolder(path);  
    System.out.println(result);  
    path = "D:\\Abc\\124";  
    result = hfc.DeleteFolder(path);  
    System.out.println(result);  
}

// main() 方法只是做了一个简单的测试，建立文件夹和文件都是本地建立，情况考虑的应该很全面了，包括文件夹包含文件夹、文件。文件的不同情况…………
//
// 来自 <http://kxjhlele.iteye.com/blog/323657>
