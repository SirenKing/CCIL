function SetupCamera() {

    GameUI.SetCameraPitchMin(90);
    GameUI.SetCameraPitchMax(90);

    $.Schedule(0.03, SetupCamera);
}

SetupCamera();