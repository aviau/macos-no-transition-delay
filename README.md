<h2>macOS, Remove transition delay on Desktop switch</h2>

This tutorial describes how to remove the transition delay when switching
desktops via keyboard shortcuts in macOS.

As someone who used Arch Linux and i3 for a very long time,
I find transitions in macOS quite irritating. Worst of all are the
transition delays that occur when switching desktops in Mission Control.
Apple has yet to provide us with a way to remove them. Until it does,
this is currently the only solution I have found that disables them.

We will need <a href="https://www.hammerspoon.org/">Hammerspoon</a>
and the <a href="https://github.com/asmagill/hs._asm.undocumented.spaces">Spaces</a>
API.

<h3>Steps</h3>

1. Install <a href="https://github.com/Hammerspoon/hammerspoon#how-do-i-install-it">Hammerspoon</a>. Either download the latest release from <a href="https://github.com/Hammerspoon/hammerspoon/releases/tag/0.9.93">here</a> or install via `brew`

    ```bash
    brew install hammerspoon --cask
    ```

2. Install the <a href="https://github.com/asmagill/hs._asm.undocumented.spaces#installation">Spaces</a> API. Once again, either download the latest <a href="https://github.com/asmagill/hs._asm.undocumented.spaces/releases">release</a> and extract to `~/.hammerspoon` or build from source:

    ```bash
    git clone https://github.com/asmagill/hs._asm.undocumented.spaces spaces
    cd spaces
    [HS_APPLICATION=/Applications] [PREFIX=~/.hammerspoon] make install
    ```

3. Copy the contents of the `init.lua` file from this repo into `~/.hammerspoon/init.lua`. Change the master keys at the top of the file accordingly. I prefer to use "option" as a master key and "shift" + "option" to move a window from one desktop to another. (If someone can write a better lua config, I would be delighted if they could share).

    ```lua
    opt = {"option"}
    shiftopt = {"shift", "option"}
    ```

4. Start the Hammerspoon app. If you have already started it, click on the Hammerspoon icon on the taskbar and hit `Reload Config`.

5. That's it! You can now switch desktops by holding "option" (or whatever key you set it to) and clicking on the Desktop number (1 through 0).

6. <b>WARNING</b>. Make sure you have disabled all Mission Control Desktop shortcuts from `System Preferences / Keyboard / Shortcuts / Mission Control / Switch to Desktop X` or they will take priority.

7. <b>WARNING 2</b>. Any apps that like to switch Desktops by themselves (such as apps you assign to a particular Desktop) might mess the desktop up by not hiding certain windows. To recover simply switch to the active space back and forth once or twice.

8. <b>WARNING 3</b>. Switching to the current space may cause a black screen on newer systems. This can be fixed by adding

   ```lua
   if not resetDock and fromID == spaceID then
        return
    end
   ```
   immediately after line 212 on the file `.hammerspoon/hs/_asm/undocumented/spaces`. This will simply check if the active Desktop is the one you are trying to switch to and exit if so. Also see <a href="https://github.com/asmagill/hs._asm.undocumented.spaces/pull/21/commits/43407cd5f6e8a91ffa16d2df712dbcbe16830b25">this</a>.
