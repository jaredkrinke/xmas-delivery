pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

-- constants
colors = {
    black = 0,
    dark_blue = 1,
    dark_purple = 2,
    dark_green = 3,
    brown = 4,
    dark_gray = 5,
    light_gray = 6,
    white = 7,
    red = 8,
    orange = 9,
    yellow = 10,
    green = 11,
    blue = 12,
    indigo = 13,
    pink = 14,
    peach = 15,
}

buttons = {
    left = 0,
    right = 1,
    up = 2,
    down = 3,
    z = 4,
    x = 5,
}

sprites = {
    santa_ul = 0,
    santa_ur = 1,
    santa_ll = 16,
    santa_lr = 17,
    santa_lr_throwing = 32,

    reindeer_ul = 2,
    reindeer_ur = 3,
    reindeer_ll = 18,
    reindeer_lr = 19,
    reindeer_ur_rudolph = 33,

    roof = 4,
    roof_chimney = 5,
    house_door = 20,
    house = 21,
    house_tree = 22,

    ground = 36,
    ground_2 = 37,
    ground_3 = 38,
    ground_4 = 39,

    gift = 48,
    gift_smash1 = 49,
    gift_smash2 = 50,
    gift_smash3 = 51,
}

sprite_blocks = {
    santa_idle = {
        { sprites.santa_ul, sprites.santa_ur },
        { sprites.santa_ll, sprites.santa_lr },
    },
    santa_throwing = {
        { sprites.santa_ul, sprites.santa_ur },
        { sprites.santa_ll, sprites.santa_lr_throwing },
    },
    reindeer = {
        { sprites.reindeer_ul, sprites.reindeer_ur },
        { sprites.reindeer_ll, sprites.reindeer_lr },
    },
    rudolph = {
        { sprites.reindeer_ul, sprites.reindeer_ur_rudolph },
        { sprites.reindeer_ll, sprites.reindeer_lr },
    },
}

system = {
    width = 128,
    height = 128,
}

-- game logic
player_states = {
    idle = 1,
    throwing = 2,
}

player = {
    gift_period = 10,
    speed = 2,

    x = 16,
    y = 56,
    state = player_states.idle,
    timer = 0,
    period = 2 * 30,
    drift = 3,

    counter = 0,
}

function player:update()
    self.timer = (self.timer + 1) % self.period
    if self.counter > 0 then self.counter = self.counter - 1 end

    if self.state == player_states.idle then
        if btn(buttons.z) then
            self.state = player_states.throwing
            self.counter = self.gift_period
            projectiles:add(self.x, self.y)
        end
    elseif self.state == player_states.throwing then
        if not btn(buttons.z) then
            self.state = player_states.idle
        end
    end

    if self.x > 16 and btn(buttons.left) then self.x = self.x - self.speed end
    if self.x < 96 and btn(buttons.right) then self.x = self.x + self.speed end
end

local gen_state_names = {
    initial = 0,
    house_before = 1,
    house_after = 2,
}

map = {
    speed = 1,
    max_house_height = 3,
    width = system.width / 8 + 1,
    min_house_width = 1,
    max_house_width = 4,
    max_distance = 5,
    min_initial_distance = 20,

    height = 2 + 3 + 1,
    shift = 0,

    base = 1,
    state = gen_state_names.initial,
    initial = true,

    data = {},
    house_height = 0,
    house_position = 0,
    house_width = 0,
    house_distance = 0,
}

