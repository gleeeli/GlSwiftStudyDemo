#!/bin/sh
set -e
set -u
set -o pipefail

function on_error {
  echo "$(realpath -mq "${0}"):$1: error: Unexpected failure"
}
trap 'on_error $LINENO' ERR

if [ -z ${UNLOCALIZED_RESOURCES_FOLDER_PATH+x} ]; then
  # If UNLOCALIZED_RESOURCES_FOLDER_PATH is not set, then there's nowhere for us to copy
  # resources to, so exit 0 (signalling the script phase was successful).
  exit 0
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

# This protects against multiple targets copying the same framework dependency at the same time. The solution
# was originally proposed here: https://lists.samba.org/archive/rsync/2008-February/020158.html
RSYNC_PROTECT_TMP_FILES=(--filter "P .*.??????")

case "${TARGETED_DEVICE_FAMILY:-}" in
  1,2)
    TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
    ;;
  1)
    TARGET_DEVICE_ARGS="--target-device iphone"
    ;;
  2)
    TARGET_DEVICE_ARGS="--target-device ipad"
    ;;
  3)
    TARGET_DEVICE_ARGS="--target-device tv"
    ;;
  4)
    TARGET_DEVICE_ARGS="--target-device watch"
    ;;
  *)
    TARGET_DEVICE_ARGS="--target-device mac"
    ;;
esac

