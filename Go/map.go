package main

import (  
    "fmt"
)

func mapdemo() {  
    personSalary := make(map[string]int)
	// personSalary := map[string]int {
    //     "steve": 12000,
    //     "jamie": 15000,
    // }
    personSalary["steve"] = 12000
    personSalary["jamie"] = 15000
    personSalary["mike"] = 9000
    fmt.Println("personSalary map contents:", personSalary)
	for key, value := range personSalary {
        fmt.Printf("personSalary[%s] = %d\n", key, value)
    }
}

// 上面的程序输出：personSalary map contents: map[steve:12000 jamie:15000 mike:9000]