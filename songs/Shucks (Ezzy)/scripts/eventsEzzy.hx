import funkin.backend.MusicBeatState;
import hxvlc.flixel.FlxVideoSprite;

var ass:CustomShader;
var bloom:CustomShader;
introLength = 0;

function postCreate() {
    setStage("lala dark section");
    setCharcter(0, 0, true);
    setCharcter(1, 0, true);
    setCharcter(0, 1, false);
    setCharcter(0, 2, false);
    setCharcter(1, 1, false);
    setCharcter(1, 2, false);
    setCharcter(2, 0, false);
    strumLines.members[2].characters[0].cameraOffset.set(900, 500);
}

function flicker(cam:FlxCamera, d:Float, i:Float) {
    cam.visible = !cam.visible;
    lol = new FlxTimer().start(i, () -> {
        cam.visible = !cam.visible;
        if (lol.loopsLeft == 0) cam.visible = true;
    }, Std.int(d / i));
}

function beatHit(b) {
    switch(b) {
        case 128:
            camHUD.fade(FlxColor.BLACK, (Conductor.stepCrochet / 1000) * 4, null, () -> {
                camHUD.stopFade();
                camNotes.alpha = camHUD.alpha = 0;
                camGame.visible = false;
                flicker(camGame, (Conductor.stepCrochet / 1000) * 4, Conductor.stepCrochet / 2500);
                setStrumSkin("default", [0, 1]);
                setIridaBar("default");
                setStage("p1_");

                iconP1.setIcon("marvin-shucks");
                iconP2.setIcon("detg", 200, 150);
                setCharcter(0, 0, false);
                setCharcter(1, 0, false);
                setCharcter(0, 1, true);
                setCharcter(1, 1, true);
                setCharcter(2, 0, true);
                strumLines.members[2].characters[0].cameraOffset.set(-25, 475);

                strumLines.members[0].characters[0].cameraOffset.set(-825, -875);
                strumLines.members[1].characters[1].cameraOffset.set(325, 675);
                
                if (Options.gameplayShaders && FlxG.save.data.iridaBloom) {
                    bloom = new CustomShader('bloom');
                    camGame.addShader(bloom);
                    bloom.Threshold = 0.005;
                    bloom.Intensity = 1;
                }

                if (Options.gameplayShaders && FlxG.save.data.iridaColorCorrect) {
                    ass = new CustomShader('ColorCorrection');
                    camGame.addShader(ass);
                    ass.contrast = 30;
                    ass.hue = -10;
                    ass.saturation = -10;
                }

                healthBar.createFilledBar(0xffbf5e2b, 0xffae211b);
                healthBar.percent = health;

                camGame.zoom = defaultCamZoom = 0.4;
            });
        case 143:
            camHUD.stopFade();
            FlxTween.tween(camNotes, {alpha: 1}, (Conductor.stepCrochet / 1000) * 16);
            FlxTween.tween(camHUD, {alpha: 1}, (Conductor.stepCrochet / 1000) * 16);
    }
}

function postPostCreate() {
}

function setCharcter(sID, cID, onOrOff) {
    strumLines.members[sID].characters[cID].alpha = 1;
    strumLines.members[sID].characters[cID].visible = onOrOff;
}
var roseLooking:Int;
function onCameraMove() {
    if (roseLooking != curCameraTarget) {
        roseLooking = curCameraTarget;
        strumLines.members[2].characters[0].idleSuffix = curCameraTarget == 1 ? "right" : "left";
        strumLines.members[2].characters[0].playAnim("look-" + strumLines.members[2].characters[0].idleSuffix);
    }
}