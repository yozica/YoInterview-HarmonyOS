import { YoTag } from "..";
import { QuestionItem, TempObject } from "../../../models";


@Component
struct QuestionItemComp {
  @Require @Prop item: QuestionItem;

  build() {
    Column({ space: 10 }) {
      Row({ space: 5 }) {
        YoTag({ difficulty: this.item.difficulty })
        Text(this.item.stem)
          .fontSize(15)
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontWeight(500)
      }
      .width('100%')

      RowSplit() {
        Text('点赞 ' + this.item.likeCount)
          .grayText({ isStart: true })
        Text('浏览 ' + this.item.views)
          .grayText()
        if (this.item.readFlag) {
          Text('已看过').grayText()
        }
      }
    }
    .padding({ left: 16, right: 16 })
    .width('100%')
    .height(80)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
  }
}

export default QuestionItemComp;

interface GrayTextOption {
  isStart?: boolean
}

@Extend(Text)
function grayText(option?: GrayTextOption) {
  .fontSize(13)
  .height(13)
  .lineHeight(13)
  .fontColor($r('app.color.common_gray_01'))
  .margin({ left: (option && option.isStart) ? 0 : 16, right: 16 })
}
