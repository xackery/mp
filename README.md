# Moulin Perdu

A horror game designed for the [Haunted PS1 Summer of Screams Game Jam](https://itch.io/jam/haunted-ps1-summer-spooks)

Voting process was [held on twitter](https://twitter.com/HauntedPs1)

## Tools

* Godot 3.2.2 
* Blender 2.83
* TrenchBroom 2020.1

## Environment Setup

1. Place Godot binary in the /src folder
2. Place TrenchBroom folder in the /tools folder
3. Run Godot and add the src folder as a project. Alternatively, you can drag the `project.godot` file on to the Godot binary
4. In the Godot project structure, double click `res://addons/qodot/game_definitions/trenchbroom/qodot_trenchbroom_config_folder.tres`
5. On the right bar, set the `Trenchbroom Games Folder` to `<TrenchBroom Dir>/game`
6. Click on `Export File`
7. Run TrenchBroom, click on `New Map`, then `Open preferences`, then `mp` on the left bar, and navigate to the `/src` folder
8. Click `OK`

## Creating new maps

Create a new map under game `mp` with map format `quake2`.  Under the Face tab on the top right, you can open the `Texture Collections` drawer in the bottom and add a texture category.  Floor will be the most useful, as it uses a toned down PS1 shader for high angle viewing (ie. Floor from an FPS perspective)


## Attributions

* [Texturer](http://texturer.com/)
* [CC0 Textures](https://cc0textures.com/)
* [TextureHaven](https://texturehaven.com/)
* [HDRI Haven](https://hdrihaven.com/)
* [3D Textures](https://3dtextures.me/)
* [Kenney](https://www.kenney.nl/)

## Credits

| Person    | Roles     |
|--------------------|-----------------------------|
| Loliponi           | Composer                    |
| Cursed Audio LLC   | Sound design                |
| Ra                 | Scriptwriting               |
| Taiki Sensei       | Scriptwriting, Voice acting |
| Ali                | Programming, Art            |
| Xackery            | Programming, Art            |
| Fireniner          | Art                         |
| Ian                | Art                         |
| Sayuri World       | Voice acting                |