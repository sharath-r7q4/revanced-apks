#!/bin/bash
#CI build
source ./src/build/utils.sh

LSPatch_dl(){
	dl_gh "LSPatch" "JingMatrix" "latest"
}
morphe_dl(){
	dl_gh "morphe-patches" "MorpheApp" "prerelease"
	dl_gh "morphe-cli" "MorpheApp" "latest"
}

piko_dl(){
    dl_gh "morphe-cli" "MorpheApp" "latest"
    dl_gh "piko" "crimera" "prerelease"
}

hoo-dles_dl(){
	dl_gh "morphe-cli" "MorpheApp" "latest"
	dl_gh "morphe-patches" "hoo-dles" "latest"
}

revenge-discord() {
	# Patch Revenge:
	dl_gh "revenge-xposed" "revenge-mod" "latest"
	LSPatch_dl
	get_apk "com.discord" "discord" "bundle"
	lspatch "discord" "app-release" "revenge"
}

piko-x() {
    piko_dl
    # Patch Twitter Piko:
    get_patches_key "x-piko"
    get_apk "com.twitter.android" "x" "bundle_extract" "universal" "120-640dpi" "Android 9.0+"
    split_editor "x" "x"
    patch "x" "piko" "morphe"
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
morphe-youtube() {
	morphe_dl
	# Patch YouTube:
	get_patches_key "youtube-morphe"
	get_apk "com.google.android.youtube" "youtube" "apk"
	patch "youtube" "morphe" "morphe"

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
	morphe-youtube)
		morphe-youtube
		;;
	
esac