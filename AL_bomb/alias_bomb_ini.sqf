// by ALIAS null = [] execVM "AL_bomb\alias_bomb_ini.sqf";

fnc_brate = {
	private ["_vit_z","_vit_x","_vit_y","_buc_nap","_loc_bomb"];
	_loc_bomb = _this select 0;
	_vit_z = floor (60+random 300);
	_vit_x = ([1,-1] call BIS_fnc_selectRandom)* floor (50+random 50);
	_vit_y = ([1,-1] call BIS_fnc_selectRandom)* floor (50+random 50);
	_buc_nap = createVehicle ["Land_Battery_F", getPosATL _loc_bomb, [], floor (size_b/3), "CAN_COLLIDE"];
	[[_buc_nap],"AL_bomb\alias_fum_bomb.sqf"] remoteExec ["execVM"];
	_buc_nap setVelocity [_vit_x,_vit_y,_vit_z];
	[_buc_nap] spawn {_de_delete = _this select 0; sleep 1+random 2; deleteVehicle _de_delete;};
};

fnc_schije = {
	private ["_vit_z","_vit_x","_vit_y","_buc_nap","_loc_bomb"];
	_loc_bomb = _this select 0;
	_vit_z = 30+random 70;
	_vit_x = ([1,-1] call BIS_fnc_selectRandom)* floor (10+random 40);
	_vit_y = ([1,-1] call BIS_fnc_selectRandom)* floor (10+random 40);
	_buc_nap = createVehicle ["Land_Battery_F", getPosATL _loc_bomb, [], floor (size_b/3), "CAN_COLLIDE"];
	[[_buc_nap],"AL_bomb\alias_buc_bomb.sqf"] remoteExec ["execVM"];
	_buc_nap setVelocity [_vit_x,_vit_y,_vit_z];
	[_buc_nap] spawn {_de_delete = _this select 0; sleep 5+random 10; deleteVehicle _de_delete};
};

if (!isServer) exitWith {};

private ["_bomb_obj","_poz_blow"];

_bomb_obj	= _this select 0;
size_b		= _this select 1;
publicVariable "size_b";
al_crater	= _this select 2;
publicVariable "al_crater";
al_destruction	= _this select 3;
publicVariable "al_destruction";

_poz_blow = getPos _bomb_obj;
_bomb_obj_b = "Land_HelipadEmpty_F" createVehicle [_poz_blow select 0,_poz_blow select 1,0];

if (al_destruction) then 
{
	[_bomb_obj_b] spawn 
	{
		_poz_destr = _this select 0;
		_veget = nearestTerrainObjects [position _poz_destr, ["TREE","SMALL TREE","BUSH"],1.5*size_b];
		_build = nearestObjects [position _poz_destr,["building"],1.5*size_b];
		_misce = nearestObjects [position _poz_destr,["man","car","tank","plane","helicopter"],1.5*size_b];
		{if !(_x isKindOf "Land_HelipadEmpty_F") then {_x setVelocity [0,0,30+random 30]; _x setdamage 1};sleep 0.01} foreach _misce;
		{if !(_x isKindOf "Land_HelipadEmpty_F") then {_x setDamage [1,false]; sleep 0.01}} foreach _build;		
		{_x setDamage 1; sleep 0.01} foreach _veget;
	};
};

[[_bomb_obj_b, size_b],"AL_bomb\alias_bomb_effect.sqf"] remoteExec ["execVM"];

[_bomb_obj_b] spawn {_loc_bomb = _this select 0;_nr_bat = floor (3+random 4);while {_nr_bat>0} do {[_loc_bomb] call fnc_brate;_nr_bat = _nr_bat-1;sleep 0.01}};
sleep 0.3;
[_bomb_obj_b] spawn 
{
	_loc_bomb = _this select 0;
	_nr_bat = floor (3+random 10);
	while {_nr_bat>0} do {[_loc_bomb] call fnc_schije;_nr_bat = _nr_bat-1};
};
[[_bomb_obj_b,size_b,0.01],"ALfire\fire.sqf"] remoteExec ["execVM"];
sleep 15;
if (al_crater) then {0 = [getpos _bomb_obj_b, 0, call (compile (preprocessFileLineNumbers "AL_bomb\crater_bomb_obj.sqf"))] call BIS_fnc_ObjectsMapper;crater_obj = nearestObjects[_bomb_obj_b,[],100];{[_x, 0, -20] call BIS_fnc_setPitchBank} foreach crater_obj};
sleep 60;
deleteVehicle _bomb_obj_b;