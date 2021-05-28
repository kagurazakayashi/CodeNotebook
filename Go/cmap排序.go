package main

import (
	"encoding/json"
	"fmt"
	"reflect"
	"sort"
	"strconv"

	cmap "github.com/orcaman/concurrent-map"
)

func main() {
	var rd []cmap.ConcurrentMap
	for i := 10; i > 0; i-- {
		nrd := cmap.New()
		nrd.Set("id", i)
		rd = append(rd, nrd)
	}
	bytes, _ := json.Marshal(rd)
	fmt.Println(string(bytes))
	sort.Sort(CMAP(rd))
	bytes, _ = json.Marshal(rd)
	fmt.Println(string(bytes))
}

type CMAP []cmap.ConcurrentMap

func (a CMAP) Len() int      { return len(a) }
func (a CMAP) Swap(i, j int) { a[i], a[j] = a[j], a[i] }
func (a CMAP) Less(i, j int) bool {
	//按id排序
	aidstr, _ := a[i].Get("id")
	bidstr, _ := a[j].Get("id")
	aid := 0
	bid := 0
	if reflect.TypeOf(aidstr).Name() == "int" {
		aid = aidstr.(int)
	} else {
		aid, _ = strconv.Atoi(aidstr.(string))
	}
	if reflect.TypeOf(bidstr).Name() == "int" {
		bid = bidstr.(int)
	} else {
		bid, _ = strconv.Atoi(bidstr.(string))
	}
	return aid < bid
}
