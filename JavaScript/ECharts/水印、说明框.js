option = {
    xAxis: {
        type: 'category',
        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    yAxis: {
        type: 'value'
    },
    //图解
    graphic: [
        //水印
        {
            type: 'group',
            rotation: Math.PI / 4,
            bounding: 'raw',
            right: 110,
            bottom: 110,
            z: 100,
            children: [
                {
                    type: 'rect',
                    left: 'center',
                    top: 'center',
                    z: 100,
                    shape: {
                        width: 400,
                        height: 50
                    },
                    style: {
                        fill: 'rgba(0,0,0,0.3)'
                    }
                },
                {
                    type: 'text',
                    left: 'center',
                    top: 'center',
                    z: 100,
                    style: {
                        fill: '#fff',
                        text: 'ECHARTS LINE CHART',
                        font: 'bold 26px sans-serif'
                    }
                }
            ]
        },
        //说明框
        {
            type: 'group',
            left: '10%',
            top: 'center',
            children: [
                {
                    type: 'rect',
                    z: 100,
                    left: 'center',
                    top: 'middle',
                    shape: {
                        width: 190,
                        height: 90
                    },
                    style: {
                        fill: '#fff',
                        stroke: '#555',
                        lineWidth: 1,
                        shadowBlur: 8,
                        shadowOffsetX: 3,
                        shadowOffsetY: 3,
                        shadowColor: 'rgba(0,0,0,0.2)'
                    }
                },
                {
                    type: 'text',
                    z: 100,
                    left: 'center',
                    top: 'middle',
                    style: {
                        fill: '#333',
                        text: [
                            '横轴表示温度，单位是 °C',
                            '纵轴表示高度，单位是 km',
                            '右上角有一个图片做的水印',
                            '这个文本块可以放在图中各',
                            '种位置'
                        ].join('\n'),
                        font: '14px Microsoft YaHei'
                    }
                }
            ]
        }
    ],
    series: [{
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line',
        smooth: true
    }]
};