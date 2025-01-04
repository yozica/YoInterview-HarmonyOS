import type { QuestionType } from "../../../models";
import { QuestionListComp } from '../../../commons/components';
import request from '../../../commons/utils/request'

@Component
struct HomeCategory {
  @State activeIndex: number = 0;
  @State questionTypeList: QuestionType[] = [];

  aboutToAppear(): void {
    this.getQuestionTypeList();
  }

  async getQuestionTypeList() {
    const res = await request<QuestionType[]>({
      url: "/question/type",
    });
    this.questionTypeList = [...res];
  }

  @Builder
  tabbarBuilder(questionType: QuestionType, index: number) {
    Row({ space: 4 }) {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(questionType.name)
          .fontSize(15)
          .height(44)
          .fontColor(this.activeIndex === index ? $r('app.color.black') : $r('app.color.common_gray_02'))
        Text()
          .width(this.activeIndex === index ? 20 : 0)
          .animation({ duration: 300 })
          .height(2)
          .backgroundColor($r('app.color.black'))
      }

      if (questionType.displayNewestFlag) {
        Image($r('app.media.ic_home_new'))
          .width(32)
          .height(14)
          .objectFit(ImageFit.Contain)
          .margin({ left: 4 })
      }
    }
    .padding({ left: 16, right: index === this.questionTypeList.length - 1 ? 16 : 0 })
  }

  build() {
    Column() {
      Tabs({ index: $$this.activeIndex }) {
        ForEach(this.questionTypeList, (questionType: QuestionType, index) => {
          TabContent() {
            QuestionListComp({ typeId: questionType.id })
          }
          .tabBar(this.tabbarBuilder(questionType, index))
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