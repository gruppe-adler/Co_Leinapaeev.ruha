class missionControl {

    class client {
        file = USER\missionControl\functions\client;

        class addModules { postInit = 1; };

        class addPeeAction;
        class addSpawnMarker;
        class doPee;
        class dressUpAction;
        class enableWheelchairCarry;
        class introKeyAnimation;
        class jipSpawn;
        class loadWheelchair;
        class peeFX;
        class spawnSmoke;
        class standUp;
        class unflipWheelchair;
        class unloadWheelchair;
    };

    class server {
        file = USER\missionControl\functions\server;

        class addExplosion;
        class addKilledEH;
        class addKilledEHPlayer;
        class bwConvoyStart;
        class civilianRoadFlow;
        class executeExplosions;
        class introServer;
        class killrateTracker { postInit = 1; };
        class mi8Drop;
        class miland;
        class spawnExplosion;
        class spawnFish;
    };
};