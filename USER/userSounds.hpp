/*
*   Hier können eigene Sounds eingebunden werden.
*   Ist in CfgSounds included.
*/

class introRadio
{
    // how the sound is referred to in the editor (e.g. trigger effects)
    name = "introRadio";
    // filename, volume, pitch, distance (optional)
    sound[] = { "sounds\radio1_complete.ogg", 10, 1 };
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

class furnal
{
    name = "furnal";
    sound[] = {"\sounds\alias\furnal.ogg", 1, 1};
    titles[] = {1, ""};
};
class burned
{
    name = "burned";
    sound[] = {"\sounds\alias\burned.ogg", 1, 1};
    titles[] = {1, ""};
};
class tipat
{
    name = "tipat";
    sound[] = {"\sounds\alias\tipat.ogg", 0.8, 1};
    titles[] = {1, ""};
};
class bombix
{
    name = "bombix";
    sound[] = {"\sounds\alias\bombix.ogg", db+20, 1};
    titles[] = {1, ""};
};
class bombix_echo
{
    name = "bombix_echo";
    sound[] = {"\sounds\alias\bombix_echo.ogg", db+5, 1};
    titles[] = {1, ""};
};