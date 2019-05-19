class missionControl {

    class client {
        file = USER\missionControl\client;

        class addModules { postInit = 1; };

        class addPeeAction;
        class addSmokeToCar;
        class addSpawnMarker;
        class doPee;
        class dressUpAction;
        class enableWheelchairCarry;
        class introKeyAnimation;
        class introLocal;
        class jipSpawn;
        class loadWheelchair;
        class outroSequence;
        class peeFX;
        class policeLights;
        class rotatingCam;
        class showStats;
        class sitDown;
        class spawnSmoke;
        class standUp;
        class unflipWheelchair;
        class unloadWheelchair;
        class weaponOnBack;
        class wheelChairActions;
    };

    class server {
        file = USER\missionControl\server;

        class addExplosion;
        class addKilledEH;
        class addKilledEHPlayer;
        class bwConvoyStart;
        class bwConvoySetup { postInit = 1; };
        class civilianRoadFlow;
        class createChairCircle;
        class deleteCar;
        class executeExplosions;
        class fillBox;
        class fillRadios;
        class getPosInCircle;
        class introServer { postInit = 1; };
        class killrateTracker { postInit = 1; };
        class mi8Drop;
        class mi8land;
        class mi8Parachute;
        class mi8recon;
        class outro;
        class setMePeeGuy;
        class spawnExplosion;
        class spawnFish;
    };
};