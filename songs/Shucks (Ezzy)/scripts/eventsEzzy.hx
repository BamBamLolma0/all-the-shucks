function postCreate() {
    setCharcter(0, 1, false);
    setCharcter(0, 2, false);
    setCharcter(1, 1, false);
    setCharcter(1, 2, false);
    setCharcter(2, 0, false);
    for (i in 0...2) {
        strumLines.members[1].characters[i].flipX = false;
    }
}

function beatHit(b) {
    switch(b) {
        case 128:
            defaultCamZoom = 0.4;
            setCharcter(0, 0, false);
            setCharcter(1, 0, false);
            setCharcter(0, 1, true);
            setCharcter(1, 1, true);
            setCharcter(2, 0, true);
    }
}

function setCharcter(sID, cID, onOrOff) {
    strumLines.members[sID].characters[cID].visible = onOrOff;
}