params ["_box"];

if (!isServer) exitWith {};

_box addMagazineCargoGlobal ["rhssaf_30rnd_556x45_EPR_G36", 60];
_box addMagazineCargoGlobal ["rhs_200rnd_556x45_M_SAW", 30];
_box addMagazineCargoGlobal ["rhsusf_100Rnd_556x45_soft_pouch", 10];

_box addItemCargoGlobal ["ACE_entrenchingTool", 6];
_box addItemCargoGlobal ["grad_axe", 6];
