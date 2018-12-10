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

    coal = 35,

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

queue = {}
function queue.create()
    local q = {
        _list = {},
        _count = 0
    }
    setmetatable(q, { __index = queue })

    return q
end

function queue:enqueue(item)
    local list = self._list
    local count = self._count
    for i=1, count do
        list[count + 1 - i] = list[count - i]
    end
    list[1] = item
    self._count = count + 1
end

function queue:dequeue(item)
    local item = nil
    local count = self._count
    if count > 0 then
        local list = self._list
        item = list[count]
        list[count] = nil
        self._count = count - 1
    end
    return item
end

function queue:is_empty()
    return self._count == 0
end

storyboard = {}
storyboard_states = {
    initial = 1,
    running = 2,
    paused = 3,
    done = 4,
}

function storyboard.create(steps)
    local sb = {
        _steps = steps,

        _state = storyboard_states.initial,
        _index = 1,
        _timer = 0,
    }
    setmetatable(sb, { __index = storyboard })

    return sb
end

local function create_positional_update(x, y, done)
    local f = function (self, progress)
        if progress == 0 then
            self.x0 = self.x
            self.y0 = self.y
            self.done = false
        elseif progress >= 1 then
            self.x = x
            self.y = y
            if not self.done and done ~= nil then
                self.done = true
                done(self)
            end
        else
            self.x = self.x0 + progress * (x - self.x0)
            self.y = self.y0 + progress * (y - self.y0)
        end
    end

    return f
end

function storyboard:reset()
    self._index = 0
    self._state = storyboard_states.initial
end

function storyboard:start()
    self:reset()
    self:resume()
end

function storyboard:pause()
    self._state = storyboard_states.paused
end

function storyboard:resume()
    local index = self._index + 1
    self._index = index
    if index <= #self._steps then
        local step = self._steps[index]
        local period = step[1]
        if period >= 0 then
            self._timer = period
            self._state = storyboard_states.running
        else
            self:pause()
        end

        self:set_progress(0)
    else
        self._state = storyboard_states.done
    end
end

function storyboard:is_active()
    return self._state == storyboard_states.running or self._state == storyboard_states.paused
end

function storyboard:get_state()
    return self._state, self._index, self._progress
end

function storyboard:set_progress(progress)
    self._progress = progress
    local callback = self._steps[self._index][2]
    if callback ~= nil then
        callback(self, progress)
    end
end

function storyboard:update()
    if self._state == storyboard_states.running then
        self._timer = self._timer - 1

        local step = self._steps[self._index]
        local progress = 1
        if self._timer > 0 then
            local period = step[1]
            progress = (step[1] - self._timer) / step[1]
        end

        self:set_progress(progress)

        if self._timer <= 0 then
            self:resume()
        end
    end
end

-- game logic
player_states = {
    idle = 1,
    throwing = 2,
}

player = {
    gift_period = 10,

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
            if self.counter == 0 then
                local throw = nil -- true for gift; false for coal
                if game.gifts > 0 and btn(buttons.z) then
                    throw = true
                    game.gifts = game.gifts - 1
                elseif btn(buttons.x) then
                    throw = false
                end

                if throw ~= nil then
                    self.state = player_states.throwing
                    self.counter = self.gift_period
                    projectiles:add(self.x, self.y, throw)
                end
            end
        elseif self.state == player_states.throwing then
            if not btn(buttons.z) then
                self.state = player_states.idle
            end
        end
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
    default_speed = 1,
    default_max_distance = 4,
    default_max_house_width = 4,
    default_coal_rate = 0,

    speed = 1,
    max_distance = 4,
    max_house_width = 4,
    coal_rate = 0,

    max_house_height = 3,
    width = system.width / 8 + 1,
    min_house_width = 1,
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
    house_color = 0,

    targets = pool.create(),
    target_radius = 5,

    animations = pool.create(),
}

house_colors = {
    colors.dark_blue,
    colors.dark_purple,
    colors.dark_green,
    colors.dark_gray,
    colors.indigo,
}

