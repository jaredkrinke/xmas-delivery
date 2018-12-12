pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

-- title image
local bitmap_title = "80800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000000000005550000000000050000000000000000000000055ddd66666666666666dd55500000000005500000000000000000000000000000000000000000000000000000500000000000000000000000000000000005d666666666d666666666d6666666dd5000000550000000000000000000000000000000000000500000000000000000000000000000000000000000000005dd66666666666666666666666ddd55dddd66dd500000000000000000000000000000000000000000000000000000000000000000000000000000000000005d6666666666d66666666666666666dddd5555555d6dd5000000000500000000000000000000000000000000000000000000000000000000000000000000005d6666666666666666666666666666666666665555555dd6d50000000000000000000500000000000000000000000000000000000000000000000000000000566666666dd66666d666666666666666666666666d6dddd55d66d5000000000000000000000000000000000500000000000000000000000000000000000000d6666666666dd66666d6666666666666666666666666666d555666666500000000000000000000000000000000000000050000000000000000000000000000d6666666ddd6d666666d66666666666666666666666666655dd55666666665000000000000000000000000000000000000000000000000000000000000000056666666d555566d56666d666666666666666666666666666d55ddd6dd666666d50000000000000000000000000000000000000000000000000000000000000d666666d55555ddd666d65d66666666666666666666666666d6d5dd66dd5ddd66665005000000000000000000000000000000000000000000000500000000056666dd6d5555555ddd66dd5666666666666666666666666666655555ddddd5555d66d550000000005000000000000000000000000000000000000000000000d6666d5555555555556666dd66666666666666666666666666666d55555555d55555dd6d5500000000000000000000000000000000000000000000000005505d6666d555555555555d66666d66666666666666666666d555d6666d5555555555555d65d6d550000000000000000000000000000000000000000000500000056666665555555555555d666655d666666666666666666d55555555dddd5555555555556ddd655550050000000000000000000000000000000000000000000056666d55555555555d5dd6666d55566666666666666666655555555555555555555555555ddddd56d50500000050000000000000000000000000000000000005d666d5d55555555555ddd55d66555dd666666666666666d5555555555555555555d555555d5555d5dd500000000000000000000000000000000000000000005d666d55dd55555555556555d6ddd55dd666666666666666555555555555555555555d5555555ddd5d5655000000000000000000000000000000000000000005d666d55665555555555ddddd6655dd6666666666666666d5555555555555555555555d65555d55666d5dddd0000005000000000000000000000000000000005d666d5566d5555555555d5d666d556666666666666666655555555555555555555555dd6d555d5dd66dd5d66500000000005000000000000000000000000005dd66d5d66d555555d55d655d666dd666666666666666666d55555555555555555555555d65d5566d66dd65d5665000000000000000000000000000000000005d5dd65dd66dddd55dd55d66dd6666d66666666666666666665555555555555555555555555555ddd6666d665dd6d50000000000000000000000000000000005dddd66566d5dd5665dd55d666666666666666666666666666655555555555555555555555555555d66666666d5d66d50000000000000000000000000000005556d6666666dd66666d6d55d6d666666666666666666dd66666d55555555555555555555555555ddd66d66d6666d666dd50000000000000000000000000000055d666d5666655d66dddd5556666666666666666666666666666d55555555555555555555555d677777666d56777f77776d000000000000000000000000000005d666dd6666d55d66d5d6d5d6ddd66666d6666666666666666666d555555555555556666d55677feeef7765577e8888eff7d0000000000000000000000000005d6666dd66d5dd5d6666666d666d666665566666666666666667777d5555555dd67777fff76d7e888888e76d67e8eee88887d500000000000000000000000005dd666666d55d6d5d66666666666d666655566d66666666666667e87655ddd67777eefe888f7d788ef7fe8f6d67887777e8876550000000000000000000000055d66666dd5d5d66dd6666666666666666dd665dd6666666666667e8f7777777ee888888ee887677777ffe8f6567e8eeff7ef7ddd000000000000000000000005d66666ddd5dd6666666666666666666666665d5d6666666666667f8effeee7f8888fe8e77e87677fe88888f65d77e8888ef7655550550005000000000000005566666655dd6666666666666666666666666dd666666666666667fe888888e77fe8f7f8e77e8f77e88eeee8f6567f77ffe887d55555050000000000000000005d66666d5dd66666666666666666667777666d666666777777766f8888eff77767e8f778e77e8f7f8ef777f8e776f8f7777f8765555500000000000000000005566666666d66666666666666666667fee76666666677ffeee87667ff88f766dd57f8f778877f8e7e8e77fe888ef7f88eeee8e7d5555550000000000000000055d66666566dd6666666666666666667e887666666677e888888f76667e8f7555dd7f8e77e8f7f8eff88e888e888f7fee8888ef7555555500000000000000000556666666d5dd66666666666666666677f7766666667e8eff7e8f65556f8e7dd677778ef7e88e78887fe88ef7f77767777fff77d55555555000000000000000555666666666dd66666666666666666667777766666678877777f77d55678e7777f8ee888ff88e7ff777777766666d55dd6666655555555550050000000000005556ddd6666d6666666666666666666677ffe77666667e88e8888e7755d7e8fffe88e88ee777777666d5dddd55555555555555ddd55555555505000000000005555d556666d556666666666666666667fe888f7666d67fe88eeee8e7d557f88888ef77777666dd555555555555555555555555566d555555550000000000000555555d66666666666666666667777767e8ee8e7666d5d7777777f8e7d5567feeef776666d5555555555555555555555555555555d5555555555000000000000555555666666d6666666666777fe88f77777788766dd567ef77ff88f7d555677776d5566d55555555555555555555555555555555d5555555555000000000005555555d66666d666666667777f88e8e766667e8f7666d6f8888888f76555555555555dd6655555555555555555555555555555555d5d55555555500000000005555555d66666666666677fe8e88f777766667f8e777776788eeef7765555555555d6d6ddd5555555555555555555555555555555555555555555500000000055555d5677776666666667f88888e7677666667788fe887777777777665555555555d666555d555555555555555555555505555555555555555555500000000055555d67fe8776677776677efe8e7766666677ff88888e7667766666666d6555555d6666dd5555555555555555555555550055550555555555555555000000055555557f888f777feef766777f8e766666667e888eef7776666666666666666ddd55666666d555555555555555555555550055505555555555555555000000055555667fef8877e8888f7666778877777766f8ef77766d66666666666666666666666666665555555555555555555555550005555555555555555555000000055dd67f7777e8ee8eff88776667e8f7fe876677776d555d66666666666666666d6666666666d55555555555555555555555555555555555555555555550000005677ff8e767f888e777e8f76677f88888e766666d55555666666666666666666666666666666555555555555555005550555555555555555555555555500000567e88888f767e887767f8e7777e888ef77766666d555d5666666666666666666666666666666d5555555555550555055055555555555555555555550000000567e88efe8e767f8876667e8ff7f88ef7776d66666d555d6666666666666666666666666666666dd555555555555555550055555555555555555550000000000d7e8e7777ff7667e8f7667e888f7f77766666666666d555ddd6666666666666666666666666665dd5555555555555055000555555555555555500000000000006f8e76d56676667f8e777f888e7776666666666666665ddd55d66666666666666666666666666556d555555555555555500000555555555555550000000000007e8f755556666667e8ee7fef77766666666666666666566d55d6666666666666d6666666666665d6d555555555555555500000055555555555000000000000007e8f65555d677777e888f7777666666666666666666666666d66d66666666dd6d5d6666666666dd5d555555555555555500005555555555500000000000000007e8f75555d67e87f88ef76666666666666666d66666666666666d666666666d666d66666666666ddd555555555555555500055555555505555500000555550007f8e76555d67e877ef7766666666666666666666666666666666666666666665d6dddd6666666666d5555555555555550000555500555555550000055555500067e8f765d67f8e777766666666666666666666666666666666666666666666665ddd55d666666666dd5dd5555555555000005555555555055000005555555050d7f88f7777e88f766d66666666666666666666666666666666666666666666666dd005d666666666666dd5555500000000000550055550055000000555555550dd7f88eee888f766656666666666666666666666666666666666666666666666666500056666666d66d55500000000000000000005550000000000055555550055d7fe888ee77d566666666666666666666666666666666666666666666666666665000006666666666d00000000000000000055550550000000000555555500555d77777776d556666d6d55d66666666666666666666666666666666666666666d0005d66666666666d0000000000000000555555555050000005055555550055555d666dd5555dd66d50000d6666666666666666666666666666666666666666000066666666ddd5dd000000000000055555555555500000000555555555005555555555d555555dd500000566666666666666666666666666666666666666d00005666dd5d5d6666d00000000000555555555555550000000055555555500d555d5555555555ddd0005000066666666666666666666666666666666666d50000000d5ddd66666666500055555555555555555555555000000055555555500d55555555000055dd5dd6600000d6666dddd6666666666666666d66d500000000000056666666666d50000555555555555555555555555000000055555555550dd5555550000055555d666000000555005dddddd666666666666d050000000000000005dd66666665500555d5555555555555555555555500000055555555500d65555d0000000000005d600000000000505665566666666666dd0000000000000000000d6666665d5d665dd5555555555555555555555000000055555555500dd555d550000000000005d0000000055d5566d555ddddddddddd650000000000000005d55666665ddd66d5665555555555555555555555500000055555555500d6555555500000000000000000000ddd66056d55d5ddd66666666d00000000000005666ddd66656656666d66dd6d555555555555555555500000555555555500d6555555500000000000000000000d6d66d00d5dd55666666666d50005500005d66666656dd666d56666666666d5555555555555555555550000555555555500d6d55555500000000000000000000005666000d6d5d6666666d00000066d6666666666d5665666d666666d666ddd555555555555555555550000555555555000d6655d5550000000000000000000000066d000066dd666666655005d666666666666665666d66666666666666d65655d555555555555555555055555555550005665dd555000000000000000000000005d5000056dd666666dd5d666666666666666666666666666666666666d6665555555555555555555550555d6765550005665665500000000000000000000000000000000d5d6666665656666666666666666666666666666666666666666d55555555555555555555505d67ff7655000066dd6d66500000000000000000000000000000055566d6d56dd666666666666666666666666666666666666666d55555555555555555555555577e88f6550000666d6dd6500000000000000000000000000000055d6666d66566666666666666666666666666666ddd66666665555555555555555555555d6667e88e76550000d7666d66d00000000000000000000000000000555d6666665666666666666666666666666666666566666666dd5555555555555555555677ff77ff8e75550000566666666500000000000000000000000000055555ddd6666666666666666666666666666666dd6d6666666666555555555555555d6667fe8876778e7550000056666d666600000000000000000000000005dd5d5555d6d666666666666666d6666666666665665d66d66d66665555555555555567777f888e76678e7550000006666666666500000000000000055555d55dd55d55555d66666dd66666666666666666666666d5d66dd6dd6666d555555555d6677e88e7fe88f77f8e755000000d6666666666d50000055555566d5555d55555555555d66666666666666666d6666666666666d5666dd5ddd666d55555556777f7e8e88777f88e7f8e755000500566666666666d55555d66d55555555555555555555566666666666666666666666d66666666d666d55555d66dd555555d7fe88e8e77775d7fe88e8e7500000005666666666dd5555555ddd65dddd555555555555dd56666666666666666666666666666dddd666dd555666d5666666d5d788888e76ddd50d77e888f65000000056666666d55555555ddd55555ddd65dd55555d55d55d6666666666666666666666666d666dd665d6d5ddd5d677fff776d7fff88f75555500567f88f6550050000d6666666d5505555dd66666666665d555555555555d6666666666666666666666666d666666d55555d65d77e88888f76d66788765ddd5005567e8f77d555000056666666d5555555566666666666d655555555555d666666666666666666677776666d666d6d6d66777777e88eee88e7d5d7e8f777776555557e8eef655500000d666666d55555555666d6dd66d66d5556d555555d66666666666666666667fe766666666666677feee77e8e7777f88f6557f8e7fe8e755d677e888f6555000055766666655555555d66d6dd66666d555dd555555555d6666666666666666788f766666777777f888887f88777fe888f6d77f88888ef75d77fe88ef765505500006666666d5555555d5d66d5666dd555555555555555dd67777f7666666667ff7766667ffe8877e88e77f8efe888ef77767e888eff77d5d7e88ef7765050550000d7666666d5555555556ddd5d66dd55555555555555d67fee887766666d6777776666f8888e777e8f76f888eef777fe77f8eef776d555d7ee777d500000550000566666665d55555555d6665566d655555555555555d67e8888f766666677ffef76667ef88f767e8766788e7777fe887677776d55555556776d500000005500055d666666d555555566666dd5d66dd55555555555555677f7e8f7666667f8888f7666677f887778e76d7f88eee888ef7dd6d55555555555d55500000000555555556666666dd55555d6666666666ddd555555555d6dd66777f8e7666667feee8e76d6d567e887f8e75567f88888ef77d55555555555555555550000000055555555d66666666d555556777777f7776655ddd666666d66666678e766666677778876665d667e8ee8f7555677fff776d55555555555555555555000000000555555555666666666d5dd67fee88888ef776d66777ff77766666678876666666667e87665ddd567e888f65555d66666d5555555555555555555555000050000555555555d6666666dd5d667f8888eee88e76667fe8888e77666667e8f76666d6667e8f77776d5d77e8e7655d5555555555555555555555555555500000000005555555555666666666666667f8e7777f88f767f888ee8887766667e8f7666666667f8e7fef7d5d677777d555555555555555555555555555555550000000000555555555556666666666666778e7dd67f8e77f88f7777e8e766667f8e766666777fe88888e7dddd666dd555555555555555555555555555555550000000000055555555555d666666666666678876dd678877e8e7777fe88766667f8e7777767e88888eff77d666d55dd5d55555555555555555555555555555000000000000000005555550d6666666666667e876dd67e8f7e8eee8888ee776777788fee8777eeef777766666555ddd5555555555555555555555555555555500000000000000000000000056666665d66667e8766d67e8f7e88eefff7777777eee88888e767777766dd5666d5d55555555555555555555555555555555555000000000000050000000000005666666556667e8f7d667e8f7f8e77777fe8e77e888eeff7776666666666665555555555555555555555555555555555555550000000000000050000050000000d6666665d667e8f7677f88777e88eee8888f777ff777776666666666666d555555555555555555555555555555555555555000000000000000000055500000050d66d666d667f8f77fe88f7677e88888ef776677766666666666666666d55555d55555555555555555555555555555555550000000000000000000055000000505666666667fe8888888f7666777fff777766666666666666666666665555ddd55555555555555555555555555555555550000000000000000000000000000000056d666667e888eeef776666667766766666666666666666666666d555555555d555555555555555555555555555555500005500000000000000000000000000005d5d666777777777766666666666666666666666666666d66666dddd55555555555555555555555555555555555550000000000000000000000000000000000005d5d66d6666666666666666666666666666666666666d6666666d5dd6d555555555555555555555555555555555000500000000000000000000000000000000005d566dd666666666666d666666666666666666666d66666666d55556d5555555555555555555555555555555500005500000000000000000000000000000000005dddd5d666666666666666666666666666666666666666666d55d6655555555555555555555555555555555000000000000000000000000000000000000000000566d55d6d666666666666666666676666666666666666ddd555d555d55555555555555555555555555555000000000000000000000000000000000000000000005d6d55dd6666666666666666666666666666666666d66d555555dd55555555555555555555555555550000000000005000000000000000000000000000000000005555555d666666666d6666666666666666666666556dd555555555555555555555555555555555500000000000000000000000000000000000000000000000000555555d566666665d6666666666666666666666d66ddd5dd5555555555555555555555555555500000000000000000050000000000000000000000000000000000dd55ddd6666d6d6666666666666666666d66dd665d5ddd55d55d5555555555555555555555000000000000000000000000000000000000000000000000000000055555555555dddddddddddddddddddd5d5d5dd5555555555555555555555555555555550000000000000000050000000000000000000000000000000000000000555555dd555dddddddddddddddddd555ddd555555555555555555555555555555555500000000500005000000000000000000000000000000000000000000000005d55555dd5ddddddddddddddddd555dd555555555555555555555555555555555550000000000000000000000000000000000000000000000000000000000005005d55555d5dddddd55d5ddd555d555555d55555555555555555555555555555000000000000000000000000000000000000000550050000000000000000000500055ddd555ddddd55dddddd5d5555555555555555555555555555555555550000000000000000000050000005500000500000000000000000000000000000000000555ddd5d55d55dddddddd555555555555555555555555555555555550000000000000000000000550050005000000000000000000000000000000000000500005000555555dd55ddddddd555555555555555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000050000000005555555555ddd5d55555555555555555555555555555500050000000000000000000000000000000000000000000000000000000000000000000000000000000000555555555555555555555555555555555555555000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000005555555555555555555555555555555550000000000000000000000000000000000000005000000000000000000000000000000000000000000000000000000000500555555555555555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005555555555000000000000000000000000000000000000000000000000000000000000"

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

