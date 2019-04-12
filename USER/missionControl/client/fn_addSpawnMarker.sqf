params ["_position"];

private _markerstr = createMarkerLocal ["mrk_lp_spawn",_position];
_markerstr setMarkerShapeLocal "ICON";
_markerstr setMarkerTypeLocal "hd_start";
_markerstr setMarkerColorLocal "ColorIndependent";
_markerstr setMArkerTextLocal "Startpunkt";

["Mein Mittagsschläfchen wird von Sirenengeheul unterbrochen. Sicher sind meine Kaitseliit Kameraden jetzt auf dem Weg zur NATO - Basis um dort Ausrüstung zu besorgen. Ich sollte dort nach ihnen suchen..."] spawn BIS_fnc_guiMessage;