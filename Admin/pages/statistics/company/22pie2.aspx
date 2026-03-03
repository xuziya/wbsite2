<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/Master/table.master" CodeFile="22pie2.aspx.cs" Inherits="Admin_pages_statistics_equipment_22pie2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="/Tools/echart/js/esl.js" type="text/javascript"></script>
    <script src="/Tools/echart/js/config.js" type="text/javascript"></script>
    <script src="/Tools/echart/js/dat.gui.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div id="main" style="width:100%; height:400px;margin-top:20px"></div>
    <script>
        require([
            'echarts'
          //'echarts/chart/pie',
          //'echarts/component/legend',
          //'echarts/component/grid',
          //'echarts/component/tooltip',
          //'echarts/component/toolbox'
        ], function (echarts)
        {
            var mainEl = document.getElementById('main');
            var chart = echarts.init(mainEl);
            var colorList = ['#c23531', '#2f4554', '#61a0a8','#d48265', '#91c7ae', '#749f83','#ca8622', '#bda29a', '#6e7074','#546570', '#c4ccd3'];
            var data = [<%=GetPieJs() %>];
            var legendData = [];
            echarts.util.each(data, function (item, index)
            {
                item.itemStyle = { normal: { color: colorList[index] } };
                legendData.push(item.name);
            });
            chart.setOption({
                legend:
                {
                    y:"-75px",
                    data: legendData,
                    formatter: function (name) { return name.replace(/\n/g, ' + '); }
                },/*色块*/
//                toolbox:
//                {
//                    left: 'left',
//                    feature: { dataView: {}, saveAsImage: {} }
//                },
                tooltip: {},/*经过色块出现文字说明*/
                series: [{
                    name: 'pie',
                    type: 'pie',
                    selectedMode: 'single',
                    selectedOffset: 30,
                    clockwise: true,
                    label:
                    {
                        normal:
                        {
                            textStyle: { fontSize: 16, color: 'rgba(0,0,0,0)' }
                        }
                    },
                    labelLine:
                    {
                        normal:
                        {
                            lineStyle: { color: 'rgba(0,0,0,0)' }
                        }
                    },
                    data: data
                }]
            });
            var dragging;
            var draggingDataIndex;
            var dx,dy;
            var zr = chart.getZr();
            chart.on('mousedown', function (params)
            {
                draggingDataIndex = getHoveredDataIndex(params);
                if (draggingDataIndex != null)
                {
                    var srcSector = params.event.target;
                    dragging = new echarts.graphic.Sector({
                        shape: echarts.util.extend({}, srcSector.shape),
                        style: { fill: srcSector.style.fill, opacity: 0.5 },
                        silent: true,
                        z: 10000
                    });

                    dx = params.event.offsetX - srcSector.shape.cx;
                    dy = params.event.offsetY - srcSector.shape.cy;
                    zr.add(dragging);
                }
            });
            chart.on('mouseup', function (params)
            {
                if (dragging)
                {
                    var targetDataIndex = getHoveredDataIndex(params);
                    if (targetDataIndex != null && targetDataIndex !== draggingDataIndex)
                    {
                        data[targetDataIndex].value += data[draggingDataIndex].value;
                        data[targetDataIndex].name += '\n' + data[draggingDataIndex].name;
                        legendData[targetDataIndex] = data[targetDataIndex].name;
                        data.splice(draggingDataIndex, 1);
                        legendData.splice(draggingDataIndex, 1);
                        chart.setOption({ legend: { data: legendData }, series: { data: data } });
                    }
                }
            });
            mainEl.addEventListener('mousemove', function (e)
            {
                var box = mainEl.getBoundingClientRect();
                var zrX = e.clientX - box.left;
                var zrY = e.clientY - box.top;
                if (dragging)
                {
                    dragging.setShape({ cx: zrX - dx, cy: zrY - dy });
                }
            });
            document.addEventListener('mouseup', function (e)
            {
                if (dragging)
                {
                    zr.remove(dragging);
                    dragging = null;
                }
            });
//            function getHoveredDataIndex(params)
//            {
//                return params.componentType === 'series'  && params.componentSubType === 'pie' && params.dataIndex;
//            }
        })
    </script>
</asp:Content>