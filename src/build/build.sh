#!/bin/bash
#CI build
source ./src/build/utils.sh

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
hoo-dles-protonvpn() {
	hoo-dles_dl
	#Patch Proton VPN
	get_patches_key "Proton-VPN-hoo-dles"
	get_apk "ch.protonvpn.android" "protonvpn" "apk"
	patch "protonvpn" "hoo-dles" "morphe"
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
	get_patches_key "youtube-morphe"
	get_apk "com.google.android.youtube" "youtube" "apk"
	patch "youtube" "morphe" "morphe"
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
	hoo-dles-protonvpn)
		hoo-dles-protonvpn
		;;
	morphe-youtube)
		morphe-youtube
		;;
	binarymend-sympfonium)
		binarymend-sympfonium
		;;
	
esac
