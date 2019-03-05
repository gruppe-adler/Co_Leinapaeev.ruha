/*
*   Hier können eigene Sounds eingebunden werden.
*   Ist in CfgSounds included.
*/

class introRadio
{
    // how the sound is referred to in the editor (e.g. trigger effects)
    name = "introRadio";
    // filename, volume, pitch, distance (optional)
    sound[] = { "sounds\radio.ogg", 10, 1 };
    // subtitle delay in seconds, subtitle text
    titles[] = { 0, "" };
};

class introSiren
{
    // how the sound is referred to in the editor (e.g. trigger effects)
    name = "introSiren";
    // filename, volume, pitch, distance (optional)
    sound[] = { "sounds\siren.ogg", 10, 1 };
    // subtitle delay in seconds, subtitle text
    titles[] = { 0, "" };
};