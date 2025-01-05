import { router } from "@kit.ArkUI";

@Component
struct YoNavBar {
  @StorageProp('topArea')
  topArea: number = 0;
  /** 导航栏标题 */
  @Prop title: string = "";
  /** 是否有下边框 */
  @Prop showBorder: boolean = false;
  /** 左侧图标 */
  @Prop leftIcon: ResourceStr = $r('app.media.ic_common_back');
  /** 右侧图标 */
  @Prop rightIcon: ResourceStr = $r('sys.media.ohos_ic_public_more');
  /** 是否显示右侧图标 */
  @Prop showRightIcon: boolean = false;

  build() {
    Row({ space: 16 }) {
      Image(this.leftIcon)
        .size({ width: 24, height: 24 })
        .fillColor($r('app.color.black'))
        .onClick(() => router.back())
      Row() {
        if (this.title) {
          Text(this.title)
            .fontSize(18)
            .fontWeight(600)
            .textAlign(TextAlign.Center)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
        }
      }
      .height(56)
      .layoutWeight(1)

      if (this.showRightIcon) {
        Image(this.rightIcon)
          .size({ width: 24, height: 24 })
          .objectFit(ImageFit.Contain)
      } else {
        Blank()
          .width(24)
      }
    }
    .width('100%')
    .height(56 + this.topArea)
    .padding({ left: 16, right: 16, top: this.topArea })
    .border({
      width: { bottom: this.showBorder ? 0.5 : 0 },
      color: $r('app.color.common_gray_bg')
    })
  }
}

export default YoNavBar;