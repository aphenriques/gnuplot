local gnuplot = {}

--data = {{x, [...]}, [...]}
local function writeInlineData(file, data)
    for _, record in ipairs(data) do
        file:write(record[1])
        local recordLength = #record
        for i = 2, recordLength do
            file:write(' ' .. tostring(record[i]))
        end
        file:write('\n')
    end
    file:write('e\n')
end

local gnuplotPipe
function gnuplot.execute(commands)
    gnuplotPipe = gnuplotPipe or io.popen('gnuplot', 'w')
    for _, command in ipairs(commands) do
        if type(command) == 'string' then
            gnuplotPipe:write(command .. '\n')
        elseif type(command) == 'table' then
            writeInlineData(gnuplotPipe, command)
        end
    end
    gnuplotPipe:flush()
end

function gnuplot.plot2d(outputFileName, data)
    gnuplot.execute {
        "set terminal png",
        "set output '" .. outputFileName .. "'",
        "set key off",
        "plot '-' with lines",
        data
    }
end

function gnuplot.plot2dTimeSeries(outputFileName, data, timeFormat)
    timeFormat = timeFormat or '%Y%m%dT%H%M%S'
    gnuplot.execute{
        "set terminal png",
        "set output '" .. outputFileName .. "'",
        "set key off",
        "set xdata time",
        "set timefmt '" .. timeFormat .. "'",
        "plot '-' using 1:2 with lines",
        data
    }
end

return gnuplot
