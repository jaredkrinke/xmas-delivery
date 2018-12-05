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
    x = 30,
    y = 64,
    speed = 1,
    state = player_states.idle,
    timer = 0,
    period = 2 * 30,
    drift = 3,
}

local gen_state_names = {
    initial = 0,
    house_before = 1,
    house_after = 2,
}

map = {
    data = {},
    width = screen.width / 8 + 1,
    max_house_height = 3,
    height = 2 + 3 + 1,
    base = 1,
    shift = 0, -- todo: needed?
    state = gen_state_names.initial,
    house_height = 0,
}

function map:generate()
    local base = self.base
    if self.data[base] == nil then
        self.data[base] = {}
    end

    local column = self.data[base];
    for i=1,self.height do
        data[i] = 0
    end

    -- ground
    for i=1, 2 do
        local x = rnd()
        if x < 0.5 then
            column[i] = sprites.ground
        elseif x < 0.7 then
            column[i] = sprites.ground_1
        elseif x < 0.8 then
            column[i] = sprites.ground_2
        else
            column[i] = sprites.ground_3
        end
    end

    -- state machine
    if self.state == gen_state_names.initial then
    elseif self.state == gen_state_names.house_before then
    elseif self.state = gen_state_names.house_after then
    else
        -- error!
    end

    self.base = (base % self.width) + 1
end

houses = {
    list = {},
    color_base = colors.peach,
    colors = {
        colors.dark_blue,
        colors.dark_green,
        colors.green,
        colors.red,
        colors.orange,
        colors.yellow,
        colors.green,
        colors.indigo,
    },
    sprite_map = {
        sprites.house,
        sprites.house_door,
        sprites.house_tree,
    }
}

function houses:add()
    local house = {}
    house.color = houses.colors[flr(rnd(#houses.colors)) + 1]

    -- outline
    house.target = 2
    house.mask = {
        { 3, 2, 1 },
        { 0, 1, 1 },
    }
    -- todo
    -- local height = flr(rnd(3)) + 1
    -- local width = flr(rnd(5)) + 1
    -- local left = 1
    -- for local i=1, height do
    --     local row = {}
    --     for local j=1, width do
    --         row[left + j] = true
    --     end
    --     mask[i] = row

    --     left = flr(rnd(width - left + 1))
    --     if left <= 0 then break end
    -- end

    self.list[#self.list + 1] = house
end

function _init()
    houses:add()
end

function _update()
    player.timer = (player.timer + 1) % player.period
    if btn(buttons.up) then player.y = player.y - player.speed end
    if btn(buttons.down) then player.y = player.y + player.speed end
    if btn(buttons.left) then player.x = player.x - player.speed end
    if btn(buttons.right) then player.x = player.x + player.speed end
    if btn(buttons.z) then player.state = player_states.throwing else player.state = player_states.idle end
end

-- rendering
function draw_sprite_block(block, x, y)
    for i = 1, #block do
        local row = block[i]
        for j = 1, #row do
            spr(row[j], x + 8 * (j - 1), y + 8 * (i - 1))
            -- rectfill(x + 8 * (j - 1), y + 8 * (i - 1), x + 8 * (j), y + 8 * (i), row[j] % 16)
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

function houses:draw()
    local x0 = 64
    local y0 = 112
    for k=1, #self.list do
        local house = self.list[k]
        pal(houses.color_base, house.color)

        -- structure
        local mask = house.mask
        local roof_heights = {}
        local width = #mask[1]
        for i=1, #mask do
            local row = mask[i]
            for j=1, #row do
                if row[j] > 0 then
                    spr(houses.sprite_map[row[j]], x0 + 8 * (j - 1), y0 - 8 * (i - 1))
                end

                if roof_heights[j] == nil and row[j] == 0 then
                    roof_heights[j] = i - 1
                end
            end
        end

        -- roof
        for j=1, width do
            local height = roof_heights[j]
            if height == nil then height = #mask end

            local sprite = sprites.roof
            if j == house.target then sprite = sprites.roof_chimney end
            spr(sprite, x0 + 8 * (j - 1), y0 - 8 * height)
        end

        pal()
    end
end

function _draw()
    cls()
    player:draw()
    houses:draw()
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