sounds = {
    smash = 0,
    good = 1,
    bad = 2,
    throw = 3,
    add = 4,
    subtract = 5,
    snow = 6,
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
snow = {
    layers = {},
    period = 60,
    vy = 1,
    amplitude = 6,
    timer = 0,
}
function snow:init()
    for i=1, 3 do
        local layer = {}
        self.layers[i] = layer
        for j=1, 20 do
            local item = {
                x0 = flr(rnd(system.width)),
                y = flr(rnd(system.height)),
                t = flr(rnd(snow.period)),
            }
            item.x = item.x0
            
            layer[j] = item
        end
    end
end

function snow:update()
    local timer = (self.timer + 1) % snow.period
    self.timer = timer
    for i=1, #self.layers do
        local layer = self.layers[i]
        for j=1, #layer do
            local item = layer[j]
            item.x0 = item.x0 - i * map.speed
            while item.x0 < 0 do item.x0 = item.x + 128 end
            item.y = (item.y + snow.vy) % system.height
            item.x = item.x0 + snow.amplitude * sin(((item.t + timer) % snow.period) / snow.period)
        end
    end
end

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
                    sfx(sounds.throw)
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
            sfx(sounds.bad)
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
                sfx(sounds.good)
            else
                map:add_animation(sequences.ex, hit_target.x - 2, hit_target.y - 4)
                sfx(sounds.bad)
            end
        else
            -- collisions with walls
            local map_sprite = map:get_sprite(p.x, p.y)
            if map_sprite ~= nil and map_sprite ~= 0 and not fget(map_sprite, 0) then
                pool:remove(p)
                sfx(sounds.smash)
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
    { 30, function (self, progress)
        if progress == 0 then
            if self.show_delta > 0 then
                sfx(sounds.add)
            elseif self.show_delta < 0 then
                sfx(sounds.subtract)
            end
        end
        self.score = self.score + progress * (game.last_overall_score - self.score)
    end },
    { -1, nop },
    { 1, function(self) self.show_delta = nil end },
    { default_storyboard_period, create_positional_update(system.width - 64, 0, function (self) self.last_score = game.last_overall_score end) },
})

