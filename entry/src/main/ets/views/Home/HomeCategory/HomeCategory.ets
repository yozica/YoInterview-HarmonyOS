import { YoTag } from "../../../commons/components"
import type { QuestionType } from "../../../models"

@Component
struct HomeCategory {
  @State activeIndex: number = 0
  @State questionList: QuestionType[] = [
    { id: 1, name: 'ArkTS', displayNewestFlag: 0 },
    { id: 2, name: 'ArkUI', displayNewestFlag: 1 },
    { id: 3, name: 'Hap', displayNewestFlag: 1 },
    { id: 4, name: 'Hsp', displayNewestFlag: 0 },
    { id: 5, name: 'Har', displayNewestFlag: 0 },
    { id: 6, name: 'Ability', displayNewestFlag: 0 },
    { id: 7, name: 'Stage', displayNewestFlag: 0 },
    { id: 8, name: 'Kit', displayNewestFlag: 0 }
  ]

  @Builder
  tabbarBuilder(question: QuestionType, index: number) {
    Row({ space: 4 }) {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(question.name)
          .fontSize(15)
          .height(44)
          .fontColor(this.activeIndex === index ? $r('app.color.black') : $r('app.color.common_gray_02'))
        Text()
          .width(this.activeIndex === index ? 20 : 0)
          .animation({ duration: 300 })
          .height(2)
          .backgroundColor($r('app.color.black'))
      }

      if (question.displayNewestFlag) {
        Image($r('app.media.ic_home_new'))
          .width(32)
          .height(14)
          .objectFit(ImageFit.Contain)
          .margin({ left: 4 })
      }
    }
    .padding({ left: 16, right: index === this.questionList.length - 1 ? 16 : 0 })
  }

  build() {
    Column() {
      Tabs({ index: $$this.activeIndex }) {
        ForEach(this.questionList, (question: QuestionType, index) => {
          TabContent() {
            Column() {
              YoTag({ difficulty: 1 })
              YoTag({ difficulty: 2 })
              YoTag({ difficulty: 3 })
              YoTag({ difficulty: 4 })
              YoTag({ difficulty: 5 })
              YoTag({ text: "测试", color: Color.Red })
            }
          }
          .tabBar(this.tabbarBuilder(question, index))
        })
      }
      .scrollable(true)
      .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_border') })
      .barMode(BarMode.Scrollable)
    }
    .width('100%')
    .layoutWeight(1)
    .backgroundColor($r('app.color.white'))
  }
}

export default HomeCategory;