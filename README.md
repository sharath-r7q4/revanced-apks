## How does this repository work?
Just use [GitHub Releases](https://github.com/sharath-r7q4/revanced-apks/releases) to find Apps

> [!NOTE]
> If you want to use the YouTube, YouTube Music or Google Photos app, you need to download and install [MicroG RE](https://github.com/MorpheApp/MicroG-RE)
> 
> If you are an advanced user and you want to use custom patches for patching revanced apps, you should read the [Wiki](../main/docs/Frequently%20Asked%20Questions.md#q-how-do-i-use-this-repository-for-patching-my-own-app).
> 
> This repository is not like any other repository. It does not create new releases; it only releases new files.
> 
> All the code is open-source, clearly, and the APK files used for patching are downloaded from a trusted site, so it is totally safe for you to use.
---
## Based on https://github.com/FiorenMas/Revanced-And-Revanced-Extended-Non-Root for revanced but slightly modified and specialised.

## Added custom manifest patches and LSPatch

### Notable Modifications to revanced part
- Replaced hardcoded keystore with keystore stored in secrets.
- Moved patches Sstuff from seperate files into a single file.
- Dedicated release for each apps with logs
- Added suport for Archive.org apk repositories
## Patched Apps
- YouTube (Morphe)
- X (piko)
- Instagram (piko)
- Prime Video (hoo-dles)
- Proton VPN (hoo-dles)
### Custom patches
- Eden Nightly (PUBG Spoof) [Original](https://eden-emu.dev)
- Dolphin Emulator (SDK 29 no scoped storage) [Original](https://dolphin-emu.org)
- Fold Craft Launcher (CoD spoof) [Original](https://github.com/FCL-Team/FoldCraftLauncher)
- Geode (PUBG KR Spoof) [Original](https://github.com/geode-sdk/android-launcher)
### Xposed patches 
- Discord (Revenge)
## Actively Used Libraries

### Morphe

[Patches](https://github.com/MorpheApp/morphe-patches) - [GPL-3.0](https://github.com/MorpheApp/morphe-patches/blob/main/LICENSE)

[CLI](https://github.com/MorpheApp/morphe-cli) - [GPL-3.0](https://github.com/MorpheApp/morphe-cli/blob/main/LICENSE)

[MicroG RE](https://github.com/MorpheApp/MicroG-RE) - [Apache-2.0](https://github.com/MorpheApp/MicroG-RE/blob/main/LICENSE)

### Crimera

[Patches](https://github.com/crimera/piko) - [GPL-3.0](https://github.com/crimera/piko/blob/main/LICENSE)


### hoo-dles
[Patches](https://github.com/hoo-dles/morphe-patches) - [GPL-3.0](https://github.com/hoo-dles/morphe-patches/blob/main/LICENSE)

### Standalone

[pup](https://github.com/ericchiang/pup) - [MIT](https://github.com/ericchiang/pup/blob/master/LICENSE)

[All Architectures](../../releases/download/all/tumblr-derevanced.apk)

[Arm64-v8a](../../releases/download/all/tumblr-arm64-v8a-derevanced.apk)

### Xposed

[LSPatch](https://github.com/JingMatrix/LSPatch) - [GPL-3.0](https://github.com/JingMatrix/LSPatch/blob/main/LICENSE)

### Revenge
Code inspired from [Manager](https://github.com/revenge-mod/revenge-manager) - [OSL-3.0](https://github.com/revenge-mod/revenge-manager/blob/main/LICENSE)

Actual Module [Xposed](https://github.com/revenge-mod/revenge-xposed) - [OSL-3.0](https://github.com/revenge-mod/revenge-manager/blob/main/LICENSE)

### Dormant Libraries, resources using in this repository:

<details>
  <summary>Revanced</summary>

[Patches](https://github.com/revanced/revanced-patches) - [GPL-3.0](https://github.com/revanced/revanced-patches/blob/main/LICENSE)

[Integrations](https://github.com/revanced/revanced-integrations) - [GPL-3.0](https://github.com/revanced/revanced-integrations/blob/main/LICENSE)

[CLI](https://github.com/revanced/revanced-cli) - [GPL-3.0](https://github.com/revanced/revanced-cli/blob/main/LICENSE)

[GmsCore](https://github.com/ReVanced/GmsCore) - [GPL-3.0](https://github.com/revanced/revanced-cli/blob/main/LICENSE)

</details>

<details>
  <summary>inotia00</summary>

[Patches](https://github.com/inotia00/revanced-patches) - [GPL-3.0](https://github.com/inotia00/revanced-patches/blob/revanced-extended/LICENSE)

[Patches arsclib](https://github.com/inotia00/revanced-patches-arsclib) - [GPL-3.0](https://github.com/inotia00/revanced-patches-arsclib/blob/arsclib-old/LICENSE)

[Integrations](https://github.com/inotia00/revanced-integrations) - [GPL-3.0](https://github.com/inotia00/revanced-integrations/blob/main/LICENSE)

[CLI](https://github.com/inotia00/revanced-cli) - [GPL-3.0](https://github.com/inotia00/revanced-cli/blob/main/LICENSE)

[CLI arsclib](https://github.com/inotia00/revanced-cli-arsclib) - [GPL-3.0](https://github.com/inotia00/revanced-cli-arsclib/blob/arsclib-old/LICENSE)

</details>

<details>
  <summary>anddea</summary>

[Patches](https://github.com/anddea/revanced-patches) - [GPL-3.0](https://github.com/anddea/revanced-patches/blob/main/LICENSE)

[Integrations](https://github.com/anddea/revanced-integrations) - [GPL-3.0](https://github.com/anddea/revanced-integrations/blob/main/LICENSE)

</details>

</details>


<details>
  <summary>kitadai31</summary>

[Patches](https://github.com/kitadai31/revanced-patches-android6-7) - [GPL-3.0](https://github.com/kitadai31/revanced-patches-android6-7/blob/revanced-extended/LICENSE)

[Integrations](https://github.com/kitadai31/revanced-integrations) - [GPL-3.0](https://github.com/kitadai31/revanced-integrations/blob/revanced-extended/LICENSE)

</details>

<details>
  <summary>d4n3436</summary>

[Patches](https://github.com/d4n3436/revanced-patches-android5) - [GPL-3.0](https://github.com/d4n3436/revanced-patches-android5/blob/revanced-extended/LICENSE)

[Integrations](https://github.com/d4n3436/revanced-integrations) - [GPL-3.0](https://github.com/d4n3436/revanced-integrations/blob/revanced-extended/LICENSE)

</details>

<details>
  <summary>BiliRoamingM</summary>

[Patches & Integrations](https://github.com/sakarie9/BiliRoamingM) - [GPL-3.0](https://github.com/sakarie9/BiliRoamingM/blob/main/LICENSE)

</details>

<details>
  <summary>indrastorms</summary>

[Patches](https://github.com/indrastorms/Dropped-Patches) - [GPL-3.0](https://github.com/indrastorms/Dropped-Patches/blob/main/LICENSE)

</details>

<details>
  <summary>Aunali321</summary>

[Patches](https://github.com/Aunali321/ReVancedExperiments) - [GPL-3.0](https://github.com/Aunali321/ReVancedExperiments/blob/main/LICENSE)

</details>

<details>
  <summary>scrazzz</summary>

[Patches](https://github.com/scrazzz/my-revanced-patches) - [GPL-3.0](https://github.com/scrazzz/my-revanced-patches/blob/main/LICENSE)

</details>

<details>
  <summary>RookieEnough</summary>

[Patches](https://github.com/RookieEnough/De-ReVanced) - [GPL-3.0](https://github.com/RookieEnough/De-ReVanced/blob/main/LICENSE)

</details>

<details>
  <summary>Paresh Maheshwari</summary>

[Patches](https://github.com/Paresh-Maheshwari/paresh-patches) - [GPL-3.0](https://github.com/Paresh-Maheshwari/paresh-patches/blob/main/LICENSE)

</details>


---

## Inspired by:

[@luxysiv](https://github.com/luxysiv/yt-revanced-nonroot) - [GPL-3.0](https://github.com/luxysiv/revanced-nonroot/blob/main/LICENSE)

[revanced-build-template](https://github.com/n0k0m3/revanced-build-template) - [GPL-3.0](https://github.com/n0k0m3/revanced-build-template/blob/main/LICENSE)

[revanced-magisk-module](https://github.com/j-hc/revanced-magisk-module) - [GPL-3.0](https://github.com/j-hc/revanced-magisk-module/blob/main/LICENSE)(previously based on, now archived old repo)

## See also:
[Levilaunchroid Crack+BGMI Spoof](https://github.com/sharath-r7q4/LeviLaunchroid) Now included in releases - [Apache-2.0](https://github.com/sharath-r7q4/LeviLaunchroid/blob/main/LICENSE)
