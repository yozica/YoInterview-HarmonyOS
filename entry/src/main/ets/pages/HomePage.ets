import { YoSearchBox, YoClockIn } from "../commons/components"

@Component
struct HomePage {
  @StorageProp('topArea') topArea: number = 0
  @State
  swiperList: Resource[] = [
    $r('app.media.banner_qa'),
    $r('app.media.banner_pj'),
    $r('app.media.banner_ai'),
  ]

  @Builder
  SwiperItemBuilder(src: Resource) {
    Row() {
      Image(src)
        .width('100%')
        .aspectRatio(2.65)
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
  }

  build() {
    Column() {
      Row({ space: 16 }) {
        Image($r('app.media.ic_home_scan'))
          .width(24)
          .aspectRatio(1)
        YoSearchBox({ layoutWeightValue: 1 })
        YoClockIn()
      }
      .padding({ left: 16, right: 16 })
      .width('100%')
      .height(64)

      Swiper() {
        ForEach(this.swiperList, (item: Resource) => {
          this.SwiperItemBuilder(item)
        })
      }
      .autoPlay(true)
      .indicator(DotIndicator.dot().selectedColor($r('app.color.white')))
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .padding({ top: this.topArea })
    .backgroundColor($r('app.color.common_gray_bg'))
  }
}

export default HomePage;