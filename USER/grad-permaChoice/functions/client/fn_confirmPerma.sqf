private _confirmed = [
"Sterben und Zusehen?", 
"Willst du wirklich sterben und in den Spectator bis zur Nachbesprechung?", 
"Bestätigen", 
"Abbrechen"
] call BIS_fnc_guiMessage;

if (_confirmed) then {
    closeDialog 0; player setDamage 1; 
    [] call grad_permaChoice_fnc_setPlayerSpectator;
} else {
    
};