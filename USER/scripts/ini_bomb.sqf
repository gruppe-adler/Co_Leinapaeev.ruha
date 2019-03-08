// by ALIAS
// 
// Tutorial: https://www.youtube.com/user/aliascartoons

/*
============== JDAM BOMB Parameters ==============

null = [start_marker, waypoint_marker, explosion_blast_diameter, crater, damage] execVM "AL_bomb\bomber_bomb.sqf";

start_marker		- marker name from where the bombs will start to drop
waypoint_marker		- the plane (bomber) will fly in the direction detemined by this marker and continue flying for 3000 meters where it will be deleted
explosion_diameter	- number, it sets the size of explosion and blast area
crater				- boolean, enable/disable crater creation
damage				- boolean, enable/disbale destruction, when you want to use the visual effect without damaging all objects in blast area

_custom_jdam_bomb	- string, classname of the bomb you want to work as JDAM

The script can be run via trigger, script, action menu or radio menu. 
As it is the script should be called in global, this should work with most frameworks
*/

// =============== Spawn a plane to drop the bomb
null = ["bomb_1","bomb_2", 100, false,false] execVM "AL_bomb\bomber_bomb.sqf";

// =============== Create an explosion at given position via an object
/*
null = [object_name,blast_diameter, crater, damage] execVM "AL_bomb\alias_bomb_ini.sqf";
bombard - is the object where you want to spawn the explosion
blast_diameter - same as explosion_diameter above
*/
null = [bombard,50, false,false] execVM "AL_bomb\alias_bomb_ini.sqf";

// ======== Example for player dropped JDAM designate the type of bomb by giving the className below in this example i used "Bomb_04_F" found on vanilla Wipeout plane
// you can define whatever bomb you want to work as JDAM, edit value of _custom_jdam_bomb variable
this addEventHandler ["Fired",{private ["_bomb_type","_custom_jdam_bomb","_plane_player","_explosion_diameter","_crater_create","_inflict_damage"];  
_plane_player = _this select 0; _bomb_type = _this select 6; _custom_jdam_bomb = "Bomb_04_F"; _explosion_diameter=50; _crater_create=true; _inflict_damage=true;  
[[_bomb_type,_custom_jdam_bomb,_plane_player,_explosion_diameter,_crater_create,_inflict_damage],"AL_bomb\al_bomb_player.sqf"] remoteExec ["execVM"]}];