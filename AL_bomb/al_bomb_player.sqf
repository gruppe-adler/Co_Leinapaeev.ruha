// by ALIAS

fnc_brate = {
	private ["_vit_z","_vit_x","_vit_y","_buc_nap","_loc_bomb","_explosion_diameter_t"];
	_loc_bomb = _this select 0;
	_explosion_diameter_t = _this select 1;
	_vit_z = floor (60+random 300);
	_vit_x = ([1,-1] call BIS_fnc_selectRandom)* floor (50+random 50);
	_vit_y = ([1,-1] call BIS_fnc_selectRandom)* floor (50+random 50);
	_buc_nap = createVehicle ["Land_Battery_F", getPosATL _loc_bomb, [], floor (_explosion_diameter_t/3), "CAN_COLLIDE"];
	[[_buc_nap],"AL_bomb\alias_fum_bomb.sqf"] remoteExec ["execVM"];
	_buc_nap setVelocity [_vit_x,_vit_y,_vit_z];
	[_buc_nap] spawn {_de_delete = _this select 0; sleep 1+random 2; deleteVehicle _de_delete;};
};

fnc_schije = {
	private ["_vit_z","_vit_x","_vit_y","_buc_nap","_loc_bomb","_explosion_diameter_t"];
	_loc_bomb = _this select 0;
	_explosion_diameter_t = _this select 1;
	_vit_z = 30+random 70;
	_vit_x = ([1,-1] call BIS_fnc_selectRandom)* floor (10+random 40);
	_vit_y = ([1,-1] call BIS_fnc_selectRandom)* floor (10+random 40);
	_buc_nap = createVehicle ["Land_Battery_F", getPosATL _loc_bomb, [], floor (_explosion_diameter_t/3), "CAN_COLLIDE"];
	[[_buc_nap],"AL_bomb\alias_buc_bomb.sqf"] remoteExec ["execVM"];
	_buc_nap setVelocity [_vit_x,_vit_y,_vit_z];
	[_buc_nap] spawn {_de_delete = _this select 0; sleep 5+random 10; deleteVehicle _de_delete};
};

if (!isServer) exitWith {};

private ["_plane_player","_bomb_type","_poz_blow","_custom_jdam_bomb","_explosion_diameter","_al_crater","_al_destruction"];

_bomb_type			= _this select 0;
_custom_jdam_bomb	= _this select 1;
_plane_player		= _this select 2;
_explosion_diameter	= _this select 3;
_al_crater			= _this select 4;
_al_destruction		= _this select 5;

if (typeOf _bomb_type != _custom_jdam_bomb) exitWith {};
waitUntil {(getposATL _bomb_type select 2)<15};
_poz_blow = getPos _bomb_type;
_bomb_obj_b = "Land_HelipadEmpty_F" createVehicle [_poz_blow select 0,_poz_blow select 1,0];
deletevehicle _bomb_type;

if (_al_destruction) then 
{
	[_bomb_obj_b,_explosion_diameter] spawn 
	{
		_poz_destr				= _this select 0;
		_explosion_diameter_t	= _this select 1;
		_nearobj = position _poz_destr nearObjects _explosion_diameter_t;
		_veget = nearestTerrainObjects [position _poz_destr, ["TREE","SMALL TREE","BUSH"], 1.5*_explosion_diameter_t];
		_build = nearestObjects [position _poz_destr,["building"],1.5*_explosion_diameter_t];
		_misce = nearestObjects [position _poz_destr,["man","car","tank","plane","helicopter"],1.5*_explosion_diameter_t];	
		{if !(_x isKindOf "Land_HelipadEmpty_F") then {_x setVelocity [0,0,30+random 30]; _x setdamage 1};sleep 0.01} foreach _misce;
		{if !(_x isKindOf "Land_HelipadEmpty_F") then {_x setDamage [1,false]; sleep 0.01}} foreach _build;		
		{_x setDamage 1; sleep 0.01} foreach _veget;
	};
};
[[_bomb_obj_b, _explosion_diameter],"AL_bomb\alias_bomb_effect_player.sqf"] remoteExec ["execVM"];
[_bomb_obj_b,_explosion_diameter] spawn {_loc_bomb = _this select 0; _explosion_diameter_t = _this select 1; _nr_bat = floor (3+random 4);while {_nr_bat>0} do {[_loc_bomb,_explosion_diameter_t] call fnc_brate;_nr_bat = _nr_bat-1;sleep 0.01}};
sleep 0.3;

[_bomb_obj_b,_explosion_diameter] spawn {_loc_bomb = _this select 0; _explosion_diameter_t = _this select 1; _nr_bat = floor (3+random 10);while {_nr_bat>0} do {[_loc_bomb,_explosion_diameter_t] call fnc_schije; _nr_bat = _nr_bat-1}};
[[_bomb_obj_b,_explosion_diameter,0.01],"ALfire\fire.sqf"] remoteExec ["execVM"];
sleep 15;
if (_al_crater) then {0 = [getpos _bomb_obj_b, 0, call (compile (preprocessFileLineNumbers "AL_bomb\crater_bomb_obj.sqf"))] call BIS_fnc_ObjectsMapper;crater_obj = nearestObjects[_bomb_obj_b,[],100];{[_x, 0, -20] call BIS_fnc_setPitchBank} foreach crater_obj};
sleep 60;
deleteVehicle _bomb_obj_b;