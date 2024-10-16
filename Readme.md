# Dmitry 🌊 NixOS, Home Manager and Nix-on-Droid configurations.

## Please, support tabs in Nix!

[Discussion](https://github.com/NixOS/nix/pull/2911) and [Open issue](https://github.com/NixOS/nix/issues/7834).

## Screenshots.

Newest first.

<details>
<summary>Screenshot 1 + Android</summary>
<img src="https://i.imgur.com/qMolcsw.png" />
<img width=400px src="https://i.imgur.com/i67Rewo.png" />
<img width=400px src="https://i.imgur.com/CaVDQn8.png" />
<br><a href="https://i.imgur.com/OpZzgJZ.png">Wallpaper link</a>
</details>

<details>
<summary>Screenshot 2 + Android</summary>
<img src="https://i.imgur.com/00BTwv7.png" />
<img width=400px src="https://i.imgur.com/51M56xK.png" />
<img width=400px src="https://i.imgur.com/TbW3MGS.png" />
<br><a href="https://i.imgur.com/Q8ZTZCH.png">Wallpaper link</a>
</details>

<details>
<summary>Screenshot 3</summary>
<img src="https://i.imgur.com/LbxpvMt.jpeg" />
<a href="https://i.imgur.com/GA96791.jpeg">Wallpaper link</a>
</details>

<details>
<summary>Screenshot 4</summary>
<img src="https://i.imgur.com/67nW8XT.jpeg" />
<a href="https://i.imgur.com/H943DFl.jpeg">Wallpaper link</a>
</details>

[My current wallpaper](config/Wallpaper.nix#L4)

Color theming based on wallpaper thanks to [Stylix](https://github.com/danth/stylix).

## Discovering my configuration.

Even tho I've tried to document everything I can in a dum-dum way, I still highly recommend you to learn the [very basics of Nix language](https://nixos.org/guides/nix-pills/). Start from the [Flake](flake.nix) file and follow the comments. If you have any questions, get in touch using [Telegram](https://t.me/voronind_com) or [Email](mailto:hi@voronind.com).

Please tell me if you find any undocumented parts.

## Configuration highlights.

* [Keyd](module/Keyd.nix) allows you to have QMK-like keyboard remaps. Killer-feature is the ability to have remaps per-application. I have pretty common remaps like CapsLock to Ctrl/Esc combo, Right Shift to Backspace, Backspace to Delete and overlays for System/Windows/Media/Application controls as well as Macros.
* NixOS Containers (nspawn). Containers are great. I LOVE containers! Containers! Containers! Containers! Containers! Containers! Containers! Containers! Containers! Containers! Containers! Containers! [Here](host/x86_64-linux/home/Container.nix) is how I add containers to the host, [here](container/default.nix) is the global configuration and [here](container) are all the containers.
* NixOnDroid can be used to set up your environment inside the Termux app on Android. It also gives you access to all the Nixpkgs binaries for Arm. Configuration can be found [here](home/Android.nix), but you also need to add the definition to the root `flake.nix (nixOnDroidConfigurations.default)`. [Here](https://github.com/nix-community/nix-on-droid) are the docs.
* [Stylix](config/Stylix.nix) can be used to change colors for the whole system based on current wallpaper. Example usages: [Sway](home/config/sway/module/Style.nix), [fuzzel](home/config/fuzzel/default.nix) and [Tmux](home/config/tmux/module/Status.nix).
* [Signed auto-updates](module/AutoUpdateSigned.nix). Updates are pulled every hour and require the last commit to be signed with my signature.

## Keyboard layouts.

Yellow are modifier keys, they enable layers when held. Green ones are just modified keys.

<details>
<summary>Default</summary>
<img src="https://i.imgur.com/MBb23eB.png" />
</details>

<details>
<summary>Alternative Keys</summary>
<img src="https://i.imgur.com/X9CGhLb.png" />
</details>

<details>
<summary>Sway keys</summary>
<img src="https://i.imgur.com/hiGZ86w.png" /><br>
</details>

<details>
<summary>Per-application controls</summary>
Firefox:<br>
<img src="https://i.imgur.com/GI0apoV.png" /><br>
Jetbrains:<br>
<img src="https://i.imgur.com/OFNlHnW.png" /><br>
Nautilus:<br>
<img src="https://i.imgur.com/9W1GmLn.png" /><br>
Tmux:<br>
<img src="https://i.imgur.com/GhmwyCO.png" />
</details>

<details>
<summary>Extra numbers</summary>
<img src="https://i.imgur.com/89ERKd9.png" />
</details>

<details>
<summary>Media Controls</summary>
<img src="https://i.imgur.com/HvdSdRP.png" />
</details>

<details>
<summary>System controls</summary>
<img src="https://i.imgur.com/rGC2HXf.png" />
</details>

[Link](http://www.keyboard-layout-editor.com) / [Source](https://github.com/ijprest/keyboard-layout-editor) of the tool I used to draw the images.
