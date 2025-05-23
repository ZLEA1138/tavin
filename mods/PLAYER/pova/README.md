# POVA

Pova gives mod makers a set of easy to use functions that safely apply overrides for player speed, jump height and gravity effects.

## Settings

'pova_loop' setting is 1.0 by default and will calculate and set overrides once a second for each player, set to 0.5 for every half a second or 0 to disable.

## Functions

pova.add_override(player_name, override_name, override_table)

- Adds a named override which can be used to add or subtract from speed, jump and gravity effects set in the override_table.  Custom override names can also be used for specific
tasks:

- "default" sets default values for each of the settings to which overrides are added.
- "min" provides a minimum level for each of the settings.
- "max" provides a maximum level for each of the settings.
- "force" overrides all and forces a value for each setting (e.g setting speed to 0 when sleeping in beds)


pova.get_override(player_name, override_name)

- Returns the table containing {speed, jump, gravity} for an added item.


pova.del_override(player_name, override_name)

- Removes the override settings for the item named.


pova.do_override(player)

- Calculates and sets new overrides instantly, this can be used when the 'pova_loop' setting is false.


## Changelog

### 0.1

 - Initial Upload

### 0.2

 - Added pova.do_override(player) to instantly set overrides on list.
 - Added 'pova_loop' setting in minetest.conf to disable override calc loop

### 0.3

 - Added custom override names for special functions "default", "min", "max", "force"
 - Tweaked test axe to use new settings.

### 0.4

 - 'pova_loop' now contains loop timer in seconds, 0 to disable
 - Added def.priority setting to add_override to stop unimportant changes
 - tweak and optimize code

### 0.5

 - Remove priority feature as it's never used.
 - Add nil checks.
 - Update readme.md
