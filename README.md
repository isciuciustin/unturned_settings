# unturned_settings

My Unturned settings for streaming, copied from my laptop (Linux/Steam).

| File | Goes to |
|---|---|
| `steam_cloud/Options.dat`, `Controls.dat`, `Filters.dat` | `<Steam>/userdata/<id>/304930/remote/` |
| `steam_cloud/Characters.dat` (reference copy, not installed by `install.sh`) | `<Steam>/userdata/<id>/304930/remote/` |
| `steam_cloud/Settings/Graphics.json` | `<Steam>/userdata/<id>/304930/remote/Settings/` |
| `game_dir/Preferences.json` | `<Steam>/steamapps/common/Unturned/` |
| `unity/prefs` | `~/.config/unity3d/Smartly Dressed Games/Unturned/prefs` (Linux; on Windows this lives in the registry under `HKCU\Software\Smartly Dressed Games\Unturned`) |

## Linux
Close Unturned, then run `./install.sh`.

## Windows
Copy the files manually: Steam folder is usually `C:\Program Files (x86)\Steam`.
Graphics.json (resolution, frame cap, quality) is the main file — edit `Resolution` for the stream PC's monitor.
Disable Steam Cloud for Unturned first or it may overwrite the files.
