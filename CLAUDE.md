# CLAUDE.md

Unturned (Steam app 304930) settings for streaming/PvP on Linux. The repo holds copies of the game's
settings files; `install.sh` copies them into the live game locations. See README.md for the file → location table.

## Live locations (this PC)
- Steam: `~/.local/share/Steam`, Steam user id `1690614397`
- Cloud files: `~/.local/share/Steam/userdata/1690614397/304930/remote/` (`*.dat`, `Settings/Graphics.json`)
- Game dir: `~/.local/share/Steam/steamapps/common/Unturned/` (`Preferences.json`, maps in `Bundles/Assets/Levels/`)
- Unity prefs: `~/.config/unity3d/Smartly Dressed Games/Unturned/prefs`

## Workflow
- Settings are usually changed **in game**, then copied live → repo. Diff live vs repo first (`diff`, `cmp`).
- `unity/prefs`: only copy real setting changes; skip session/machine keys the game adds
  (`CloudStorageHash`, `unity.player_session*`).
- Before running `install.sh` or editing live files, Unturned **and Steam must be fully exited**
  (closing the Steam window only sends it to the tray; `steam -shutdown` quits it). Otherwise Steam Cloud
  may overwrite the files. If Steam shows a cloud conflict on launch, choose **local** files.
- Check processes with `pgrep -x steam` / `pgrep -x Unturned.x86_64`. `pgrep -f` matches its own shell command.
- Repo is **public** on GitHub (`isciuciustin/unturned_settings`). Work on a branch, not `main`, unless asked.

## Preferences.json (game dir)
- `Graphics.Override_Vertical_Field_Of_View`: `-1` means use the in-game FOV slider (current; matches
  LiamDoesGame's 2024 config). Any other value forces that vertical FOV in degrees and ignores the slider.
  90° vertical is about 121° horizontal at 16:9 and looks stretched.
- `Viewmodel`: hip/aim FOV 50, offsets -0.2 / -0.1 / 0.1 (same as LiamDoesGame's).
- The in-game slider value is stored in binary `Options.dat`; its byte offset has not been decoded.

## Graphics.json
Copied from LiamDoesGame's settings (entered in game, 2026-10-25). 1920x1080, 144 fps cap.
`ScopeQuality2` is 0; check scopes still render.

## Characters.dat (character save, binary)
- `steam_cloud/Characters.dat` is a reference copy. `install.sh` does **not** install it, because it would
  overwrite characters and items on the target PC.
- Each character record ends with: face, hair, beard (1 byte each), **skin RGB**, hair RGB, marker RGB,
  beard RGB (3 bytes each), handedness byte, then the name as a length-prefixed string (`0x0C` + `justinflexer`).
  To find the skin color, search for the name and read 14 bytes before it. Offsets move when the inventory changes.
- Back up before editing (`Characters.dat.bak-*` sits next to the live file). Verify the expected bytes before patching.
- Slot 0 skin is `#3ddc84` (61, 220, 132), a bright green. The old dark green `#2b3a26` got the player kicked
  from Panda Hut #8. Hair and beard are still dark green (32, 58, 38).

## Skin-color kick
- Unturned (3.24.4.0+) kicks players whose skin is too close to a map's terrain color when the server has
  `Enable_Terrain_Color_Kick`. A skin color is kicked only if it is within **all** of the limits: hue ≤ 0.06,
  saturation ≤ 0.2, value ≤ 0.1. Terrain colors are in `Bundles/Assets/Levels/<Map>.asset` under `TerrainColors`:
  PEI `#39713a`, Washington `#38713a`, Russia `#556633`, `#aa7227`, `#656547`.
- `#2b3a26` passes that check, so Panda Hut's kick is probably its own plugin or rule (exact rule unknown).
  Prefer bright greens far from grass. `#3ddc84` is at least 4.2× past every limit.
