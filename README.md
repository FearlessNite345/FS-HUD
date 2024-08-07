# FearlessStudios-HUD

![Github All Releases](https://img.shields.io/github/downloads/FearlessNite345/FS-hud/total.svg?style=for-the-badge)
![GitHub Downloads (all assets, latest release)](https://img.shields.io/github/downloads/fearlessnite345/fs-hud/latest/total?style=for-the-badge)

Hey there! Welcome to the FearlessStudios-FiveMTemplate. This is your go-to setup for crafting Lua resources tailored for FiveM.

## Postal Setup

Setting up the postal system is easy:

1. **Grab a Postal File**:
   - Check out the `postals` folder for all available postal JSON files.

2. **Customize (Optional)**:
   - Want your own postal setup? No problem!
   - Drop your custom postal JSON file into the `config` folder.

Just make sure whatever file you're using is named `"postals.json"`. With that, you're all set to go!

## Exports

#### Client

##### `getAOP()`

```lua
exports['FearlessStudios-HUD']:getAOP() -- returns current locally stored AOP (should be the same as server)
```

##### `showHud()`

```lua
exports['FearlessStudios-HUD']:showHud()
```

##### `hideHud()`

```lua
exports['FearlessStudios-HUD']:hideHud()
```

##### `isHudHidden()`

```lua
exports['FearlessStudios-HUD']:isHudHidden() -- return true or false if hud is hidden
```

#### Server

##### `getAOP()`

```lua
exports['FearlessStudios-HUD']:getAOP() -- returns current server stored AOP (should be the same as client)
```

## Contributing

Your contributions are invaluable! If you encounter a bug or have a enhancement / optimization in mind, please don't hesitate to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE), providing you with the freedom to integrate it seamlessly into your own projects.

Happy coding!