install_resource()
{
  if [[ "$1" = /* ]] ; then
    RESOURCE_PATH="$1"
  else
    RESOURCE_PATH="${PODS_ROOT}/$1"
  fi
  if [[ ! -e "$RESOURCE_PATH" ]] ; then
    cat << EOM
error: Resource "$RESOURCE_PATH" not found. Run 'pod install' to update the copy resources script.
EOM
    exit 1
  fi
  case $RESOURCE_PATH in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .storyboard`.storyboardc" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.xib)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile ${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib $RESOURCE_PATH --sdk ${SDKROOT} ${TARGET_DEVICE_ARGS}" || true
      ibtool --reference-external-strings-file --errors --warnings --notices --minimum-deployment-target ${!DEPLOYMENT_TARGET_SETTING_NAME} --output-format human-readable-text --compile "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$RESOURCE_PATH\" .xib`.nib" "$RESOURCE_PATH" --sdk "${SDKROOT}" ${TARGET_DEVICE_ARGS}
      ;;
    *.framework)
      echo "mkdir -p ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      mkdir -p "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" $RESOURCE_PATH ${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}" || true
      rsync --delete -av "${RSYNC_PROTECT_TMP_FILES[@]}" "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH"`.mom\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd\"" || true
      xcrun momc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"$RESOURCE_PATH\" \"${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm\"" || true
      xcrun mapc "$RESOURCE_PATH" "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$RESOURCE_PATH" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE="$RESOURCE_PATH"
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    *)
      echo "$RESOURCE_PATH" || true
      echo "$RESOURCE_PATH" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pm_post_detail_right_arrow.imageset/pm_post_detail_right_arrow@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pm_post_detail_right_arrow.imageset/pm_post_detail_right_arrow@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pp_comm_bg_image.imageset/pp_comm_bg_image@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pp_comm_bg_image.imageset/pp_comm_bg_image@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pp_shangqiang_tip_logo.imageset/pp_shangqiang_tip_logo@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pp_shangqiang_tip_logo.imageset/pp_shangqiang_tip_logo@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Spec/pp_comm_btn_c4c4c4.imageset/pp_comm_btn_c4c4c4@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Spec/pp_comm_btn_c4c4c4.imageset/pp_comm_btn_c4c4c4@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_disable_dark.imageset/pp_theme_btn_bg_disable_dark@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_disable_dark.imageset/pp_theme_btn_bg_disable_dark@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_disable_dark_small.imageset/pp_theme_btn_bg_disable_dark_small@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_disable_dark_small.imageset/pp_theme_btn_bg_disable_dark_small@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_normal_dark.imageset/lm_login_bg_normal@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_normal_dark.imageset/lm_login_bg_normal@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_disable.imageset/pp_theme_btn_bg_disable@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_disable.imageset/pp_theme_btn_bg_disable@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_normal.imageset/pp_theme_btn_bg_normal@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_normal.imageset/pp_theme_btn_bg_normal@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_press.imageset/pp_theme_btn_press@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_press.imageset/pp_theme_btn_press@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/decorate_avater_icon.imageset/decorate_avater_icon@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat.imageset/好感度@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat.imageset/好感度@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat_border.imageset/heartbeat_border@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat_border.imageset/heartbeat_border@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat_border_b.imageset/heartbeat_border_b@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat_border_b.imageset/heartbeat_border_b@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/icon_close_line.imageset/icon_close_line@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/icon_close_line.imageset/icon_close_line@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/icon_close_line_dark.imageset/icon_close_line_dark@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/icon_close_line_dark.imageset/icon_close_line_dark@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/indicator/mc_indicator_down.imageset/mc_indicator_down@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/indicator/mc_indicator_down.imageset/mc_indicator_down@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/indicator/mc_indicator_right.imageset/mc_indicator_right@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/indicator/mc_indicator_right.imageset/mc_indicator_right@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/mc_friend_empty.imageset/mc_friend_empty@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/mc_friend_empty.imageset/mc_friend_empty@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_black_l.imageset/mood_bg_black_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_black_l.imageset/mood_bg_black_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_black_r.imageset/mood_bg_black_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_black_r.imageset/mood_bg_black_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_blue_l.imageset/mood_bg_blue_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_blue_l.imageset/mood_bg_blue_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_blue_r.imageset/mood_bg_blue_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_blue_r.imageset/mood_bg_blue_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_green_l.imageset/mood_bg_green_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_green_l.imageset/mood_bg_green_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_green_r.imageset/mood_bg_green_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_green_r.imageset/mood_bg_green_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_orange_l.imageset/mood_bg_orange_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_orange_l.imageset/mood_bg_orange_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_orange_r.imageset/mood_bg_orange_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_orange_r.imageset/mood_bg_orange_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_yellow_l.imageset/mood_bg_yellow_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_yellow_l.imageset/mood_bg_yellow_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_yellow_r.imageset/mood_bg_yellow_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_yellow_r.imageset/mood_bg_yellow_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_close.imageset/mood_close@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_close.imageset/mood_close@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_color_hint.imageset/mood_color_hint@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_color_hint.imageset/mood_color_hint@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_color_icon.imageset/mood_color_icon@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_color_icon.imageset/mood_color_icon@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_normal_gray.imageset/mood_normal_gray@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_normal_gray.imageset/mood_normal_gray@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_normal_green.imageset/mood_normal_green@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_normal_green.imageset/mood_normal_green@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_select.imageset/mood_select@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_select.imageset/mood_select@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/cm_img_my.imageset/cm_img_my@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/cm_img_my.imageset/cm_img_my@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/cm_img_other.imageset/cm_img_other@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/cm_img_other.imageset/cm_img_other@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_bitch.imageset/mood_emoji_bitch@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_bitch.imageset/mood_emoji_bitch@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_cry.imageset/mood_emoji_cry@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_cry.imageset/mood_emoji_cry@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_dog.imageset/mood_emoji_dog@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_dog.imageset/mood_emoji_dog@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_doubt.imageset/mood_emoji_doubt@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_doubt.imageset/mood_emoji_doubt@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_exhausted.imageset/mood_emoji_exhausted@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_exhausted.imageset/mood_emoji_exhausted@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_happy.imageset/mood_emoji_happy@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_happy.imageset/mood_emoji_happy@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_heartbeat.imageset/mood_emoji_heartbeat@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_heartbeat.imageset/mood_emoji_heartbeat@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_panic.imageset/mood_emoji_panic@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_panic.imageset/mood_emoji_panic@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_restless.imageset/mood_emoji_restless@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_restless.imageset/mood_emoji_restless@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_split.imageset/mood_emoji_split@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_split.imageset/mood_emoji_split@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_default_user_avatar.imageset/pp_default_user_avatar@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_default_user_avatar.imageset/pp_default_user_avatar@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_grirate_add_icon.imageset/pp_grirate_add_ionc@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_grirate_add_icon.imageset/pp_grirate_add_ionc@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_more_white_btn.imageset/pp_more_white_btn@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_more_white_btn.imageset/pp_more_white_btn@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_ok_btn.imageset/pp_ok_btn@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_ok_btn.imageset/pp_ok_btn@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/script_sence_title_love.imageset/script_sence_title_love@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/script_sence_title_love.imageset/script_sence_title_love@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/teenagers.imageset/teenagers@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/teenagers.imageset/teenagers@3x.png"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/PPUIKit/PPUIKit.bundle"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/PPUIKit/PPUIKitAsset.bundle"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/XHBFrame/XHBFrameLocalizable.bundle"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/XHBFrame/XHBRefresh.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBLocationCenter/region.db"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBMagnifyImageView/XHBMagnifyImageView.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBPhotoAlbum/XHBPhotoAlbum.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBToolAssistant/XHBToolAssistant.bundle"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/XHBTool/XHBToolLocalizable.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBVideoPlayer/XHBVideoPlayer.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBVideoPlayer/ZFPlayer/ZFPlayer.bundle"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pm_post_detail_right_arrow.imageset/pm_post_detail_right_arrow@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pm_post_detail_right_arrow.imageset/pm_post_detail_right_arrow@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pp_comm_bg_image.imageset/pp_comm_bg_image@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pp_comm_bg_image.imageset/pp_comm_bg_image@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pp_shangqiang_tip_logo.imageset/pp_shangqiang_tip_logo@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Comm/pp_shangqiang_tip_logo.imageset/pp_shangqiang_tip_logo@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Spec/pp_comm_btn_c4c4c4.imageset/pp_comm_btn_c4c4c4@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Spec/pp_comm_btn_c4c4c4.imageset/pp_comm_btn_c4c4c4@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_disable_dark.imageset/pp_theme_btn_bg_disable_dark@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_disable_dark.imageset/pp_theme_btn_bg_disable_dark@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_disable_dark_small.imageset/pp_theme_btn_bg_disable_dark_small@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_disable_dark_small.imageset/pp_theme_btn_bg_disable_dark_small@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_normal_dark.imageset/lm_login_bg_normal@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/Dark/pp_theme_btn_bg_normal_dark.imageset/lm_login_bg_normal@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_disable.imageset/pp_theme_btn_bg_disable@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_disable.imageset/pp_theme_btn_bg_disable@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_normal.imageset/pp_theme_btn_bg_normal@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_normal.imageset/pp_theme_btn_bg_normal@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_press.imageset/pp_theme_btn_press@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/CommBtn/Theme/pp_theme_btn_bg_press.imageset/pp_theme_btn_press@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/decorate_avater_icon.imageset/decorate_avater_icon@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat.imageset/好感度@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat.imageset/好感度@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat_border.imageset/heartbeat_border@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat_border.imageset/heartbeat_border@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat_border_b.imageset/heartbeat_border_b@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/headBeat/heartbeat_border_b.imageset/heartbeat_border_b@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/icon_close_line.imageset/icon_close_line@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/icon_close_line.imageset/icon_close_line@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/icon_close_line_dark.imageset/icon_close_line_dark@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/icon_close_line_dark.imageset/icon_close_line_dark@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/indicator/mc_indicator_down.imageset/mc_indicator_down@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/indicator/mc_indicator_down.imageset/mc_indicator_down@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/indicator/mc_indicator_right.imageset/mc_indicator_right@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/indicator/mc_indicator_right.imageset/mc_indicator_right@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/mc_friend_empty.imageset/mc_friend_empty@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/mc_friend_empty.imageset/mc_friend_empty@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_black_l.imageset/mood_bg_black_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_black_l.imageset/mood_bg_black_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_black_r.imageset/mood_bg_black_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_black_r.imageset/mood_bg_black_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_blue_l.imageset/mood_bg_blue_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_blue_l.imageset/mood_bg_blue_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_blue_r.imageset/mood_bg_blue_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_blue_r.imageset/mood_bg_blue_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_green_l.imageset/mood_bg_green_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_green_l.imageset/mood_bg_green_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_green_r.imageset/mood_bg_green_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_green_r.imageset/mood_bg_green_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_orange_l.imageset/mood_bg_orange_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_orange_l.imageset/mood_bg_orange_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_orange_r.imageset/mood_bg_orange_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_orange_r.imageset/mood_bg_orange_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_yellow_l.imageset/mood_bg_yellow_l@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_yellow_l.imageset/mood_bg_yellow_l@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_yellow_r.imageset/mood_bg_yellow_r@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_bg_yellow_r.imageset/mood_bg_yellow_r@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_close.imageset/mood_close@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_close.imageset/mood_close@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_color_hint.imageset/mood_color_hint@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_color_hint.imageset/mood_color_hint@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_color_icon.imageset/mood_color_icon@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_color_icon.imageset/mood_color_icon@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_normal_gray.imageset/mood_normal_gray@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_normal_gray.imageset/mood_normal_gray@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_normal_green.imageset/mood_normal_green@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_normal_green.imageset/mood_normal_green@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_select.imageset/mood_select@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/mood_select.imageset/mood_select@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/cm_img_my.imageset/cm_img_my@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/cm_img_my.imageset/cm_img_my@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/cm_img_other.imageset/cm_img_other@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/cm_img_other.imageset/cm_img_other@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_bitch.imageset/mood_emoji_bitch@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_bitch.imageset/mood_emoji_bitch@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_cry.imageset/mood_emoji_cry@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_cry.imageset/mood_emoji_cry@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_dog.imageset/mood_emoji_dog@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_dog.imageset/mood_emoji_dog@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_doubt.imageset/mood_emoji_doubt@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_doubt.imageset/mood_emoji_doubt@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_exhausted.imageset/mood_emoji_exhausted@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_exhausted.imageset/mood_emoji_exhausted@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_happy.imageset/mood_emoji_happy@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_happy.imageset/mood_emoji_happy@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_heartbeat.imageset/mood_emoji_heartbeat@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_heartbeat.imageset/mood_emoji_heartbeat@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_panic.imageset/mood_emoji_panic@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_panic.imageset/mood_emoji_panic@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_restless.imageset/mood_emoji_restless@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_restless.imageset/mood_emoji_restless@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_split.imageset/mood_emoji_split@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/Mood/形状/mood_emoji_split.imageset/mood_emoji_split@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_default_user_avatar.imageset/pp_default_user_avatar@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_default_user_avatar.imageset/pp_default_user_avatar@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_grirate_add_icon.imageset/pp_grirate_add_ionc@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_grirate_add_icon.imageset/pp_grirate_add_ionc@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_more_white_btn.imageset/pp_more_white_btn@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_more_white_btn.imageset/pp_more_white_btn@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_ok_btn.imageset/pp_ok_btn@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/pp_ok_btn.imageset/pp_ok_btn@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/script_sence_title_love.imageset/script_sence_title_love@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/script_sence_title_love.imageset/script_sence_title_love@3x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/teenagers.imageset/teenagers@2x.png"
  install_resource "${PODS_ROOT}/../Module/PPUIKit/PPUIKit/Resource/Media.xcassets/teenagers.imageset/teenagers@3x.png"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/PPUIKit/PPUIKit.bundle"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/PPUIKit/PPUIKitAsset.bundle"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/XHBFrame/XHBFrameLocalizable.bundle"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/XHBFrame/XHBRefresh.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBLocationCenter/region.db"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBMagnifyImageView/XHBMagnifyImageView.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBPhotoAlbum/XHBPhotoAlbum.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBToolAssistant/XHBToolAssistant.bundle"
  install_resource "${PODS_CONFIGURATION_BUILD_DIR}/XHBTool/XHBToolLocalizable.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBVideoPlayer/XHBVideoPlayer.bundle"
  install_resource "${PODS_ROOT}/XHBTool/XHBTool/XHBVideoPlayer/ZFPlayer/ZFPlayer.bundle"
fi

mkdir -p "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]] && [[ "${SKIP_INSTALL}" == "NO" ]]; then
  mkdir -p "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "${XCASSET_FILES:-}" ]
then
  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find -L "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "${PODS_ROOT}*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  if [ -z ${ASSETCATALOG_COMPILER_APPICON_NAME+x} ]; then
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
  else
    printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${TARGET_TEMP_DIR}/assetcatalog_generated_info_cocoapods.plist"
  fi
fi
