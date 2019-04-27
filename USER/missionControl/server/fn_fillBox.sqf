params ["_box"];

if (!isServer) exitWith {};

_box addMagazineCargoGlobal ["rhssaf_30rnd_556x45_EPR_G36", 30];
_box addMagazineCargoGlobal ["rhs_200rnd_556x45_M_SAW", 6];
_box addMagazineCargoGlobal ["rhsusf_100Rnd_556x45_soft_pouch", 6];

_box addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 6];
_box addMagazineCargoGlobal ["sfp_strvm5_mag", 6];

_box addItemCargoGlobal ["ACE_entrenchingTool", 6];
_box addItemCargoGlobal ["grad_axe", 6];