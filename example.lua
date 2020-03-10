package.path = package.path .. ';?.lua'
local gnuplot = require'gnuplot'

local data = {
    {1, 1},
    {2, 1},
    {3, 2},
    {4, 3},
    {5, 5},
    {6, 8}
}
gnuplot.plot2d('2d.png', data)

local timeSeries = {
    {'20200502T000001', 1},
    {'20200502T000002', 4},
    {'20200502T000003', 9},
    {'20200502T000004', 16},
    {'20200502T000005', 25},
    {'20200502T000006', 36}
}

gnuplot.plot2dTimeSeries('2dTimeSeries.png', timeSeries)
