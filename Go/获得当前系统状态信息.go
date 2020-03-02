package main

import (
	"fmt"
	"time"

	"github.com/shirou/gopsutil/cpu"
	"github.com/shirou/gopsutil/disk"
	"github.com/shirou/gopsutil/host"
	"github.com/shirou/gopsutil/mem"
	"github.com/shirou/gopsutil/net"
)

func main() {
	v, _ := mem.VirtualMemory()
	c, _ := cpu.Info()
	cc, _ := cpu.Percent(time.Second, false)
	d, _ := disk.Usage("/")
	n, _ := host.Info()
	nv, _ := net.IOCounters(true)
	boottime, _ := host.BootTime()
	btime := time.Unix(int64(boottime), 0).Format("2006-01-02 15:04:05")

	fmt.Printf("内存: 总计 %v MB，空余: %v MB，已使用: %v MB，使用率: %f%%\n", v.Total/1024/1024, v.Available/1024/1024, v.Used/1024/1024, v.UsedPercent)
	// len(c)
	for _, subcpu := range c {
		modelname := subcpu.ModelName
		cores := subcpu.Cores
		fmt.Printf("处理器核心，型号: %v ，虚拟核心数: %v\n", modelname, cores)
	}
	for _, subnet := range nv {
		fmt.Printf("网络: 下载: %v bytes / 上传: %v bytes\n", subnet.BytesRecv, subnet.BytesSent)
	}
	fmt.Printf("系统启动时间: %v\n", btime)
	fmt.Printf("CPU使用率: %f%% \n", cc[0])
	fmt.Printf("硬盘总计: %v GB，可用空间: %v GB， 已使用: %f%%\n", d.Total/1024/1024/1024, d.Free/1024/1024/1024, d.UsedPercent)
	fmt.Printf("操作系统: %v(%v) ，版本： %v  \n", n.Platform, n.PlatformFamily, n.PlatformVersion)
	fmt.Printf("主机名称: %v  \n", n.Hostname)
}
