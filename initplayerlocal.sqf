if (didJIP) then {
    [player] remoteExec ["grad_common_fnc_addJipToZeus",2,false];
};

["InitializePlayer", [player,true]] call BIS_fnc_dynamicGroups;
grad_template_ratingEH = player addEventHandler ["HandleRating",{0}];

if (!didJIP) then {
    titleText ["<t color='#333333' size='0.7'>loading...</t>","BLACK FADED",-1, true, true];
    diwako_dui_main_toggled_off = true;
};