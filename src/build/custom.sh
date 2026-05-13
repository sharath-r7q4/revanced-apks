#!/bin/bash
source src/build/utils.sh
get_deps() {
  wget -q https://dl.google.com/android/repository/build-tools_r34-linux.zip -O build-tools.zip      
  wget -q $(curl -fsSL https://api.github.com/repos/REAndroid/APKEditor/releases/latest | jq -r '.assets[0].browser_download_url') -O apkeditor.jar
  unzip -q build-tools.zip -d android-build-tools
  mv android-build-tools/android-14/lib/apksigner.jar apksigner.jar
}
sign() {
    java -jar apksigner.jar sign --ks ks-p12.keystore --ks-type PKCS12 --ks-key-alias $KEYSTORE_ALIAS --ks-pass pass:$KEYSTORE_PASS --in $1 --out $2
}

dolphin() {
    get_deps
    export DOLPHIN_LATEST=$(gh release view "Dolphin-SDK29" --json body --template '{{.body}}' | grep dolphin | awk '{print $NF}')
    DOLPHIN_APK_URL=$( curl -s https://dolphin-emu.org/download/ | grep -Eo 'https://dl\.dolphin-emu\.org/builds/[a-z0-9/]+/dolphin-master-[0-9]+-[0-9]+\.apk' | awk -F'[-/.]' '{v=$(NF-2); b=$(NF-1);if (v>V || (v==V && b>B)) {V=v; B=b; U=$0}} END{print U}')
    DOLPHIN_NAME=$(basename "$DOLPHIN_APK_URL" .apk)
    echo -e "Patched Dolphin SDK 29: $DOLPHIN_NAME" >> build.log
    if [[ $DOLPHIN_NAME != $DOLPHIN_LATEST ]] || [[ "$GITHUB_EVENT_NAME" == "workflow_dispatch" ]]; then
        curl -L "$DOLPHIN_APK_URL" -o dolphin-orig.apk
        java -jar apkeditor.jar d -i dolphin-orig.apk -o dolphin-src -t xml -dex
        sed -i 's/android:targetSdkVersion="[^"]*"/android:targetSdkVersion="29"/g' dolphin-src/AndroidManifest.xml
        java -jar apkeditor.jar b -i dolphin-src -o dolphin-patched.apk
        sign dolphin-patched.apk dolphin-sdk29.apk
    else
       exit 0
    fi
}

eden() {
    get_deps
    export EDEN_LATEST=$(gh release view "Eden-PUBG" --json body --template '{{.body}}' | grep Eden | awk '{print $NF}')
    export EDEN_LATEST=$(gh release view "Eden-PUBG" --json body --template '{{.body}}' | grep Eden | awk '{print $NF}')          
    export EDEN_ID=$(gh run list -R Eden-CI/Workflow -w nightly.yml --status success --limit 1 --json databaseId -q ".[0].databaseId")
    export EDEN_NAME=$(gh run view $EDEN_ID -R Eden-CI/Workflow | grep standard.apk)
    gh api "/repos/Eden-CI/Workflow/actions/artifacts/$(gh api repos/Eden-CI/Workflow/actions/runs/$EDEN_ID/artifacts --jq '.artifacts[] | select(.name| contains("standard.apk")) | .id')/zip" > eden-orig.apk
    echo -e "Patched Eden PUBG: $EDEN_NAME" >> build.log
    if [[ $EDEN_NAME != $EDEN_LATEST ]] || [[ "$GITHUB_EVENT_NAME" == "workflow_dispatch" ]]; then
        java -jar apkeditor.jar d -i eden-orig.apk -o eden-src -t xml -dex
        sed -i 's/dev\.eden\.eden_emulator\.nightly/com.tencent.ig/g' eden-src/AndroidManifest.xml
        java -jar apkeditor.jar b -i eden-src -o eden-patched.apk
        sign eden-patched.apk eden-pubg.apk
    else
       exit 0
    fi
}

fcl() {
    get_deps
    export FCL_LATEST=$(gh release view "FCL-CoD" --json body --template '{{.body}}' | grep FCL | awk '{print $NF}')
    FCL_APK_URL=$(curl -fSsL https://api.github.com/repos/FCL-Team/foldcraftlauncher/releases/latest | jq -r '.assets[0].browser_download_url')
    FCL_NAME=$(basename "$FCL_APK_URL" .apk)
    echo -e "Patched FCL PUBG: $FCL_NAME" >> build.log
    if [[ $FCL_NAME != $FCL_LATEST ]] || [[ "$GITHUB_EVENT_NAME" == "workflow_dispatch" ]]; then
        curl -L "$FCL_APK_URL" -o fcl-orig.apk
        java -jar apkeditor.jar d -i fcl-orig.apk -o fcl-src -t xml -dex
        sed -i -e 's/package="com\.tungsten\.fcl"/package="com.activision.callofduty.shooter"/' -e 's/com\.tungsten\.fcl\.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION/com.activision.callofduty.shooter.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION/g' -e 's/com\.tungsten\.fcl\.document\.provider/com.activision.callofduty.shooter.document.provider/g' -e 's/com\.tungsten\.fcl\.provider/com.activision.callofduty.shooter.provider/g' -e 's/com\.tungsten\.fcl\.crashreporterinitprovider/com.activision.callofduty.shooter.crashreporterinitprovider/g' -e 's/com\.tungsten\.fcl\.androidx-startup/com.activision.callofduty.shooter.androidx-startup/g' fcl-src/AndroidManifest.xml
        java -jar apkeditor.jar b -i fcl-src -o fcl-patched.apk
        sign fcl-patched.apk fcl-cod.apk
    else
       exit 0
    fi
}

geode() {
    get_deps
    export GEODE_LATEST=$(gh release view "Geode-PUBGKR" --json body --template '{{.body}}' | grep Geode | awk '{print $NF}')
    GEODE_APK_URL=$(curl -fSsL https://api.github.com/repos/geode-sdk/android-launcher/releases/latest |  jq -r '.assets[] | select(.name | endswith(".apk") and (contains("android32") | not)) | .browser_download_url' )
    GEODE_NAME=$(basename "$GEODE_APK_URL" .apk)
    echo -e "Patched Geode PUBG KR: $GEODE_NAME" >> build.log
    if [[ $GEODE_NAME != $GEODE_LATEST ]] || [[ "$GITHUB_EVENT_NAME" == "workflow_dispatch" ]]; then
        curl -L "$GEODE_APK_URL" -o geode-orig.apk
        java -jar apkeditor.jar d -i geode-orig.apk -o geode-src -t xml -dex
        sed -i -e 's/package="com\.geode\.launcher"/package="com.pubg.krmobile"/' -e '/package="com\.pubg\.krmobile"/a\    android:compileSdkVersion="36"\n    android:compileSdkVersionCodename="16"' -e '/android:compileSdkVersion="36"/d' -e '/android:compileSdkVersionCodename="16"/d' -e '0,/package="com\.pubg\.krmobile"/s//android:compileSdkVersion="36"\n    android:compileSdkVersionCodename="16"\n    package="com.pubg.krmobile"/' -e 's/com\.geode\.launcher\.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION/com.pubg.krmobile.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION/g' -e 's/com\.geode\.launcher\.user/com.pubg.krmobile.user/g' -e 's/com\.geode\.launcher\.fileprovider/com.pubg.krmobile.fileprovider/g' -e 's/com\.geode\.launcher\.androidx-startup/com.pubg.krmobile.androidx-startup/g' geode-src/AndroidManifest.xml         
        java -jar apkeditor.jar b -i geode-src -o geode-patched.apk
        sign geode-patched.apk geode-pubg.apk
    else
       exit 0
    fi
}

case "$1" in
    dolphin)
        dolphin
        ;;
    eden)
        eden
        ;;
    fcl)
        fcl
        ;;
    geode)
        geode
        ;;
esac
