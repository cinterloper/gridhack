--gridhack is a minesweeper clone implemented in lua-bash
--2018 Grant Haywood
--Public Domain

debug = false
getch = {}
position = { 1, 1 }
boardstate = {}
field = {}
mine_generation_threshold = 0.5
local function isempty(s)
    return s == nil or s == ''
end

--_X = true
--_Y = false
--function bv(var)
--    -- convert a bool to an integer value
--    return var and 1 or 0
--end
function l_initBoard()
    for x = 1, 10, 1
    do
        boardstate[x] = {}
        for y = 1, 10, 1
        do
            boardstate[x][y] = '*'
        end
    end
    initField()
end
function initField()
    math.randomseed(os.time())
    for x = 1, 10, 1
    do
        field[x] = {}
        for y = 1, 10, 1
        do
            field[x][y] = randoBool(mine_generation_threshold)
        end
    end
end

function randoBool(thresh)
    dec = math.random()
    if dec >= mine_generation_threshold then
        return 1;
    end
    return 0
end

function findAdjacent(X, Y)
    ajacent_mines = 0
    for y = Y - 1, Y + 1 do
        for x = X - 1, X + 1 do
            if x > 0 and y > 0 then
                if field[x][y] == 1 then
                    ajacent_mines = ajacent_mines + 1
                end
            end
        end
    end
    dbg("returning ajacent mines:" .. ajacent_mines)
    return ajacent_mines
    --find the -1 and +1
    --on the x axis
    --then the y axis
    --find the 4 combinations of x+1,y+1, x-1,y-1,...


    --as long as we have checked there is no current mine
    -- we just count the mines in the 3x3 square (or shaved on a side...)
end

function drawBoard(board)
    bash.call("clear")
    for x, row in ipairs(board)
    do
        for y, car in ipairs(board[x])
        do
            io.write(car)
        end
        print() --newline
    end
end
function dbg(msg)
    if debug then
        print(msg)
    end
end
function readInput()
    bash.call("getKey")
    KEY = bash.getVariable("k")
    return KEY
end

function moveLeft()
    if position[1] < 11 then
        position[2] = position[2] + 1
    end
end
function moveRight()
    if position[2] > 1 then
        position[2] = position[2] - 1
    end
end
function moveDown()
    if position[1] > 1 then
        position[1] = position[1] - 1
    end
end
function moveUp()
    if position[1] < 11 then
        position[1] = position[1] + 1
    end
end

function boundsCheck(axis, step)
    if boardstate[position[axis]] then
    end

end

function updateGame(drawBoardRes, readInputRes)


    K = bash.getVariable('k')
    dbg(K)
    if K == "s" then
        drawBoard(field)
    end
    if K == "b" then

        drawBoard(boardstate)
    end
    if K == "x" then
        --boardstate[position[2]][position[1]] = 'x'
        if field[position[2]][position[1]] == 1 then
            drawBoard(field)
            print("you died")
            bash.call('putCursor')
            bash.setVariable("RUNNING", 0)
            return
        else
            boardstate[position[2]][position[1]] = findAdjacent(position[2], position[1])
        end
        --boardstate[position[2]][position[1]] = field[position[2]][position[1]]

        drawBoard(boardstate)
    end
    if K == "[" then
        K = readInput()
        if K == "A" then
            moveRight()
        end
        if K == "B" then
            moveLeft()
        end
        if K == "C" then
            moveUp()
        end
        if K == "D" then
            moveDown()
        end
    end
    bash.setVariable('X', position[2] - 1 )
    bash.setVariable('Y', position[1] - 1)
    -- dont need this with cursor but still
    -- print(readInputRes)
end
function getMineThreshold()
    mine_generation_threshold = bash.getVariable("MINE_THRESHOLD")
    if isempty(mine_generation_threshold) then
        mine_generation_threshold = 0.5
    else
        mine_generation_threshold = tonumber(mine_generation_threshold)
    end
end
function l_game()
    getMineThreshold()
    local drawBoardRes = drawBoard(boardstate)
    local updateGameRes = updateGame(drawBoardRes)
    bash.call('putCursor')

    return true
end

function l_got_k()
    print(bash.getVariable('k'))
end


bash.register("l_initBoard")
bash.register("l_got_k")
bash.register("l_game")