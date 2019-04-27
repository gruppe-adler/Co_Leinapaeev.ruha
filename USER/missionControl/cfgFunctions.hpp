class missionControl {

    class client {
        file = USER\missionControl\client;

        class addModules { postInit = 1; };

        class addPeeAction;
        class addSpawnMarker;
        class doPee;
        class dressUpAction;
        class enableWheelchairCarry;
        class introKeyAnimation;
        class introLocal;
        class jipSpawn;
        class loadWheelchair;
        class peeFX;
        class showStats;
        class spawnSmoke;
        class standUp;
        class unflipWheelchair;
        class unloadWheelchair;
    };

    class server {
        file = USER\missionControl\server;

        class addExplosion;
        class addKilledEH;
        class addKilledEHPlayer;
        class bwConvoyStart;
        class civilianRoadFlow;
        class executeExplosions;
        class introServer { postInit = 1; };
        class killrateTracker { postInit = 1; };
        class mi8Drop;
        class mi8land;
        class spawnExplosion;
        class spawnFish;
    };
};