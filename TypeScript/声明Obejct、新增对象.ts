interface echartOption {
    tooltip: any;
    legend: any;
    grid: any;
    toolbox: any;
    dataZoom: any[];
    xAxis: any;
    yAxis: any;
    visualMap?: any;
    series: any[];
}

function newObject() {
    var option: echartOption = {
        // color: ["#1976d2"],
        tooltip: {
            trigger: "axis",
        },
        legend: {
            icon: "roundRect",
            type: "scroll",
            width: "65%",
            data: [],
        },
        grid: {
            top: 30,
            left: 60,
            right: 135,
            bottom: 70,
        },
        toolbox: {
            right: 10,
            feature: {
                dataZoom: {
                    yAxisIndex: "none",
                },
                restore: { show: false },
                dataView: {},
                magicType: {},
                saveAsImage: { name: "整理异常数据" },
            },
        },
        dataZoom: [
            {
                type: "slider", //slider表示有滑动块的，
                show: true,
                xAxisIndex: [0], //表示x轴折叠
            },
            {
                type: "inside", //
                yAxisIndex: [0], //表示y轴折叠
            },
        ],
        xAxis: {
            boundaryGap: false,
            splitLine: {
                show: false,
            },
            axisTick: {
                alignWithLabel: true,
            },
            axisLine: {
                lineStyle: {
                    color: "#bbb",
                },
            },
            splitNumber: 8,
            data: {},
        },
        yAxis: {
            type: "value",
            splitLine: {
                show: false,
            },
            axisLine: {
                lineStyle: {
                    color: "#bbb",
                },
            },
        },
        // visualMap: {},
        series: [
            {
                name: "data",
                type: "line",
                showSymbol: false,
                data: {},
                markLine: {},
            },
        ],
    };
    var echartMarkLine: any[] = [
        {
            top: 50,
            right: 10,
            pieces: [
                {
                    gt: 0,
                    lte: 50,
                    color: "#93CE07",
                },
                {
                    gt: 50,
                    lte: 100,
                    color: "#FBDB0F",
                },
                {
                    gt: 100,
                    lte: 150,
                    color: "#FC7D02",
                },
                {
                    gt: 150,
                    lte: 200,
                    color: "#FD0100",
                },
                {
                    gt: 200,
                    lte: 300,
                    color: "#AA069F",
                },
                {
                    gt: 300,
                    color: "#AC3B2A",
                },
            ],
            outOfRange: {
                color: "#999",
            },
        },
        {
            silent: true,
            data: [
                {
                    yAxis: 50,
                    lineStyle: {
                        color: "#FBDB0F",
                    }
                },
                {
                    yAxis: 100,
                    lineStyle: {
                        color: "#FC7D02",
                    }
                },
                {
                    yAxis: 150,
                    lineStyle: {
                        color: "#FD0100",
                    }
                },
                {
                    yAxis: 200,
                    lineStyle: {
                        color: "#AA069F",
                    }
                },
                {
                    yAxis: 300,
                    lineStyle: {
                        color: "#AC3B2A",
                    }
                },
            ],
        },
    ]
    option.visualMap = echartMarkLine[0];
}