local final_messages = {
    { 0.9, "christmas cheer reigns supreme!" },
    { 0.8, "merry christmas to all!" },
    { 0.75, "that was a pretty good christmas" },
    { 0.7, "that was an ok christmas" },
    { 0.65, "a pretty mediocre christmas..." },
    { 0.6, "merry christmas?" },
    { 0.5, "better luck next year" },
    { 0, "there goes christmas :(" },
}

game = {
}

function game:reset()
    self.state = game_states.title
    self.title_drawn = false
end

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

    map.speed = map.default_speed

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
    if self.state == game_states.title then
        if z and not last_z then
            game:init()
        end
    elseif self.state == game_states.info then
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
                game:reset()
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

    if last_state == game_states.title and self.state ~= game_states.title then
        sfx(sounds.snow)
    elseif last_state ~= game_states.title and self.state == game_states.title then
        sfx(sounds.snow, -2)
    end

    marquee:update()
    meter:update()
end

function _init()
    snow:init()
    game:reset()
    for i=1, map.width do
        map:generate()
    end
end

function _update()
    snow:update()
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

function snow:draw()
    for i=1, #self.layers do
        local layer = self.layers[i]
        for j=1, #layer do
            local item = layer[j]
            rectfill(item.x, item.y, item.x, item.y, colors.light_gray)
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

