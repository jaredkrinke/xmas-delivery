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

    arrow = 34,

    check = 52,
    check_mask = 53,
    plus_one = 54,

    ex = 55,
    ex_mask = 56,
    minus_one = 57,
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

sequences = {
    gift_smash = {
        period = 3,
        frames = {
            sprites.gift_smash1,
            sprites.gift_smash2,
            sprites.gift_smash3,
        }
    },
    check = {
        period = 3,
        frames = {
            sprites.check,
            sprites.check_mask,
            sprites.check,
            sprites.check_mask,
            sprites.check,
            sprites.check,
        }
    },
    ex = {
        period = 3,
        frames = {
            sprites.ex,
            sprites.ex_mask,
            sprites.ex,
            sprites.ex_mask,
            sprites.ex,
            sprites.ex,
        }
    },
}

system = {
    width = 128,
    height = 128,
}

-- debugging
local debug = false
debug_message = nil

-- utilities
pool = {}
function pool.create()
    local p = {
        data = {},
    }
    setmetatable(p, { __index = pool })

    return p
end

function pool:add()
    local item = nil
    local data = self.data
    for i=1, #data do
        if data[i]._pool_active == false then
            item = data[i]
            break
        end
    end

    if item == nil then
        item = {}
        data[#data + 1] = item
    end

    item._pool_active = true

    return item
end

function pool:remove(item)
    item._pool_active = false
end

function pool:for_each(f)
    local data = self.data
    for i=1, #data do
        local item = data[i]
        if item._pool_active then
            local result = f(data[i])
            if result ~= nil then return result end
        end
    end
end

function pool:is_empty()
    return not self:for_each(function (item) return true end)
end

-- game logic
player_states = {
    idle = 1,
    throwing = 2,
}

player = {
    gift_period = 10,
    speed = 2,

    x = 16,
    y_base = 56,
    y = 56,
    state = player_states.idle,
    timer = 0,
    drift_period = 2 * 30,

    counter = 0,
}

function player:update()
    self.timer = (self.timer + 1) % self.drift_period
    if self.counter > 0 then self.counter = self.counter - 1 end

    if game.state == game_states.in_game then
        if self.state == player_states.idle then
            if self.counter == 0 and game.gifts > 0 and btn(buttons.z) then
                self.state = player_states.throwing
                self.counter = self.gift_period
                game.gifts = game.gifts - 1
                projectiles:add(self.x, self.y)
            end
        elseif self.state == player_states.throwing then
            if not btn(buttons.z) then
                self.state = player_states.idle
            end
        end
    
        if self.x > 16 and btn(buttons.left) then self.x = self.x - self.speed end
        if self.x < 96 and btn(buttons.right) then self.x = self.x + self.speed end
    else
        self.state = player_states.idle
    end
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
    max_distance = 4,
    min_initial_distance = 20,

    height = 2 + 3 + 1,
    shift = 0,

    base = 1,
    state = gen_state_names.initial,

    data = {},
    house_height = 0,
    house_position = 0,
    house_width = 0,
    house_distance = 0,

    targets = pool.create(),
    target_radius = 5,

    animations = pool.create(),
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
    if game.state ~= game_states.in_game then self.state = gen_state_names.initial end

    if game.state == game_states.in_game and self.state == gen_state_names.initial then
        self.house_distance = self.house_distance + 1
        -- add new house?
        if game.houses > 0 and (self.house_distance >= self.max_distance or rnd() < 0.15) then
            self.state = gen_state_names.house_before
            game.houses = game.houses - 1
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
            local j = 2 + self.house_position + 1
            if chimney then
                sprite = sprites.roof_chimney

                -- note target
                local target = self.targets:add()
                local x, y = map:get_xy(#self.data + 1, j)
                target.x, target.y = x + 4, y + 4
                target.timer = 0
                target.hit = false
            end
            column[j] = sprite
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

function map:get_xy(i, j)
    return 8 * (i - 1) - self.shift, 128 - 8 * j
end

function map:add_animation(sequence, x, y)
    local animation = self.animations:add()
    animation.sequence = sequence
    animation.x, animation.y = x, y
    animation.timer = animation.sequence.period
    animation.index = 1
end

function map:update()
    self.shift = self.shift + self.speed
    while self.shift >= 8 do
        self:generate()
        self.shift = self.shift - 8
    end

    local animations = self.animations
    animations:for_each(function (animation)
        animation.timer = animation.timer - 1
        animation.x = animation.x - self.speed
        if animation.timer <= 0 then
            animation.timer = animation.sequence.period
            animation.index = animation.index + 1
        end

        if animation.index > #animation.sequence.frames then
            animations:remove(animation)
        end
    end)

    local targets = self.targets
    targets:for_each(function (target)
        target.timer = target.timer + 1
        target.x = target.x - self.speed
        if target.x <= 16 then
            target.hit = true
            targets:remove(target)
            map:add_animation(sequences.ex, target.x - 4, target.y - 4)
        end
    end)
end

projectiles = {
    g = 0.5,
    offset_x = -1,
    offset_y = -2,

    pool = pool.create(),
}

function projectiles:add(x, y)
    local p = self.pool:add()
    p.x, p.y = x, y
    p.vx = 2
    p.vy = 2
end

function projectiles:update()
    local pool = self.pool
    local targets = map.targets
    local radius = map.target_radius
    pool:for_each(function (p)
        p.vy = p.vy + projectiles.g
        p.x = p.x + p.vx
        p.y = p.y + p.vy

        -- check for collisions with targets
        local x, y = p.x, p.y
        local hit = targets:for_each(function (target)
            if x >= target.x - radius and x <= target.x + radius and y >= target.y - radius and y <= target.y + radius then
                target.hit = true
                targets:remove(target)
                map:add_animation(sequences.check, target.x - 2, target.y - 4)
                return true
            end
        end)

        if hit then
            pool:remove(p)
            game.score = game.score + 1
        else
            -- collisions with walls
            local map_sprite = map:get(p.x, p.y)
            if map_sprite ~= nil and map_sprite ~= 0 and not fget(map_sprite, 0) then
                pool:remove(p)
                map:add_animation(sequences.gift_smash, x - projectiles.offset_x, y - projectiles.offset_y)
            end
        end
    end)
end

game_states = {
    title = 1,
    info = 2,
    in_game = 3,
    result = 4,
    lost = 5,
    won = 6,
}

names = {
    a = {
        "belle",
        "grape",
        "kirk",
        "gig",
        "park",
        "sea",
        "notting",
        "colling",
        "ritz",
    },
    b = {
        "view",
        "wood",
        "land",
        "ham",
        "ville",
        "town",
    },
}

function generate_name()
    return names.a[flr(rnd(#names.a)) + 1] .. names.b[flr(rnd(#names.b)) + 1]
end

levels = {
    {
        text = {
            "hey, santa! it's time to spread",
            "some christmas cheer!",
        },
    },
    {
        text = {
            "use 'z' to toss out a gift",
            "",
            "try to get a gift in every",
            "chimney, but don't miss or you",
            "might run out of gifts",
        },
        houses = 1,
        gifts = 2,
        minimum = 1,
    },
    {
        name = generate_name(),
        houses = 3,
        gifts = 4,
    },
    {
        name = generate_name(),
        text = { "(let's pick up the pace)" },
        houses = 5,
        gifts = 6,
        speed = 1.25
    },
    {
        name = generate_name(),
        text = { "(let's speed things up)" },
        houses = 8,
        gifts = 9,
        speed = 1.5,
    },
    {
        name = generate_name(),
        text = { "(hurry up!)" },
        houses = 10,
        gifts = 11,
        speed = 1.75,
    },
    {
        name = generate_name(),
        text = { "(full speed ahead!)" },
        houses = 15,
        gifts = 16,
        speed = 2,
    },
}

game = {
    state = game_states.info,
    level = 1,

    score = 0,
    gifts = 0,
    houses = 0,
    last_z = false
}

function game:update()
    local advance = false
    local reset = false
    local z = btn(buttons.z)
    if self.state == game_states.info then
        if not z and self.last_z then
            if levels[self.level].houses then
                self.state = game_states.in_game
            else
                advance = true
            end
        end
    elseif self.state == game_states.in_game then
        if game.houses <= 0 and map.state == gen_state_names.initial and map.targets:is_empty() then
            local minimum = levels[self.level].minimum
            if not minimum or game.score >= minimum then
                advance = true
            else
                self.text = {"try again"}
                self.state = game_states.info
                reset = true
            end
        end
    end

    if advance then
        if self.level == #levels then
            self.state = game_states.won
        else
            reset = true
            self.level = self.level + 1
            self.text = nil
            self.state = game_states.info
        end
    end

    if reset then
        local level = levels[self.level]
        self.score = 0
        self.gifts = level.gifts
        self.houses = level.houses

        if level.speed ~= nil then map.speed = level.speed end
    end

    self.last_z = z
end

function _init()
    for i=1, map.width do
        map:generate()
    end
end

function _update()
    game:update()
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

    local drift = 3 * map.speed
    player.y = player.y_base + sin(player.timer / player.drift_period) * drift
    draw_sprite_block(player_block, player.x - 8, player.y - 8)

    local x, y = player.x, player.y
    for i=1,4 do
        local last_x, last_y = x, y
        x = x + 16
        y = player.y_base + sin(((player.timer + 5 * i) % player.drift_period) / player.drift_period) * drift
        draw_sprite_block(i == 4 and sprite_blocks.rudolph or sprite_blocks.reindeer, x - 8, y - 8)
        line(last_x + 4, last_y, x, y, colors.light_gray)
    end
end

function map:draw()
    for i=1, #self.data do
        local column = self.data[(self.base + i - 2) % #self.data + 1]
        for j=1, #column do
            local x, y = self:get_xy(i, j)
            local sprite = column[j]
            if sprite > 0 then spr(sprite, x, y) end
        end
    end

    self.targets:for_each(function (target)
        if not target.hit then
            spr(sprites.arrow, target.x - 3, target.y - 10 - 2 * sin((target.timer % 45) / 45))
        end
    end)

    self.animations:for_each(function (animation)
        spr(animation.sequence.frames[animation.index], animation.x, animation.y)
    end)
end

function projectiles:draw()
    self.pool:for_each(function (p)
        spr(sprites.gift, p.x + projectiles.offset_x, p.y + projectiles.offset_y)
    end)
end

function print_center(text, y)
    print(text, system.width / 2 - (4 * #text) / 2, y)
end

function game:draw()
    color(colors.white)

    if self.level > 1 then
        print("score: " .. self.score .. " / " .. levels[self.level].houses, 0, 0)
        print("gifts: " .. self.gifts, 0, 6)
    end

    if self.state == game_states.info then
        local y = 16
        local level = levels[self.level]

        if level.name then
            print_center("now entering:", y)
            y = y + 6
            print_center(level.name .. " (population: " .. level.houses .. ")", y)
            y = y + 12
        end

        text = self.text or level.text
        if text then
            for i=1, #text do
                print_center(text[i], y)
                y = y + 6
            end
        end

        print("press 'z' to continue >", 36, 88)
    elseif self.state == game_states.in_game then
    elseif self.state == game_states.won then
        print("you win! merry christmas!", system.width / 2 - 50, 36)
    end
end

function _draw()
    cls()
    game:draw()
    map:draw()
    player:draw()
    projectiles:draw()

    if debug and debug_message ~= nil then
        print(debug_message, system.width - 4 * #debug_message, 0, colors.white)
    end
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
770225000000000000bbb30000000000bbbbbbbbbbbbbbbbbbbbbb3bbbb33bbb0000000000000000000000000000000000000000000000000000000000000000
888230500000500000bbb30000000000bbbbbbbbbbbbbbbbb33bbbbbbb3333bb0000000000000000000000000000000000000000000000000000000000000000
883330050005000000bbb30000000000bbbbbbbbbbbbbbbbbbbbbbbbbb3333bb0000000000000000000000000000000000000000000000000000000000000000
38839005000050500bbbbb3000000000bbbbbbbbbbbb333bbbbbbbbbbb3333bb0000000000000000000000000000000000000000000000000000000000000000
997990500000450000bbb30000000000bbbbbbbbbbbbbbbbbb33333bbbb33bbb0000000000000000000000000000000000000000000000000000000000000000
0404050000004440000b300000000000bbbbbbbb3333bbbbbbbbbbbbbb5555bb0000000000000000000000000000000000000000000000000000000000000000
55555000000444480000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
07000000f00000000000000000000000000000000000000000000000820000887700007700000000000000000000000000000000000000000000000000000000
f7f00000070f0000000000000000000000000bb30000077700000b00882008827770077700000800000000000000000000000000000000000000000000000000
f7f00000070000000000f000000000000000bb30000077700000bb00088288200777777000008800000000000000000000000000000000000000000000000000
00000000f70f000007000000000000f0b30bb3007707770000b00b00008882000077770000000800000000000000000000000000000000000000000000000000
0000000000000000f700f00000000000bb3b3000777770000bb30b00008882000077770008820800000000000000000000000000000000000000000000000000
000000000000000000000000f0000f000bb300000777000000300b00088228200777777000000800000000000000000000000000000000000000000000000000
0000000000000000000000000700000000300000007000000000bb30882008827770077700008820000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000820000887700007700000000000000000000000000000000000000000000000000000000
__gff__
0000000001020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
