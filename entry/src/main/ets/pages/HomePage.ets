import { YoSearchBox } from "../commons/components"

@Component
struct HomePage {
  @StorageProp('topArea') topArea: number = 0

  build() {
    Column() {
      Row({ space: 16 }) {
        Image($r('app.media.ic_home_scan'))
          .width(24)
          .aspectRatio(1)
        YoSearchBox({ layoutWeightValue: 1 })
      }
      .padding({ left: 16, right: 16 })
      .width('100%')
      .height(64)
    }
    .width('100%')
    .height('100%')
    .padding({ top: this.topArea })
    .backgroundColor($r('app.color.common_gray_bg'))
  }
}

export default HomePage;