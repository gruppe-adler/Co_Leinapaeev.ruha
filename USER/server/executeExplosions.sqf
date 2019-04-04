private _explosions = missionNamespace getVariable ["GRAD_LP_explosionSpawns", []];

{
  
  	private _position = _x select 0;
  	private _timeout = _x select 1;

  	[_position, _timeout] execVM "USER\server\spawnExplosion.sqf";

  	sleep (random 3);

} forEach _explosions;