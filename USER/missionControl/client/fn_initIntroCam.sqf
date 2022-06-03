private _camera = createAgent ["Camera_F", [0,0,0], [], 0, "FORM"]; // ([introCam1] call BIS_fnc_camera_getCam);
intro_richcurve synchronizeObjectsAdd [_camera];
player setVariable ["localIntroCamera", _camera];