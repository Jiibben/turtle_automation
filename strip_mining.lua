function useAllFuel()
    for i=1,16 do
        turtle.select(i)
        if turtle.getItemDetail()["name"] then
            turtle.refuel(turtle.getItemDetail()["count"])
        end
    end
    turtle.select(1)
end

function emptyInventory()
    for i=1,16 do
        turtle.select(i)
        turtle.dropUp()
    end
    turtle.select(1)
end

    
function tunnel(length)
    for i=1,length do
        while turtle.detect() do
            turtle.dig()
        end
        turtle.up()
        while turtle.detect() do
            turtle.dig()
        end
        turtle.down()
        while turtle.detect() do
            turtle.dig()
        end
        turtle.forward()
    end
end

function moveBack(dist)
    for i= 1,dist do
        turtle.back()
    end
end

function moveForward(times)
    local i = 0
    while i < times do
        if not turtle.detect() then
            turtle.forward()
        else
            while turtle.detect() do
                turtle.dig()
            end
            turtle.forward()
        end
        i = i+1
    end
end

function strip(deep, interval, length, pos, fuelInterval)
    local number = math.ceil(length / interval)
    for i=1,number do
        if i % fuelInterval ~= 0 then
            moveForward(interval)
            turtle.turnLeft()
            tunnel(deep, 0)
            moveBack(deep, 0)
            turtle.turnRight()
            pos = pos + interval
        else
            moveBack(pos)
            emptyInventory()
            moveForward(pos)
        end
        
    end
    return (length -number)
end

function stripminer(length)
    tunnel(length)
    moveBack(length)
    emptyInventory()
    moveBack(strip(12, 3, length, 0, 6))
    
end



args = {...}
intDigDistance = args[1]
stripminer(intDigDistance)
