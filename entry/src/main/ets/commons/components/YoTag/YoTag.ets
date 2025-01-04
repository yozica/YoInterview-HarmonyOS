type Level = 1 | 2 | 3 | 4 | 5;

interface YoTagInfo {
  text: string;
  color: ResourceStr;
}

const infoMap: Record<Level, YoTagInfo> = {
  1: { text: '简单', color: $r('app.color.common_green') },
  2: { text: '简单', color: $r('app.color.common_green') },
  3: { text: '一般', color: $r('app.color.common_blue') },
  4: { text: '一般', color: $r('app.color.common_blue') },
  5: { text: '困难', color: $r('app.color.common_main_color') },
}

@Component
struct YoTag {
  @Prop difficulty: Level = 1;
  @Prop text: string;
  @Prop color: ResourceColor;

  build() {
    Text(this.text || infoMap[this.difficulty].text)
      .fontColor(this.color || infoMap[this.difficulty].color)
      .fontSize(10)
      .padding({ left: 6, right: 6 })
      .height(18)
      .lineHeight(18)
      .textAlign(TextAlign.Center)
      .constraintSize({ minWidth: 34 })
      .borderRadius(2)
  }
}

export default YoTag;