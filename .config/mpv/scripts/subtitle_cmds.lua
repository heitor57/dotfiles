--- ___Usage___:
--- ab-loop-sub [autopause]: Set ab-loop to current subtitle. Specify 'autopause' arg to pause before every loop
--- copy-subtitle:           Copy current subtitle to clipboard. Works on mac 10.13 and windows 10
--- replay-subtitle:         Replay current or previous subtitle.
--- step-subtitle:           End current subtitle or start next subtitle.



local char_to_hex = function(c)
  return string.format("%%%02X", string.byte(c))
end

local function urlencode(url)
  if url == nil then
    return
  end
  url = url:gsub("\n", "\r\n")
  url = string.gsub(url, "([^%w _%%%-%.~])", char_to_hex)
  url = url:gsub(" ", "+")
  return url
end

local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

local urldecode = function(url)
  if url == nil then
    return
  end
  url = url:gsub("+", " ")
  url = url:gsub("%%(%x%x)", hex_to_char)
  return url
end


_G.abloopavoidjankpause = false

--- platform detection taken from: github.com/rossy/mpv-repl/blob/master/repl.lua
function detect_platform()
    local o = {}
    if mp.get_property_native('options/vo-mmcss-profile', o) ~= o then
        return 'windows'
    elseif mp.get_property_native('options/cocoa-force-dedicated-gpu', o) ~= o then
        return 'macos'
    end
    return 'linux'
end

_G.platform = detect_platform()
if _G.platform == 'windows' then
    _G.utils = require 'mp.utils'
end
--- end platform detection code

function round(num, numdecimalplaces)
  local mult = 10^(numdecimalplaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function pause_on_sub_loop(prop, value)
    if _G.abloopavoidjankpause == true then
        _G.abloopavoidjankpause = false
        return
    end
    if value and value ~= '' then
        local startloop = round(mp.get_property("ab-loop-a"), 1)
        local substart = round(mp.get_property("sub-start") + mp.get_property("sub-delay"), 1)
        if substart and startloop and substart == startloop then
            mp.set_property("pause", "yes")
        end
    end
end

function ab_loop_sub(autopause)
    local existingloop = mp.get_property_number("ab-loop-b")
    if existingloop then
        mp.osd_message("Clear A-B Loop", 0.5)

        mp.set_property("ab-loop-a", "no")
        mp.set_property("ab-loop-b", "no")
        
        mp.unobserve_property(pause_on_sub_loop)
        mp.set_property("pause", "no")
    else        
        local substart = mp.get_property("sub-start")
        local subend = mp.get_property("sub-end")    

        if substart and subend then
            mp.osd_message("A-B Loop Subtitle", 0.5)

            local suboffset = mp.get_property("sub-delay")
            mp.set_property_number("ab-loop-a", substart  + suboffset)
            mp.set_property_number("ab-loop-b", subend + suboffset + 0.075)
            
            _G.abloopavoidjankpause = true
            if autopause then mp.observe_property("sub-text", "native", pause_on_sub_loop) end
        else
            mp.osd_message("No subtitles present", 0.5)
        end
    end
    
end

function escape(s)
  return (s:gsub('\'', '\'\\\'\''))
end

function copy_subtitle()
    local subtext = mp.get_property("sub-text")
    if subtext and subtext ~= '' then
        if _G.platform == 'macos' then
            os.execute("export LANG=en_US.UTF-8; echo '" .. escape(subtext) .. "' | pbcopy")
        elseif _G.platform == 'windows' then
            --windows copy taken from hsyong, github.com/mpv-player/mpv/issues/4695
            local escapedtext = string.gsub(mp.get_property("sub-text"), "'", "")
            local res = _G.utils.subprocess({ args = {
                'powershell', '-NoProfile', '-Command', string.format([[& {
                    Trap {
                        Write-Error -ErrorRecord $_
                        Exit 1
                    }
                    Add-Type -AssemblyName PresentationCore
                    [System.Windows.Clipboard]::SetText('%s')
                }]], escapedtext)
            } })
        elseif _G.platform == 'linux' then
            -- os.execute("echo '" .. escape(subtext) .. "' | xclip -selection clipboard -i")
            os.execute("echo '" .. escape(subtext) .. "' | tr '\n' ' ' | wl-copy")
        end
        mp.osd_message(subtext, 0.5)
    else
        mp.osd_message("No subtitles present", 0.5)
    end    
end

function replay_subtitle()
    local substart = mp.get_property("sub-start")
    local timestamp
    
    if substart then
        local suboffset = mp.get_property("sub-delay")
        mp.set_property_number("time-pos", substart + suboffset)
    else
        mp.commandv("sub-seek", -1)
    end
end

function step_subtitle()
    local subend = mp.get_property("sub-end")
    local timestamp
    
    if subend then
        local suboffset = mp.get_property("sub-delay")
        mp.set_property_number("time-pos", subend + suboffset)
    else
        mp.commandv("sub-seek", 1)
    end
end


function sub_file_base(prop, subtext)
    local subtext = mp.get_property("sub-text")
    if subtext and subtext ~= '' then
        --os.execute("xdotool key space")
        os.execute("echo '" .. escape(subtext) .. "' | tr '\n' ' ' | wl-copy")
        os.execute("echo '" .. escape(subtext) .. "' | tr '\n' ' '  >> /home/heitor/Documents/english_phrases.txt")
        os.execute("echo ''  >> /home/heitor/Documents/english_phrases.txt")
        os.execute("gtk-launch $(xdg-settings get default-web-browser) 'https://translate.google.com/?sl=en&tl=pt&text='" .. escape(urlencode(subtext:gsub("[\n\r]"," "))) .. "'&op=translate'")
        mp.set_property_native("pause", true)
        --os.execute("xdotool keydown alt key Tab")
        --os.execute("sleep 4")
        --os.execute("xdotool keydown alt key Tab")
    end
end

function sub_file(prop, subtext)
    sub_file_base(prop,subtext)
end

function sub_file_only(prop, subtext)
    local subtext = mp.get_property("sub-text")
    if subtext and subtext ~= '' then
        os.execute("echo '" .. escape(subtext) .. "' | tr '\n' ' ' | wl-copy")
        os.execute("echo '" .. escape(subtext) .. "' | tr '\n' ' '  >> /home/heitor/Documents/english_phrases.txt")
        os.execute("echo ''  >> /home/heitor/Documents/english_phrases.txt")
    end
end

mp.add_key_binding(nil, "ab-loop-sub", ab_loop_sub)
mp.add_key_binding(nil, "copy-subtitle", copy_subtitle)
mp.add_key_binding(nil, "replay-subtitle", replay_subtitle)
mp.add_key_binding(nil, "step-subtitle", step_subtitle)
mp.add_key_binding(nil, "sub-file", sub_file)
mp.add_key_binding(nil, "sub-file-only", sub_file_only)
