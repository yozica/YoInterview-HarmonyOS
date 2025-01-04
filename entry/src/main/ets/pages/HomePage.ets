@Component
struct HomePage {
  @StorageProp('topArea') topArea: number = 0

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_home_scan'))
          .width(24)
          .aspectRatio(1)
      }
      .padding({ left: 16, right: 16 })
      .width('100%')
      .height(64)
    }
    .width('100%')
    .height('100%')
    .padding({ top: this.topArea })
    .backgroundColor($r('app.color.home_gray'))
  }
}

export default HomePage;