@Component
struct YoSearchBox {
  @Prop widthValue: number = 100
  @Prop heightValue: number = 32
  @Prop bgColor: ResourceColor = $r('app.color.common_gray_border')
  @Prop placeholder: string = "搜索题目"
  @Prop placeholderColor: ResourceColor = $r('app.color.common_gray_02')
  @Prop layoutWeightValue: number = 0
  @Prop fontSize: number = 14

  build() {
    Row() {
      Image($r('app.media.ic_common_search'))
        .width(this.fontSize)
        .aspectRatio(1)
        .fillColor(this.placeholderColor)
      Text(this.placeholder)
        .fontSize(this.fontSize)
        .fontColor(this.placeholderColor)
    }
    .width(this.widthValue)
    .height(this.heightValue)
    .backgroundColor(this.bgColor)
    .borderRadius(this.heightValue / 2)
    .layoutWeight(this.layoutWeightValue)
    .justifyContent(FlexAlign.Center)
  }
}

export default YoSearchBox;