function map:generate()
    local base = self.base
    if self.data[base] == nil then
        self.data[base] = {}
    end

    local column = self.data[base];
    for i=1,self.height do
        column[i] = 0
    end

    -- ground
    for i=1, 2 do
        local x = rnd()
        local sprite = sprites.ground
        if x < 0.75 then
        elseif x < 0.85 then
            sprite = sprites.ground_2
        elseif x < 0.95 then
            sprite = sprites.ground_3
        else
            sprite = sprites.ground_4
        end

        column[i] = sprite
    end

    -- state machine
    if self.state == gen_state_names.initial then
        self.house_distance = self.house_distance + 1
        if not self.initial or self.house_distance >= self.min_initial_distance then
            self.initial = false

            -- add new house?
            local x = rnd()
            if self.house_distance >= self.max_distance or x < 0.1 then
                self.state = gen_state_names.house_before
                local y = rnd()
                local h = 1
                if y < 0.5 then
                    h = 1
                elseif y < 0.95 then
                    h = 2
                else
                    h = 3
                end
    
                self.house_height = h
                self.house_position = flr(rnd(h)) + 1
                self.house_width = 0
            end
        end
    elseif self.state == gen_state_names.house_before or self.state == gen_state_names.house_after then
        local chimney = false
        local skip = false
        local x = rnd()
        if self.state == gen_state_names.house_before then
            -- increase height? add chimney?
            if self.house_position < self.house_height then
                if x < 0.25 then
                    self.house_position = self.house_position + 1
                end
            else
                if self.house_width >= self.min_house_width and x < 0.75 then
                    chimney = true
                end
            end

            if self.house_width >= self.max_house_width then
                chimney = true
            end

            if chimney then
                self.state = gen_state_names.house_after
            end
        else
            -- decrease height? end?
            if self.house_width >= self.max_house_width or x < 0.4 then
                self.state = gen_state_names.initial
                self.house_distance = 0
                skip = true
            elseif self.house_position > 1 and x < 0.75 then
                self.house_position = self.house_position - 1
            end
        end

        -- draw house
        if not skip then
            self.house_width = self.house_width + 1
            for i=1, self.house_position do
                local sprite = sprites.house
                if i == 1 and chimney then
                    sprite = sprites.house_door
                end
                column[2 + i] = sprite
            end
    
            local sprite = sprites.roof
            if chimney then sprite = sprites.roof_chimney end
            column[2 + self.house_position + 1] = sprite
        end
    end

    self.base = (base % self.width) + 1
end

function map:get(x, y)
    if x > 1 and y > 1 and x < 128 and y < 128 then
        local sx = flr((x + self.shift) / 8)
        local dx = (self.base + sx - 1) % #self.data + 1
        local column = self.data[dx]
        local sy = flr((127 - y) / 8) + 1
        if sy <= #column then
            return column[sy]
        end
    end

    return nil
end

function map:update()
    self.shift = self.shift + self.speed
    while self.shift >= 8 do
        self:generate()
        self.shift = self.shift - 8
    end
end

projectiles = {
    g = 0.5,
    offset_x = -1,
    offset_y = -2,

    pool = { },
}

