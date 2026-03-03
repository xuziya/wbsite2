<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Admin/Master/table.master" CodeFile="32bar.aspx.cs" Inherits="Admin_pages_statistics_equipment_32bar1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="/Tools/echart/js/esl.js" type="text/javascript"></script>
    <script src="/Tools/echart/js/config.js" type="text/javascript"></script>
    <script src="/Tools/echart/js/facePrint.js" type="text/javascript"></script>
    <script src="/Tools/echart/js/testHelper.js" type="text/javascript"></script>
    <link href="/Tools/echart/css/reset.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div id="main" style="width:100%;"></div>
    <script>
        require(['echarts'], function (echarts)
        {
            var data1 = <%=GetPieJs() %>;
            var itemStyle = {
                normal: {
                    barBorderRadius: 5,
                    label: {
                        show: true,
                        position: 'outside'
                    }
                },
                emphasis: {
                    label: {
                        position: 'outside'
                    },
                    barBorderColor: '#fff',
                    barBorderWidth: 1,
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowOffsetY: 0,
                    shadowColor: 'rgba(0,0,0,0.5)'
                }
            };
            var option = {
                backgroundColor: '#eee',
                legend: {
                },
                xAxis: {
                    type: 'time',
                    axisLabel: {
                        formatter: function (val)
                        {
                            return echarts.format.formatTime('yyyy-MM-dd\nhh:ss:mm.SSS', val);
                        }
                    }
                },
                yAxis: {
                    // axisLabel: {
                    //     show: false
                    // },
                    axisTick: {
                        show: false
                    },
                    splitArea: {
                        show: false
                    }
                },
                grid: {
                    bottom: 80
                },
                dataZoom: [{
                    type: 'slider',
                    labelFormatter: function (val)
                    {
                        return echarts.format.formatTime('yyyy-MM-dd\nhh:ss:mm.SSS', val);
                    }
                }, {
                    type: 'inside'
                }],
                series: [{
                    name: 'bar',
                    type: 'bar',
                    data: data1
                }]
            };
            testHelper.create(echarts, 'main', {
                //title: 'time axis',
                option: option
            });
        });
    </script>
</asp:Content>