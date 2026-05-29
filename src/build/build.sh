#!/bin/bash
#CI build
source ./src/build/utils.sh
sign() {
    java -jar apksigner.jar sign --ks ks-p12.keystore --ks-type PKCS12 --ks-key-alias $KEYSTORE_ALIAS --ks-pass pass:$KEYSTORE_PASS --in $1 --out $2
}
LSPatch_dl(){
	dl_gh "LSPatch" "JingMatrix" "latest"
}
morphe_dl(){
	dl_gh "morphe-cli" "MorpheApp" "latest"
	dl_gh "morphe-patches" "MorpheApp" "prerelease"
}

piko_dl(){
    dl_gh "morphe-cli" "MorpheApp" "latest"
    dl_gh "piko" "crimera" "prerelease"
}

hoo-dles_dl(){
	dl_gh "morphe-cli" "MorpheApp" "latest"
	dl_gh "morphe-patches" "hoo-dles" "latest"
}

binarymend_dl(){
	dl_gh "morphe-cli" "MorpheApp" "latest"
	dl_gh "morphe-patches" "binarymend" "latest"
}
paresh_dl(){
	dl_gh "morphe-cli" "MorpheApp" "latest"
	dl_gl "paresh-patches" "Paresh-Maheshwari" "latest"
}
revenge-discord() {
	# Patch Revenge:
	LSPatch_dl
	dl_gh "revenge-xposed" "revenge-mod" "latest"
	_fs_get https://www.apkmirror.com/apk/discord/discord-chat-for-gamers/feed/
	version=$(curl -s https://www.apkmirror.com/apk/discord/discord-chat-for-gamers/feed/  -H "Cookie: $FS_COOKIES" -H "User-Agent: $user_agent"   |  grep -E '(title>|description>)' | tail -n +4 | sed -e 's/^[ \t]*//' | sed -e 's/<title>//' -e 's/<\/title>//' -e 's/<description>/  /' -e 's/<\/description>//' |  grep -oE '[0-9]+\.[0-9]+.*' |  awk -F ' by' '{print $1}' | grep Beta | head -n 1 )
	get_apk "com.discord" "discord" "bundle"
	lspatch "discord" "app-release" "revenge"
}

piko-x() {
    piko_dl
    # Patch Twitter Piko:
    get_patches_key "x-piko"
    telegram_dl "https://t.me/xriprepo" "10" "*.apk" "x-stable.apk" #https://github.com/crimera/piko/issues/1146#issuecomment-4469171783
	patch "x-stable" "piko" "morphe"
}
piko-instagram() {
    piko_dl
    # Patch Instagram
    get_patches_key "instagram-piko"
    get_apk "com.instagram.android" "instagram-arm64-v8a" "bundle" "arm64-v8a" "120-640dpi"  "Android 9.0+"
    patch "instagram-arm64-v8a" "piko" "morphe"
}
hoo-dles-prime-video() {
	hoo-dles_dl
	# Patch Amazon Prime Video:
	# Arm64-v8a
	get_patches_key "prime-video-hoo-dles"
    detect_version "com.amazon.avod.thirdpartyclient"
    version1=$(printf '%s\n' "$version" "$prefer_version" | sort -V | tail -n1)
    version=${version1%.*}
	get_apk "com.amazon.avod.thirdpartyclient" "prime-video" "apk" "arm64-v8a" "nodpi" "Android 9.0+"
	patch "prime-video" "hoo-dles" "morphe"
}
paresh-protonvpn() {
	paresh_dl
	#Patch Proton VPN
	get_patches_key "Proton-VPN-paresh"
	get_apk "ch.protonvpn.android" "protonvpn" "apk"
	patch "protonvpn" "paresh" "morphe"
}
binarymend-sympfonium(){
	binarymend_dl
	get_patches_key "Sympfonium-binarymend"
	get_apk "app.symfonik.music.player" "sympfonium" "bundle"
	patch "sympfonium" "binarymend" "morphe"
}
morphe-youtube() {
	morphe_dl
	# Patch YouTube:
	prefer_version="$youtube_experimental_support"
	get_patches_key "youtube-morphe"
	get_apk "com.google.android.youtube" "youtube-app" "apk"
	patch "youtube-app" "morphe" "morphe"
}
morphe-youtube-music-x86() {
	morphe_dl
	# Patch YouTube Music x86:
	prefer_version="$youtube_music_experimental_support"
	get_patches_key "youtube-music-morphe"
	get_apk "com.google.android.apps.youtube.music" "youtube-music-x86" "apk" "x86_64"
	patch "youtube-music-x86" "morphe" "morphe"
}
morphe-youtube-music-arm() {
	morphe_dl
	# Patch YouTube Music Arm64-v8a:
	prefer_version="$youtube_music_experimental_support"
	get_patches_key "youtube-music-morphe"
	get_apk "com.google.android.apps.youtube.music" "youtube-music-arm" "apk" "arm64-v8a"
	patch "youtube-music-arm" "morphe" "morphe"
}
paresh-jiohotstar() {
	paresh_dl
	# Patch JioHotstar:
	get_patches_key "jiohotstar-paresh"
	get_apk "in.startv.hotstar" "jiohotstar" "apk"
	patch "jiohotstar" "paresh" "morphe"
}
amazon-india(){
	get_apk "in.amazon.mShop.android.shopping" "amazon-india" "bundle"
	java -jar APKEditor.jar m -i amazon-india.apkm
	sign "amazon-india.apk" "./release/amazon-india-$version.apk"
}
dolphin() {
    _fs_get https://dolphin-emu.org/download/
    export DOLPHIN_LATEST=$(gh release view "Dolphin-SDK29" --json  assets | jq .[].[0].name)
    DOLPHIN_LATEST=${DOLPHIN_LATEST%%.*}
    DOLPHIN_APK_URL=$(curl  https://dolphin-emu.org/download/ | grep -Eo 'https://dl\.dolphin-emu\.org/builds/[a-z0-9/]+/dolphin-master-[0-9]+-[0-9]+\.apk' | awk -F'[-/.]' '{v=$(NF-2); b=$(NF-1);if (v>V || (v==V && b>B)) {V=v; B=b; U=$0}} END{print U}')
    DOLPHIN_NAME=$(basename "$DOLPHIN_APK_URL" .apk)
    if [[ $DOLPHIN_NAME != $DOLPHIN_LATEST ]] || [[ "$GITHUB_EVENT_NAME" == "workflow_dispatch" ]]; then
        curl -L "$DOLPHIN_APK_URL" -H "Cookie: $FS_COOKIES" -H "User-Agent: $user_agent"  -o dolphin-orig.apk
        java -jar APKEditor.jar d -i dolphin-orig.apk -o dolphin-src -t xml -dex
        sed -i 's/android:targetSdkVersion="[^"]*"/android:targetSdkVersion="29"/g' dolphin-src/AndroidManifest.xml
        java -jar APKEditor.jar b -i dolphin-src -o dolphin-patched.apk
        sign dolphin-patched.apk ./release/$DOLPHIN_NAME-sdk29.apk
    else
       exit 0
    fi
}

eden() {
    export EDEN_ID=$(gh run list -R Eden-CI/Workflow -w nightly.yml --status success --limit 1 --json databaseId -q ".[0].databaseId")
    date1=$(gh run list -R Eden-CI/Workflow -w nightly.yml --status success --limit 1 --json updatedAt  -q ".[0].updatedAt")
    export EDEN_NAME=$(gh run view $EDEN_ID -R Eden-CI/Workflow | grep standard.apk | cut -d'-' -f3 )
    gh api "/repos/Eden-CI/Workflow/actions/artifacts/$(gh api repos/Eden-CI/Workflow/actions/runs/$EDEN_ID/artifacts --jq '.artifacts[] | select(.name| contains("standard.apk")) | .id')/zip" > eden-orig.apk
    java -jar APKEditor.jar d -i eden-orig.apk -o eden-src -t xml -dex
    sed -i 's/dev\.eden\.eden_emulator\.nightly/com.tencent.ig/g' eden-src/AndroidManifest.xml
    java -jar APKEditor.jar b -i eden-src -o eden-patched.apk
    sign eden-patched.apk ./release/Eden-Android-$EDEN_NAME-$date1-pubg.apk
}

fcl() {
    FCL_APK_URL=$(curl -fSL https://api.github.com/repos/FCL-Team/foldcraftlauncher/releases/latest | jq -r '.assets[0].browser_download_url')
    FCL_NAME=$(basename "$FCL_APK_URL" .apk)
    curl -L "$FCL_APK_URL" -o fcl-orig.apk
    java -jar APKEditor.jar d -i fcl-orig.apk -o fcl-src -t xml -dex
    sed -i -e 's/package="com\.tungsten\.fcl"/package="com.activision.callofduty.shooter"/' -e 's/com\.tungsten\.fcl\.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION/com.activision.callofduty.shooter.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION/g' -e 's/com\.tungsten\.fcl\.document\.provider/com.activision.callofduty.shooter.document.provider/g' -e 's/com\.tungsten\.fcl\.provider/com.activision.callofduty.shooter.provider/g' -e 's/com\.tungsten\.fcl\.crashreporterinitprovider/com.activision.callofduty.shooter.crashreporterinitprovider/g' -e 's/com\.tungsten\.fcl\.androidx-startup/com.activision.callofduty.shooter.androidx-startup/g' fcl-src/AndroidManifest.xml
    java -jar APKEditor.jar b -i fcl-src -o fcl-patched.apk
    sign fcl-patched.apk ./release/$FCL_NAME-cod.apk
}

geode() {
    GEODE_APK_URL=$(curl -fSL https://api.github.com/repos/geode-sdk/android-launcher/releases/latest |  jq -r '.assets[] | select(.name | endswith(".apk") and (contains("android32") | not)) | .browser_download_url' )
    GEODE_NAME=$(basename "$GEODE_APK_URL" .apk)
    curl -L "$GEODE_APK_URL" -o geode-orig.apk
    java -jar APKEditor.jar d -i geode-orig.apk -o geode-src -t xml -dex
    sed -i -e 's/package="com\.geode\.launcher"/package="com.pubg.krmobile"/' -e '/package="com\.pubg\.krmobile"/a\    android:compileSdkVersion="36"\n    android:compileSdkVersionCodename="16"' -e '/android:compileSdkVersion="36"/d' -e '/android:compileSdkVersionCodename="16"/d' -e '0,/package="com\.pubg\.krmobile"/s//android:compileSdkVersion="36"\n    android:compileSdkVersionCodename="16"\n    package="com.pubg.krmobile"/' -e 's/com\.geode\.launcher\.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION/com.pubg.krmobile.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION/g' -e 's/com\.geode\.launcher\.user/com.pubg.krmobile.user/g' -e 's/com\.geode\.launcher\.fileprovider/com.pubg.krmobile.fileprovider/g' -e 's/com\.geode\.launcher\.androidx-startup/com.pubg.krmobile.androidx-startup/g' geode-src/AndroidManifest.xml         
    java -jar APKEditor.jar b -i geode-src -o geode-patched.apk
    sign geode-patched.apk ./release/$GEODE_NAME-pubgkr.apk
}

winlator() {
    WINLATOR_APK_URL=$(curl -fSL https://api.github.com/repos/StevenMXZ/Winlator-Ludashi/releases/latest | jq -r '.assets[] | select(.name | endswith("build.apk")) | .browser_download_url')
    WINLATOR_TAG=$(curl -fSL https://api.github.com/repos/StevenMXZ/Winlator-Ludashi/releases/latest | jq -r '.tag_name')
    curl -L "$WINLATOR_APK_URL" -o winlator-orig.apk
    java -jar APKEditor.jar d -i winlator-orig.apk -o winlator-src -t xml -dex
    sed -i -e 's/package="com\.tencent\.ig"/package="com.vng.pubgmobile"/' -e 's/com\.tencent\.ig\.tileprovider/com.vng.pubgmobile.tileprovider/' -e 's/com\.tencent\.ig\.core\.WinlatorFilesProvider/com.vng.pubgmobile.core.WinlatorFilesProvider/' -e 's/com\.tencent\.ig\.androidx-startup/com.vng.pubgmobile.androidx-startup/' winlator-src/AndroidManifest.xml
    java -jar APKEditor.jar b -i winlator-src -o winlator-patched.apk
    sign winlator-patched.apk ./release/winlator-$WINLATOR_TAG-pubgvn.apk
}

case "$1" in
    revenge-discord)
        revenge-discord
        ;;
	piko-x)
		piko-x
		;;
	piko-instagram)
		piko-instagram
		;;
	hoo-dles-prime-video)
		hoo-dles-prime-video
		;;
	paresh-protonvpn)
		paresh-protonvpn
		;;
	paresh-jiohotstar)
		paresh-jiohotstar
		;;
	morphe-youtube)
		morphe-youtube
		;;
	binarymend-sympfonium)
		binarymend-sympfonium
		;;
	morphe-youtube-music-x86)
		morphe-youtube-music-x86
		;;
	morphe-youtube-music-arm)
		morphe-youtube-music-arm
		;;
	amazon-india)
		amazon-india
		;;
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
    winlator)
        winlator
        ;;
esac