local hex = {}
hex["0"] = 0
hex["1"] = 1
hex["2"] = 2
hex["3"] = 3
hex["4"] = 4
hex["5"] = 5
hex["6"] = 6
hex["7"] = 7
hex["8"] = 8
hex["9"] = 9
hex["a"] = 10
hex["b"] = 11
hex["c"] = 12
hex["d"] = 13
hex["e"] = 14
hex["f"] = 15

function draw_bitmap_string(s, x, y)
    local width = 16 * hex[sub(s, 1, 1)] + hex[sub(s, 2, 2)]
    local height = 16 * hex[sub(s, 3, 3)] + hex[sub(s, 4, 4)]
    for i=5, #s do
        local offset = i - 5
        pset(x + (offset % height), y + flr(offset / width), hex[sub(s, i, i)])
    end
end

function _draw()
    if game.state == game_states.title then
        if not game.title_drawn then
            cls()
            draw_bitmap_string(bitmap_title, 0, 0)
            print("press 'z' to continue >", 36, 120, colors.white)
            game.title_drawn = true
        end
    else
        cls()
        map:draw()
        player:draw()
        projectiles:draw()
        snow:draw()
        game:draw()
    
        if debug and debug_message ~= nil then
            print(debug_message, system.width - 4 * #debug_message, 0, colors.white)
        end
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
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
005000000000005550000000000050000000000000000000000055ddd66666666666666dd5550000000000550000000000000000000000000000000000000000
0000000000000500000000000000000000000000000000005d666666666d666666666d6666666dd5000000550000000000000000000000000000000000000500
000000000000000000000000000000000000000000005dd66666666666666666666666ddd55dddd66dd500000000000000000000000000000000000000000000
000000000000000000000000000000000000000005d6666666666d66666666666666666dddd5555555d6dd500000000050000000000000000000000000000000
0000000000000000000000000000000000000005d6666666666666666666666666666666666665555555dd6d5000000000000000000050000000000000000000
0000000000000000000000000000000000000566666666dd66666d666666666666666666666666d6dddd55d66d50000000000000000000000000000000005000
00000000000000000000000000000000000d6666666666dd66666d6666666666666666666666666666d555666666500000000000000000000000000000000000
000050000000000000000000000000000d6666666ddd6d666666d66666666666666666666666666655dd55666666665000000000000000000000000000000000
000000000000000000000000000000056666666d555566d56666d666666666666666666666666666d55ddd6dd666666d50000000000000000000000000000000
000000000000000000000000000000d666666d55555ddd666d65d66666666666666666666666666d6d5dd66dd5ddd66665005000000000000000000000000000
000000000000000000500000000056666dd6d5555555ddd66dd5666666666666666666666666666655555ddddd5555d66d550000000005000000000000000000
000000000000000000000000000d6666d5555555555556666dd66666666666666666666666666666d55555555d55555dd6d55000000000000000000000000000
00000000000000000000005505d6666d555555555555d66666d66666666666666666666d555d6666d5555555555555d65d6d5500000000000000000000000000
00000000000000000500000056666665555555555555d666655d666666666666666666d55555555dddd5555555555556ddd65555005000000000000000000000
0000000000000000000000056666d55555555555d5dd6666d55566666666666666666655555555555555555555555555ddddd56d505000000500000000000000
00000000000000000000005d666d5d55555555555ddd55d66555dd666666666666666d5555555555555555555d555555d5555d5dd50000000000000000000000
0000000000000000000005d666d55dd55555555556555d6ddd55dd666666666666666555555555555555555555d5555555ddd5d5655000000000000000000000
000000000000000000005d666d55665555555555ddddd6655dd6666666666666666d5555555555555555555555d65555d55666d5dddd00000050000000000000
00000000000000000005d666d5566d5555555555d5d666d556666666666666666655555555555555555555555dd6d555d5dd66dd5d6650000000000500000000
0000000000000000005dd66d5d66d555555d55d655d666dd666666666666666666d55555555555555555555555d65d5566d66dd65d5665000000000000000000
000000000000000005d5dd65dd66dddd55dd55d66dd6666d66666666666666666665555555555555555555555555555ddd6666d665dd6d500000000000000000
00000000000000005dddd66566d5dd5665dd55d666666666666666666666666666655555555555555555555555555555d66666666d5d66d50000000000000000
000000000000005556d6666666dd66666d6d55d6d666666666666666666dd66666d55555555555555555555555555ddd66d66d6666d666dd5000000000000000
0000000000000055d666d5666655d66dddd5556666666666666666666666666666d55555555555555555555555d677777666d56777f77776d000000000000000
000000000000005d666dd6666d55d66d5d6d5d6ddd66666d6666666666666666666d555555555555556666d55677feeef7765577e8888eff7d00000000000000
00000000000005d6666dd66d5dd5d6666666d666d666665566666666666666667777d5555555dd67777fff76d7e888888e76d67e8eee88887d50000000000000
0000000000005dd666666d55d6d5d66666666666d666655566d66666666666667e87655ddd67777eefe888f7d788ef7fe8f6d67887777e887655000000000000
0000000000055d66666dd5d5d66dd6666666666666666dd665dd6666666666667e8f7777777ee888888ee887677777ffe8f6567e8eeff7ef7ddd000000000000
000000000005d66666ddd5dd6666666666666666666666665d5d6666666666667f8effeee7f8888fe8e77e87677fe88888f65d77e8888ef76555505500050000
00000000005566666655dd6666666666666666666666666dd666666666666667fe888888e77fe8f7f8e77e8f77e88eeee8f6567f77ffe887d555550500000000
00000000005d66666d5dd66666666666666666667777666d666666777777766f8888eff77767e8f778e77e8f7f8ef777f8e776f8f7777f876555550000000000
0000000005566666666d66666666666666666667fee76666666677ffeee87667ff88f766dd57f8f778877f8e7e8e77fe888ef7f88eeee8e7d555555000000000
0000000055d66666566dd6666666666666666667e887666666677e888888f76667e8f7555dd7f8e77e8f7f8eff88e888e888f7fee8888ef75555555000000000
00000000556666666d5dd66666666666666666677f7766666667e8eff7e8f65556f8e7dd677778ef7e88e78887fe88ef7f77767777fff77d5555555500000000
0000000555666666666dd66666666666666666667777766666678877777f77d55678e7777f8ee888ff88e7ff777777766666d55dd66666555555555500500000
00000005556ddd6666d6666666666666666666677ffe77666667e88e8888e7755d7e8fffe88e88ee777777666d5dddd55555555555555ddd5555555550500000
0000005555d556666d556666666666666666667fe888f7666d67fe88eeee8e7d557f88888ef77777666dd555555555555555555555555566d555555550000000
000000555555d66666666666666666667777767e8ee8e7666d5d7777777f8e7d5567feeef776666d5555555555555555555555555555555d5555555555000000
000000555555666666d6666666666777fe88f77777788766dd567ef77ff88f7d555677776d5566d55555555555555555555555555555555d5555555555000000
000005555555d66666d666666667777f88e8e766667e8f7666d6f8888888f76555555555555dd6655555555555555555555555555555555d5d55555555500000
000005555555d66666666666677fe8e88f777766667f8e777776788eeef7765555555555d6d6ddd5555555555555555555555555555555555555555555500000
000055555d5677776666666667f88888e7677666667788fe887777777777665555555555d666555d555555555555555555555505555555555555555555500000
000055555d67fe8776677776677efe8e7766666677ff88888e7667766666666d6555555d6666dd55555555555555555555555500555505555555555555550000
00055555557f888f777feef766777f8e766666667e888eef7776666666666666666ddd55666666d5555555555555555555555500555055555555555555550000
00055555667fef8877e8888f7666778877777766f8ef77766d666666666666666666666666666655555555555555555555555500055555555555555555550000
00055dd67f7777e8ee8eff88776667e8f7fe876677776d555d66666666666666666d6666666666d5555555555555555555555555555555555555555555555000
0005677ff8e767f888e777e8f76677f88888e766666d555556666666666666666666666666666665555555555555550055505555555555555555555555555000
00567e88888f767e887767f8e7777e888ef77766666d555d5666666666666666666666666666666d555555555555055505505555555555555555555555000000
0567e88efe8e767f8876667e8ff7f88ef7776d66666d555d6666666666666666666666666666666dd55555555555555555005555555555555555555000000000
0d7e8e7777ff7667e8f7667e888f7f77766666666666d555ddd6666666666666666666666666665dd55555555555550550005555555555555555000000000000
06f8e76d56676667f8e777f888e7776666666666666665ddd55d66666666666666666666666666556d5555555555555555000005555555555555500000000000
07e8f755556666667e8ee7fef77766666666666666666566d55d6666666666666d6666666666665d6d5555555555555555000000555555555550000000000000
07e8f65555d677777e888f7777666666666666666666666666d66d66666666dd6d5d6666666666dd5d5555555555555555000055555555555000000000000000
07e8f75555d67e87f88ef76666666666666666d66666666666666d666666666d666d66666666666ddd5555555555555555000555555555055555000005555500
07f8e76555d67e877ef7766666666666666666666666666666666666666666665d6dddd6666666666d5555555555555550000555500555555550000055555500
067e8f765d67f8e777766666666666666666666666666666666666666666666665ddd55d666666666dd5dd555555555500000555555555505500000555555505
0d7f88f7777e88f766d66666666666666666666666666666666666666666666666dd005d666666666666dd555550000000000055005555005500000055555555
0dd7f88eee888f766656666666666666666666666666666666666666666666666666500056666666d66d55500000000000000000005550000000000055555550
055d7fe888ee77d566666666666666666666666666666666666666666666666666665000006666666666d0000000000000000005555055000000000055555550
0555d77777776d556666d6d55d66666666666666666666666666666666666666666d0005d66666666666d0000000000000000555555555050000005055555550
055555d666dd5555dd66d50000d6666666666666666666666666666666666666666000066666666ddd5dd0000000000000555555555555000000005555555550
05555555555d555555dd500000566666666666666666666666666666666666666d00005666dd5d5d6666d0000000000055555555555555000000005555555550
0d555d5555555555ddd0005000066666666666666666666666666666666666d50000000d5ddd6666666650005555555555555555555555500000005555555550
0d55555555000055dd5dd6600000d6666dddd6666666666666666d66d500000000000056666666666d5000055555555555555555555555500000005555555555
0dd5555550000055555d666000000555005dddddd666666666666d050000000000000005dd66666665500555d555555555555555555555550000005555555550
0d65555d0000000000005d600000000000505665566666666666dd0000000000000000000d6666665d5d665dd555555555555555555555500000005555555550
0dd555d550000000000005d0000000055d5566d555ddddddddddd650000000000000005d55666665ddd66d566555555555555555555555550000005555555550
0d6555555500000000000000000000ddd66056d55d5ddd66666666d00000000000005666ddd66656656666d66dd6d55555555555555555550000055555555550
0d6555555500000000000000000000d6d66d00d5dd55666666666d50005500005d66666656dd666d56666666666d555555555555555555555000055555555550
0d6d55555500000000000000000000005666000d6d5d6666666d00000066d6666666666d5665666d666666d666ddd55555555555555555555000055555555500
0d6655d5550000000000000000000000066d000066dd666666655005d666666666666665666d66666666666666d65655d5555555555555555550555555555500
05665dd555000000000000000000000005d5000056dd666666dd5d666666666666666666666666666666666666d6665555555555555555555550555d67655500
05665665500000000000000000000000000000000d5d6666665656666666666666666666666666666666666666666d55555555555555555555505d67ff765500
0066dd6d66500000000000000000000000000000055566d6d56dd666666666666666666666666666666666666666d55555555555555555555555577e88f65500
00666d6dd6500000000000000000000000000000055d6666d66566666666666666666666666666666ddd66666665555555555555555555555d6667e88e765500
00d7666d66d00000000000000000000000000000555d6666665666666666666666666666666666666566666666dd5555555555555555555677ff77ff8e755500
00566666666500000000000000000000000000055555ddd6666666666666666666666666666666dd6d6666666666555555555555555d6667fe8876778e755000
0056666d666600000000000000000000000005dd5d5555d6d666666666666666d6666666666665665d66d66d66665555555555555567777f888e76678e755000
0006666666666500000000000000055555d55dd55d55555d66666dd66666666666666666666666d5d66dd6dd6666d555555555d6677e88e7fe88f77f8e755000
000d6666666666d50000055555566d5555d55555555555d66666666666666666d6666666666666d5666dd5ddd666d55555556777f7e8e88777f88e7f8e755000
500566666666666d55555d66d55555555555555555555566666666666666666666666d66666666d666d55555d66dd555555d7fe88e8e77775d7fe88e8e750000
0005666666666dd5555555ddd65dddd555555555555dd56666666666666666666666666666dddd666dd555666d5666666d5d788888e76ddd50d77e888f650000
00056666666d55555555ddd55555ddd65dd55555d55d55d6666666666666666666666666d666dd665d6d5ddd5d677fff776d7fff88f75555500567f88f655005
0000d6666666d5505555dd66666666665d555555555555d6666666666666666666666666d666666d55555d65d77e88888f76d66788765ddd5005567e8f77d555
000056666666d5555555566666666666d655555555555d666666666666666666677776666d666d6d6d66777777e88eee88e7d5d7e8f777776555557e8eef6555
00000d666666d55555555666d6dd66d66d5556d555555d66666666666666666667fe766666666666677feee77e8e7777f88f6557f8e7fe8e755d677e888f6555
000055766666655555555d66d6dd66666d555dd555555555d6666666666666666788f766666777777f888887f88777fe888f6d77f88888ef75d77fe88ef76550
5500006666666d5555555d5d66d5666dd555555555555555dd67777f7666666667ff7766667ffe8877e88e77f8efe888ef77767e888eff77d5d7e88ef7765050
550000d7666666d5555555556ddd5d66dd55555555555555d67fee887766666d6777776666f8888e777e8f76f888eef777fe77f8eef776d555d7ee777d500000
550000566666665d55555555d6665566d655555555555555d67e8888f766666677ffef76667ef88f767e8766788e7777fe887677776d55555556776d50000000
5500055d666666d555555566666dd5d66dd55555555555555677f7e8f7666667f8888f7666677f887778e76d7f88eee888ef7dd6d55555555555d55500000000
555555556666666dd55555d6666666666ddd555555555d6dd66777f8e7666667feee8e76d6d567e887f8e75567f88888ef77d555555555555555555500000000
55555555d66666666d555556777777f7776655ddd666666d66666678e766666677778876665d667e8ee8f7555677fff776d55555555555555555555000000000
555555555666666666d5dd67fee88888ef776d66777ff77766666678876666666667e87665ddd567e888f65555d66666d5555555555555555555555000050000
555555555d6666666dd5d667f8888eee88e76667fe8888e77666667e8f76666d6667e8f77776d5d77e8e7655d555555555555555555555555555550000000000
5555555555666666666666667f8e7777f88f767f888ee8887766667e8f7666666667f8e7fef7d5d677777d555555555555555555555555555555550000000000
555555555556666666666666778e7dd67f8e77f88f7777e8e766667f8e766666777fe88888e7dddd666dd5555555555555555555555555555555500000000000
55555555555d666666666666678876dd678877e8e7777fe88766667f8e7777767e88888eff77d666d55dd5d55555555555555555555555555555000000000000
000005555550d6666666666667e876dd67e8f7e8eee8888ee776777788fee8777eeef777766666555ddd55555555555555555555555555555555000000000000
00000000000056666665d66667e8766d67e8f7e88eefff7777777eee88888e767777766dd5666d5d555555555555555555555555555555555550000000000000
50000000000005666666556667e8f7d667e8f7f8e77777fe8e77e888eeff77766666666666655555555555555555555555555555555555555500000000000000
50000050000000d6666665d667e8f7677f88777e88eee8888f777ff777776666666666666d555555555555555555555555555555555555555000000000000000
000055500000050d66d666d667f8f77fe88f7677e88888ef776677766666666666666666d55555d5555555555555555555555555555555555000000000000000
0000055000000505666666667fe8888888f7666777fff777766666666666666666666665555ddd55555555555555555555555555555555550000000000000000
000000000000000056d666667e888eeef776666667766766666666666666666666666d555555555d555555555555555555555555555555500005500000000000
000000000000000005d5d666777777777766666666666666666666666666666d66666dddd5555555555555555555555555555555555555000000000000000000
0000000000000000005d5d66d6666666666666666666666666666666666666d6666666d5dd6d5555555555555555555555555555555550005000000000000000
00000000000000000005d566dd666666666666d666666666666666666666d66666666d55556d5555555555555555555555555555555500005500000000000000
000000000000000000005dddd5d666666666666666666666666666666666666666666d55d6655555555555555555555555555555555000000000000000000000
000000000000000000000566d55d6d666666666666666666676666666666666666ddd555d555d555555555555555555555555555550000000000000000000000
00000000000000000000005d6d55dd6666666666666666666666666666666666d66d555555dd5555555555555555555555555555000000000000500000000000
0000000000000000000000005555555d666666666d6666666666666666666666556dd55555555555555555555555555555555550000000000000000000000000
0000000000000000000000000555555d566666665d6666666666666666666666d66ddd5dd5555555555555555555555555555500000000000000000050000000
000000000000000000000000000dd55ddd6666d6d6666666666666666666d66dd665d5ddd55d55d5555555555555555555555000000000000000000000000000
000000000000000000000000000055555555555dddddddddddddddddddd5d5d5dd55555555555555555555555555555555500000000000000000500000000000
00000000000000000000000000000555555dd555dddddddddddddddddd555ddd5555555555555555555555555555555555000000005000050000000000000000
00000000000000000000000000000005d55555dd5ddddddddddddddddd555dd55555555555555555555555555555555555000000000000000000000000000000
0000000000000000000000000000005005d55555d5dddddd55d5ddd555d555555d55555555555555555555555555555000000000000000000000000000000000
0000005500500000000000000000005000557775777d7775577dd775d55557557775575555557775577555555775577077007770777077007570777055007005
000000000000000000000000000000000005757d75757d557ddd7ddd555575555575755555555755757555557550707070700700070070707570750005000700
0000000000000000000000000000005000057775775577d5777d777d555555555755555555555755757555557000707070700700070070707070770000000070
000000000000000000000000000000050000700075757555557ddd7d555555557555555555555755757555007500707070700700070070707070700000000700
00000000000000000000000000000000000070007070777577557755555555557775555555555755775000000770770070700700777070700770777000007000
00000000000000000000000000000000000000000000000555555555555555555555555555555555000000000000000000000000000000000000000500000000
00000000000000000000000000000000000000000000000005005555555555555555555555000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000005555555555000000000000000000000000000000000000000000000000000000000000

__gff__
0000000001020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010f00000c63300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010500001f33021330233300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010500001733015330133300030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000000000000000000000000000000000000000000
010200002463000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010300000c7410c7410c7410c7410e7410e7410e7410e741107411074111741137411574117741187410070100701007010070100701007010070100701007010070100700007000070000700007000070000700
010300001874118741187411874117741177411774117741157411374111741107410e7410c7410c7410070100701007010070100701007010070100701007010070100700007000070000700007000070000700
011300200e61010610176101161011610156100e6100c61015610106101161017610156100e6100c61010610116100e61017610176101061011610176100e6101561010610116101761010610156100e61011610