function projectiles:add(x, y)
    local pool = self.pool
    local p = nil
    for i=1, #pool do
        if not pool[i].active then
            p = pool[i]
            break
        end
    end

    if p == nil then
        p = {}
        pool[#pool + 1] = p
    end

    p.active = true
    p.x, p.y = x, y
    p.vx = 2
    p.vy = 2
end

function projectiles:update()
    local pool = self.pool
    for i=1, #pool do
        local p = pool[i]
        if p.active and p.debug == nil then
            p.vy = p.vy + projectiles.g
            p.x = p.x + p.vx
            p.y = p.y + p.vy

            -- check for collisions
            -- offset to middle and for sprite
            local map_sprite = map:get(p.x, p.y)
            if map_sprite ~= nil and map_sprite ~= 0 and not fget(map_sprite, 0) then
                -- p.active = false
                p.debug = colors.red
                if fget(map_sprite, 1) then
                    p.debug = colors.green
                    game.score = game.score + 1
                else
                    game.score = game.score - 1
                    -- todo: splat
                end
            end
        elseif p.debug ~= nil then
            p.x = p.x - map.speed
        end
    end
end

game = {
    score = 0,
}

function _init()
    for i=1, map.width do
        map:generate()
    end
end

function _update()
    map:update()
    projectiles:update()
    player:update()
end

-- rendering
function draw_sprite_block(block, x, y)
    for i = 1, #block do
        local row = block[i]
        for j = 1, #row do
            spr(row[j], x + 8 * (j - 1), y + 8 * (i - 1))
        end
    end
end

function player:draw()
    local player_block = sprite_blocks.santa_idle
    if player.state == player_states.throwing then player_block = sprite_blocks.santa_throwing end
    draw_sprite_block(player_block, player.x - 8, player.y - 8)

    local drift = sin(player.timer / player.period) * player.drift
    local x, y = player.x + 8, player.y - 8 + drift
    draw_sprite_block(sprite_blocks.reindeer, x, y)
    line(x, player.y, x + 8, y + 8, colors.light_gray)

    local last_x, last_y = x, y
    drift = sin(((player.timer + 5) % player.period) / player.period) * player.drift
    x, y = last_x + 16, player.y - 8 + drift
    draw_sprite_block(sprite_blocks.rudolph, x, y)
    line(x - 8, last_y + 8, x + 8, y + 8, colors.light_gray)
end

function map:draw()
    for i=1, #self.data do
        local x = 8 * (i - 1) - self.shift
        local column = self.data[(self.base + i - 2) % #self.data + 1]
        for j=1, #column do
            local y = 128 - 8 * j
            local sprite = column[j]
            if sprite > 0 then spr(sprite, x, y) end
            -- rectfill(x, y, x + 8, y + 8, sprite + 1)
        end
    end
end

function projectiles:draw()
    local pool = self.pool
    for i=1, #pool do
        local p = pool[i]
        if p.active then
            rectfill(p.x, p.y, p.x, p.y, p.debug or colors.yellow)
            -- spr(sprites.gift, p.x + projectiles.offset_x, p.y + projectiles.offset_y)
        end
    end
end

function game:draw()
    color(colors.white)
    print("score: " .. self.score)
end

function _draw()
    cls()
    game:draw()
    map:draw()
    player:draw()
    projectiles:draw()
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000050000000000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000700000000000000000000005050000000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000088800000000000000000004500000000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000
02000088770000000000000000004440555555555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000
00200007ff0000000000000000044444777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
02220000fff087660744666666644440ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
92222008770885000744444444444000fffffffff666666ff666666f000000000000000000000000000000000000000000000000000000000000000000000000
09322288888830500444444444445000ff66666ff6cccc6ff611a16f000000000000000000000000000000000000000000000000000000000000000000000000
09332288883330050044455555440000ff64446ff6cccc6ff613316f000000000000000000000000000000000000000000000000000000000000000000000000
09333333333390050040000000040000ff64446ff6cccc6ff618316f000000000000000000000000000000000000000000000000000000000000000000000000
09999999999990500040000000040000ff64496ff6cccc6ff6b33e6f000000000000000000000000000000000000000000000000000000000000000000000000
40040404040405000400000000400000ff64446ff666666ff666666f000000000000000000000000000000000000000000000000000000000000000000000000
55555555555550000400000004000000ff64446fffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
fff02766000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
77022500000000000000000000000000bbbbbbbbbbbbbbbbbbbbbb3bbbb33bbb0000000000000000000000000000000000000000000000000000000000000000
88823050000050000000000000000000bbbbbbbbbbbbbbbbb33bbbbbbb3333bb0000000000000000000000000000000000000000000000000000000000000000
88333005000500000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbb3333bb0000000000000000000000000000000000000000000000000000000000000000
38839005000050500000000000000000bbbbbbbbbbbb333bbbbbbbbbbb3333bb0000000000000000000000000000000000000000000000000000000000000000
99799050000045000000000000000000bbbbbbbbbbbbbbbbbb33333bbbb33bbb0000000000000000000000000000000000000000000000000000000000000000
04040500000044400000000000000000bbbbbbbb3333bbbbbbbbbbbbbb5555bb0000000000000000000000000000000000000000000000000000000000000000
55555000000444480000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
07000000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f7f00000070f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f7f00000070000000000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000f70f000007000000000000f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000f700f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000f0000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000001020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
