option = {
    tooltip: {
        trigger: "axis",
    },
    legend: {
        icon: "roundRect",
        type: "scroll",
        width: "85%",
        data: ["aa", "bb"],
    },
    grid: {
        top: 30,
        left: 60,
        right: 60,
        bottom: 70,
    },
    dataZoom: [{
            type: "inside",
            xAxisIndex: 0,
        },
        {
            type: "slider",
            xAxisIndex: 0,
        },
    ],
    xAxis: {
        type: "time",
        boundaryGap: false,
        splitLine: {
            show: false,
        },
        axisTick: {
            alignWithLabel: true,
        },
        axisLine: {
            // onZero: false,
            lineStyle: {
                color: "#bbb",
            },
        },
        splitNumber: 8
    },
    yAxis: {
        type: 'value',
        splitLine: {
            show: true,
            lineStyle: {
                type: "dotted",
            },
        },
        axisLine: {
            // onZero: false,
            lineStyle: {
                color: "#bbb",
            },
        },
    },
    series: [{
        name: "0001",
        data: [{
            read: 320,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 00:00", 320]
        }, {
            read: 332,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 01:00", 332]
        }, {
            read: 290,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 02:00", 290]
        }, {
            read: 34,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 03:00", 34]
        }, {
            read: 10,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 04:00", 10]
        }, {
            read: 130,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 05:00", 130]
        }, {
            read: 120,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 06:00", 120]
        }],
        type: 'line',
        smooth: true,
        showSymbol: false,
        markArea: {
            silent: true,
            label: {
                show: false,
                // position: 'right'
            },
            // emphasis: {
            //     label: {
            //         show: true,
            //         position: 'right'
            //     }
            // },
            tooltip: {
                show: false,
            },
            data: [
                [{
                        name: "非常优秀：高标准要求",
                        yAxis: -Infinity,
                        itemStyle: { color: "#10D0EE", opacity: 0.2 },
                    },
                    { yAxis: 15 },
                ],
                [{
                        name: "优：基本要求",
                        yAxis: 15,
                        itemStyle: { color: "#1BED18", opacity: 0.2 },
                    },
                    { yAxis: 35 },
                ],
                [{
                        name: "良",
                        yAxis: 35,
                        itemStyle: { color: "#E0EB0D", opacity: 0.2 },
                    },
                    { yAxis: 75 },
                ],
                [{
                        name: "轻度污染",
                        yAxis: 75,
                        itemStyle: { color: "#EF9432", opacity: 0.2 },
                    },
                    { yAxis: 115 },
                ],
                [{
                        name: "中度污染",
                        yAxis: 115,
                        itemStyle: { color: "#EF0F08", opacity: 0.2 },
                    },
                    { yAxis: 150 },
                ],
                [{
                        name: "重度污染",
                        yAxis: 150,
                        itemStyle: { color: "#B32778", opacity: 0.2 },
                    },
                    { yAxis: 250 },
                ],
                [{
                        name: "严重污染",
                        yAxis: 250,
                        itemStyle: { color: "#660B27", opacity: 0.2 },
                    },
                    { yAxis: 350 },
                ],
                [{
                        name: "严重污染",
                        yAxis: 350,
                        itemStyle: { color: "#660B27", opacity: 0.2 },
                    },
                    { yAxis: Infinity },
                ],
            ]
        },
        markLine: {
            silent: true,
            symbolSize: 0,
            label: { formatter: "{b}", position: "middle" },
            data: [{
                    name: "非常优秀：高标准要求",
                    yAxis: 15,
                    lineStyle: { color: "#10D0EE" }
                },
                {
                    name: "优：基本要求",
                    yAxis: 35,
                    lineStyle: { color: "#1BED18" }
                },
                {
                    name: "良",
                    yAxis: 75,
                    lineStyle: { color: "#E0EB0D" }
                },
                {
                    name: "轻度污染",
                    yAxis: 115,
                    lineStyle: { color: "#EF9432" }
                },
                {
                    name: "中度污染",
                    yAxis: 150,
                    lineStyle: { color: "#EF0F08" }
                },
                {
                    name: "重度污染",
                    yAxis: 250,
                    lineStyle: { color: "#B32778" }
                },
                {
                    name: "严重污染",
                    yAxis: 350,
                    lineStyle: { color: "#660B27" }
                },
                {
                    name: "严重污染",
                    yAxis: Infinity,
                    lineStyle: { color: "#660B27" }
                },
            ]
        }
    }, {
        name: "0002",
        data: [{
            read: 15,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 01:00", 15]
        }, {
            read: 32,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 02:00", 32]
        }, {
            read: 01,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 03:00", 01]
        }, {
            read: 34,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 04:00", 34]
        }, {
            read: 290,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 05:00", 290]
        }, {
            read: 330,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 06:00", 330]
        }, {
            read: 320,
            name: "2021/05/14 00:00",
            unit: "μg/m³",
            value: ["2021/05/14 07:00", 320]
        }],
        type: 'line',
        smooth: true,
        showSymbol: false,
        markArea: {
            silent: true,
            label: {
                show: false,
                // position: 'right'
            },
            // emphasis: {
            //     label: {
            //         show: true,
            //         position: 'right'
            //     }
            // },
            tooltip: {
                show: false,
            },
            data: [
                [{
                        name: "非常优秀：高标准要求",
                        yAxis: -Infinity,
                        itemStyle: { color: "#10D0EE", opacity: 0.2 },
                    },
                    { yAxis: 15 },
                ],
                [{
                        name: "优：基本要求",
                        yAxis: 15,
                        itemStyle: { color: "#1BED18", opacity: 0.2 },
                    },
                    { yAxis: 35 },
                ],
                [{
                        name: "良",
                        yAxis: 35,
                        itemStyle: { color: "#E0EB0D", opacity: 0.2 },
                    },
                    { yAxis: 75 },
                ],
                [{
                        name: "轻度污染",
                        yAxis: 75,
                        itemStyle: { color: "#EF9432", opacity: 0.2 },
                    },
                    { yAxis: 115 },
                ],
                [{
                        name: "中度污染",
                        yAxis: 115,
                        itemStyle: { color: "#EF0F08", opacity: 0.2 },
                    },
                    { yAxis: 150 },
                ],
                [{
                        name: "重度污染",
                        yAxis: 150,
                        itemStyle: { color: "#B32778", opacity: 0.2 },
                    },
                    { yAxis: 250 },
                ],
                [{
                        name: "严重污染",
                        yAxis: 250,
                        itemStyle: { color: "#660B27", opacity: 0.2 },
                    },
                    { yAxis: 350 },
                ],
                [{
                        name: "严重污染",
                        yAxis: 350,
                        itemStyle: { color: "#660B27", opacity: 0.2 },
                    },
                    { yAxis: Infinity },
                ],
            ]
        },
        markLine: {
            silent: true,
            symbolSize: 0,
            label: { formatter: "{b}", position: "middle" },
            data: [{
                    name: "非常优秀：高标准要求",
                    yAxis: 15,
                    lineStyle: { color: "#10D0EE" }
                },
                {
                    name: "优：基本要求",
                    yAxis: 35,
                    lineStyle: { color: "#1BED18" }
                },
                {
                    name: "良",
                    yAxis: 75,
                    lineStyle: { color: "#E0EB0D" }
                },
                {
                    name: "轻度污染",
                    yAxis: 115,
                    lineStyle: { color: "#EF9432" }
                },
                {
                    name: "中度污染",
                    yAxis: 150,
                    lineStyle: { color: "#EF0F08" }
                },
                {
                    name: "重度污染",
                    yAxis: 250,
                    lineStyle: { color: "#B32778" }
                },
                {
                    name: "严重污染",
                    yAxis: 350,
                    lineStyle: { color: "#660B27" }
                },
                {
                    name: "严重污染",
                    yAxis: Infinity,
                    lineStyle: { color: "#660B27" }
                },
            ]
        }
    }]
};