function map:generate()
    local base = self.base
    if self.data[base] == nil then
        self.data[base] = {}
    end

    local column = self.data[base];
    for i=1,self.height do
        if column[i] == nil then column[i] = {} end
        local column = column[i]
        column.sprite = 0
        column.color = nil
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

        column[i].sprite = sprite
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
            self.house_color = house_colors[flr(rnd(#house_colors)) + 1]
            self.has_tree = false
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
                elseif self.has_tree == false and rnd() < 0.4 then
                    sprite = sprites.house_tree
                    self.has_tree = true
                end
                local item = column[2 + i]
                item.sprite = sprite
                item.color = self.house_color
            end
    
            local sprite = sprites.roof
            local j = 2 + self.house_position + 1
            if chimney then
                sprite = sprites.roof_chimney

                -- note target
                local target = self.targets:add()
                local x, y = map:get_xy(#self.data + 1, j)
                target.x, target.y = x + 4, y + 4
                target.gift = (rnd() >= self.coal_rate)
                target.timer = 0
                target.hit = false
            end
            column[j].sprite = sprite
        end
    end

    self.base = (base % self.width) + 1
end

function map:get_sprite(x, y)
    if x > 1 and y > 1 and x < 128 and y < 128 then
        local sx = flr((x + self.shift) / 8)
        local dx = (self.base + sx - 1) % #self.data + 1
        local column = self.data[dx]
        local sy = flr((127 - y) / 8) + 1
        if sy <= #column then
            return column[sy].sprite
        end
    end

    return nil
end

function map:get_xy(i, j)
    return 8 * (i - 1) - self.shift, 128 - 8 * j
end

function map:add_animation(sequence, x, y, color)
    local animation = self.animations:add()
    animation.sequence = sequence
    animation.x, animation.y = x, y
    animation.color = color
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
    offset_x = -2,
    offset_y = -3,

    pool = pool.create(),
}

projectile_colors = {
    colors.red,
    colors.pink,
    colors.orange,
}

function projectiles:add(x, y, gift)
    local p = self.pool:add()
    p.gift = gift
    if (gift) then p.color = projectile_colors[flr(rnd(#projectile_colors)) + 1] end
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
        local gift = p.gift
        local hit_target = targets:for_each(function (target)
            if x >= target.x - radius and x <= target.x + radius and y >= target.y - radius and y <= target.y + radius then
                target.hit = true
                targets:remove(target)
                return target
            end
        end)

        if hit_target ~= nil then
            pool:remove(p)

            if p.gift == hit_target.gift then
                game.score = game.score + 1
                map:add_animation(sequences.check, hit_target.x - 2, hit_target.y - 4)
            else
                map:add_animation(sequences.ex, hit_target.x - 2, hit_target.y - 4)
            end
        else
            -- collisions with walls
            local map_sprite = map:get_sprite(p.x, p.y)
            if map_sprite ~= nil and map_sprite ~= 0 and not fget(map_sprite, 0) then
                pool:remove(p)
                if p.gift then
                    map:add_animation(sequences.gift_smash, x - projectiles.offset_x, y - projectiles.offset_y, p.color)
                    -- todo: consider animation for coal smash
                end
            end
        end
    end)
end

game_states = {
    title = 1,
    info = 2,
    in_game = 3,
    result = 4,
    final = 5,
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
            "some christmas cheer throughout",
            "the 7 cities of grinch county!",
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
        number = 1,
        name = generate_name(),
        houses = 3,
        gifts = 4,
    },
    {
        number = 2,
        name = generate_name(),
        text = { "(let's pick up the pace)" },
        houses = 5,
        gifts = 6,
        speed = 1.25
    },
    {
        text = {
            "use 'x' to toss coal",
            "",
            "only throw coal when indicated",
            "or you'll upset good little",
            "boys and girls",
        },
        houses = 1,
        gifts = 2,
        coal_rate = 1,
        minimum = 1,
    },
    {
        number = 3,
        name = generate_name(),
        text = { "(let's speed things up)" },
        houses = 8,
        gifts = 8,
        speed = 1.5,
        coal_rate = 0.15,
    },
    {
        number = 4,
        name = generate_name(),
        text = { "(hurry up!)" },
        houses = 10,
        gifts = 10,
        speed = 1.75,
        coal_rate = 0.2,
    },
    {
        number = 5,
        name = generate_name(),
        text = { "(full speed ahead!)" },
        houses = 15,
        gifts = 15,
        speed = 2,
        coal_rate = 0.2,
        max_distance = 3,
    },
    {
        number = 6,
        name = generate_name(),
        houses = 20,
        gifts = 20,
        speed = 2,
        coal_rate = 0.2,
        max_distance = 1,
        max_house_width = 2,
    },
    {
        number = 7,
        name = generate_name(),
        text = { "(ludicrous speed--go!)" },
        houses = 25,
        gifts = 25,
        speed = 2.5,
        coal_rate = 0.2,
        max_distance = 1,
        max_house_width = 2,
    },
}

local default_storyboard_period = 10
marquee = storyboard.create({
    { default_storyboard_period, function (self, progress) self.progress = progress / 2 end },
    { -1, function (self, progress) self.progress = 0.5 end },
    { default_storyboard_period, function (self, progress)
        self.progress = 0.5 + progress / 2
        if progress == 1 then
            if not self.queue:is_empty() then
                self.lines = self.queue:dequeue()
                self:reset()
            end
        end
    end },
})
marquee.queue = queue.create()

function marquee:show(lines)
    if self:is_active() then
        self.queue:enqueue(lines)
    else
        self.lines = lines
        self:start()
    end
end

local nop = function() end
meter = storyboard.create({
    { 15, nop },
    { default_storyboard_period, create_positional_update(system.width / 2 - 64 / 2, 22) },
    { 15, function (self) self.show_delta = flr(100 * (game.last_overall_score - self.score)) end },
    { 30, function (self, progress) self.score = self.score + progress * (game.last_overall_score - self.score) end },
    { -1, nop },
    { 1, function(self) self.show_delta = nil end },
    { default_storyboard_period, create_positional_update(system.width - 64, 0, function (self) self.last_score = game.last_overall_score end) },
})

local final_messages = {
    { 0.98, "christmas cheer reigns supreme!" },
    { 0.95, "merry christmas to all!" },
    { 0.9, "that was a pretty good christmas" },
    { 0.8, "that was an ok christmas" },
    { 0.7, "a pretty mediocre christmas..." },
    { 0.6, "merry christmas?" },
    { 0.5, "better luck next year" },
    { 0, "there goes christmas :(" },
}

game = {
}

function game:init()
    self.state = game_states.info
    self.level = 1
    self.score = 0
    self.gifts = 0
    self.houses = 0
    self.last_z = false
    self.score_numerator = 0
    self.score_denominator = 0
    self.last_overall_score = 0.35

    self:load_level()

    meter.score = self.last_overall_score
    meter.x = system.width
    meter.y = -12
end

function game:get_overall_score()
    return (0.4 + 0.6 * (self.level - 2) / (#levels - 2)) * self.score_numerator / self.score_denominator
end

function game:load_level()
    self.state = game_states.info

    local lines = {}
    local level = levels[self.level]
    if level.name then
        lines[1] = "city " .. level.number .. " of 7:"
        lines[2] = level.name .. " (population: " .. level.houses .. ")"
        lines[3] = ""
    end
    if level.text ~= nil then
        for i=1, #level.text do
            lines[#lines + 1] = level.text[i]
        end
    end
    marquee:show(lines)
end

function game:update()
    local advance = false
    local reset = false
    local z = btn(buttons.z)
    local last_state = self.state
    if self.state == game_states.info then
        if not z and self.last_z and (marquee:get_state() == storyboard_states.paused) then
            marquee:resume()
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
                self.state = game_states.result
                self.score_numerator = self.score_numerator + self.score
                self.score_denominator = self.score_denominator + levels[self.level].houses
                self.last_overall_score = self:get_overall_score()
                meter:start()
            else
                self.state = game_states.info
                marquee:show({"try again"})
                reset = true
            end
        end
    elseif self.state == game_states.result then
        if not z and self.last_z and (meter:get_state() == storyboard_states.paused) then
            meter:resume()
            advance = true
        end
    elseif self.state == game_states.final then
        if not z and self.last_z then
            if marquee:get_state() == storyboard_states.paused then
                marquee:resume()
            elseif marquee:get_state() == storyboard_states.done then
                game:init()
            end
        end
    end

    if advance then
        local score = game.last_overall_score
        if self.level == #levels then
            self.state = game_states.final

            marquee:show({
                "grinch county total:",
                "" .. game.score_numerator .. " / " .. game.score_denominator,
                "",
                "christmas cheer: " .. ceil(100 * score) .. "%",
            })

            for i=1,#final_messages do
                local message = final_messages[i]
                if score >= message[1] then
                    marquee:show({"", message[2]})
                    break
                end
            end
        else
            reset = true
            self.level = self.level + 1
            self:load_level()
        end
    end

    if reset then
        local level = levels[self.level]
        self.score = 0
        self.gifts = level.gifts
        self.houses = level.houses

        map.speed = level.speed or map.default_speed
        map.max_distance = level.max_distance or map.default_max_distance
        map.max_house_width = level.max_house_width or map.default_max_house_width
        map.coal_rate = level.coal_rate or map.default_coal_rate
    end

    if last_state == self.state then
        self.last_z = z
    else
        self.last_z = false
    end

    marquee:update()
    meter:update()
end

function _init()
    game:init()
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
            local item = column[j]
            local sprite = item.sprite
            if sprite > 0 then
                local color = item.color
                if color ~= nil then pal(colors.peach, color) end
                spr(sprite, x, y)
                if color ~= nil then pal() end
            end
        end
    end

    self.targets:for_each(function (target)
        if not target.hit then
            local x, y = target.x, target.y - 10 - 2 * sin((target.timer % 45) / 45)
            pal(colors.peach, colors.red)
            spr(target.gift and sprites.gift or sprites.coal, x + projectiles.offset_x, y - 1 + projectiles.offset_y)
            pal()
            spr(sprites.arrow, x - 3, y)
        end
    end)

    self.animations:for_each(function (animation)
        local color = animation.color
        if color ~= nil then pal(colors.peach, color) end
        spr(animation.sequence.frames[animation.index], animation.x, animation.y)
        if color ~= nil then pal() end
    end)
end

function projectiles:draw()
    self.pool:for_each(function (p)
        if p.gift then
            pal(colors.peach, p.color)
            spr(sprites.gift, p.x + projectiles.offset_x, p.y + projectiles.offset_y)
            pal()
        else
            spr(sprites.coal, p.x + projectiles.offset_x, p.y + projectiles.offset_y)
        end
    end)
end

function marquee:draw()
    local center = 1.5 * system.width - self.progress * system.width * 2
    local lines = self.lines
    local y = 16
    for i=1, #lines do
        local line = lines[i]
        print(line, center - 4 * #line / 2, y)
        y = y + 6
    end
end

function meter:draw()
    local x, y = self.x, self.y
    print("christmas cheer", x + 32 - 15 * 4 / 2, y, colors.white)
    rectfill(x, y + 6, x + 64, y + 11, colors.light_gray)
    rectfill(x, y + 7, x + 64, y + 10, colors.dark_gray)
    rectfill(x, y + 7, x + ceil(64 * self.score), y + 10, colors.red)

    local delta = self.show_delta
    if delta ~= nil then
        local text
        if delta >= 0 then
            text = "+"
        else
            text = ""
        end
        text = text .. delta .. "%"
        print(text, system.width / 2 - 2 * #text, y + 13, colors.white)
    end
end

function game:draw()
    color(colors.white)

    if self.level > 1 then
        print("score: " .. self.score .. " / " .. levels[self.level].houses, 0, 0)
        print("gifts: " .. self.gifts, 0, 6)
    end

    if marquee:is_active() then
        marquee:draw()
    end

    meter:draw()

    local prompt = self.state == game_states.info or self.state == game_states.result or self.state == game_states.final
    if prompt then
        if marquee:get_state() == storyboard_states.paused or meter:get_state() == storyboard_states.paused then
            print("press 'z' to continue >", 36, 88, colors.white)
        elseif self.state == game_states.final and marquee:get_state() == storyboard_states.done then
            print("press 'z' to start over >", 28, 88, colors.white)
        end
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
00000000000000000000000000005000000000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000050000000000000008800000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000700000000000000000000005050555555555558855500000000000000000000000000000000000000000000000000000000000000000000000000000000
00000088800000000000000000004500555555555558855500000000000000000000000000000000000000000000000000000000000000000000000000000000
02000088770000000000000000004440555555555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000
00200007ff0000000000000000044444777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
02220000fff087660744666666644440ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
92222008770885000744444444444000fffffffff666666ff666666f000000000000000000000000000000000000000000000000000000000000000000000000
09322288888830500444444444445000ff66666ff6cccc6ff6ccac6f000000000000000000000000000000000000000000000000000000000000000000000000
09332288883330050044455555440000ff64446ff6cccc6ff6c33c6f000000000000000000000000000000000000000000000000000000000000000000000000
09333333333390050040000000040000ff64446ff6cccc6ff6c83c6f000000000000000000000000000000000000000000000000000000000000000000000000
09999999999990500040000000040000ff64496ff6cccc6ff6b33e6f000000000000000000000000000000000000000000000000000000000000000000000000
40040404040405000400000000400000ff64446ff666666ff666666f000000000000000000000000000000000000000000000000000000000000000000000000
55555555555550000400000004000000ff64446fffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000
fff02766000000000000000006550000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
770225000000000000bbb30065550000bbbbbbbbbbbbbbbbbbbbbb3bbbb33bbb0000000000000000000000000000000000000000000000000000000000000000
888230500000500000bbb30055655000bbbbbbbbbbbbbbbbb33bbbbbbb3333bb0000000000000000000000000000000000000000000000000000000000000000
883330050005000000bbb30005555000bbbbbbbbbbbbbbbbbbbbbbbbbb3333bb0000000000000000000000000000000000000000000000000000000000000000
38839005000050500bbbbb3000500000bbbbbbbbbbbb333bbbbbbbbbbb3333bb0000000000000000000000000000000000000000000000000000000000000000
997990500000450000bbb30000000000bbbbbbbbbbbbbbbbbb33333bbbb33bbb0000000000000000000000000000000000000000000000000000000000000000
0404050000004440000b300000000000bbbbbbbb3333bbbbbbbbbbbbbb5555bb0000000000000000000000000000000000000000000000000000000000000000
55555000000444480000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000000000000000000000000000000000000000000000000
07070000000000000000000000000000000000000000000000000000820000887700007700000000000000000000000000000000000000000000000000000000
ff7ff0000f707ff00000007f0000000000000bb30000077700000000882008827770077700000000000000000000000000000000000000000000000000000000
7777700000f0707000000000000000000000bb300000777000000000088288200777777000000000000000000000000000000000000000000000000000000000
ff7ff000770700000000000700000000b30bb3007707770000000000008882000077770000000000000000000000000000000000000000000000000000000000
00000000f0700f000000070000000000bb3b30007777700000000000008882000077770000000000000000000000000000000000000000000000000000000000
000000000f0f000000007000000000000bb300000777000000000000088228200777777000000000000000000000000000000000000000000000000000000000
0000000000000000f070000f00000007003000000070000000000000882008827770077700000000000000000000000000000000000000000000000000000000
000000000000000000f0f000f0700000000000000000000000000000820000887700007700000000000000000000000000000000000000000000000000000000
__gff__
0000000001020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
