import { QuestionType, SortType } from "../../../models";
import { QuestionListComp, YoSkeleton, YoSkeletonItem } from '../../../commons/components';
import request from '../../../commons/utils/request';
import { FilterButton } from './components';
import { LengthMetrics, LengthUnit } from "@kit.ArkUI";
import { emitter } from "@kit.BasicServicesKit";
import { LOGIN_EVENT_NAME } from "../../../commons/contants";

@Extend(Text)
function textTitle() {
  .fontSize(14)
  .fontWeight(500)
  .fontColor($r('app.color.black'))
  .width('100%')
  .margin({ top: 20, bottom: 12 })
}

const gapLength = (value: number) => new LengthMetrics(value, LengthUnit.VP);

@Component
struct HomeCategory {
  @State activeIndex: number = 0;
  @State targetIndex: number = 0;
  @State sort: SortType = SortType.Default;
  @State loading: boolean = false;
  @State questionTypeList: QuestionType[] = [];
  @State sheetShow: boolean = false;
  // 筛选sheet所需的状态
  @State filterDataSort: SortType = SortType.Default;
  @State filterDataIndex: number = 0;

  aboutToAppear(): void {
    this.getQuestionTypeList();
    emitter.on(LOGIN_EVENT_NAME, () => {
      this.getQuestionTypeList();
    })
  }

  async getQuestionTypeList() {
    this.loading = true;
    try {
      const res = await request<QuestionType[]>({
        url: "/question/type",
      });
      this.questionTypeList = [...res];
    } catch {
    }
    this.loading = false;
  }

  @Builder
  tabbarBuilder(questionType: QuestionType, index: number) {
    Row({ space: 4 }) {
      Stack({ alignContent: Alignment.Bottom }) {
        Text(questionType.name)
          .fontColor(this.targetIndex === index ? $r('app.color.black') : $r('app.color.common_gray_02'))
          .animation({ duration: 300 })
          .fontSize(15)
          .height(44)
        Text()
          .width(this.targetIndex === index ? 20 : 0)
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
    .padding({ left: 16, right: index === this.questionTypeList.length - 1 ? 56 : 0 })
  }

  @Builder
  filterSheetBuilder() {
    Column() {
      Row() {
        Text('重置')
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('app.color.common_gray_03'))
          .onClick(() => {
            this.filterDataIndex = 0;
            this.filterDataSort = SortType.Default;
          })
        Text('筛选题目')
          .fontSize(18)
          .fontWeight(500)
          .fontColor($r('app.color.black'))
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('完成')
          .fontSize(16)
          .fontWeight(500)
          .fontColor($r('app.color.common_main_color'))
          .onClick(() => {
            this.activeIndex = this.filterDataIndex;
            this.sort = this.filterDataSort;
            this.sheetShow = false;
          })
      }
      .margin({ top: 4, bottom: 4 })

      Text('题目排序').textTitle()
      Flex({
        wrap: FlexWrap.Wrap,
        space: { main: gapLength(10), cross: gapLength(10) }
      }) {
        FilterButton({
          text: '默认',
          selected: this.filterDataSort === SortType.Default,
          sort: this.filterDataSort
        })
          .onClick(() => {
            this.filterDataSort = SortType.Default;
          })
        FilterButton({
          text: '难度',
          selected:
          (this.filterDataSort === SortType.DifficultyLow) || (this.filterDataSort === SortType.DifficultyHigh),
          isSort: true,
          sort: this.filterDataSort
        })
          .onClick(() => {
            if (this.filterDataSort !== SortType.DifficultyLow) {
              this.filterDataSort = SortType.DifficultyLow;
            } else {
              this.filterDataSort = SortType.DifficultyHigh;
            }
          })
        FilterButton({
          text: '推荐',
          selected: this.filterDataSort === SortType.Commend,
          sort: this.filterDataSort
        })
          .onClick(() => {
            this.filterDataSort = SortType.Commend;
          })
        FilterButton({
          text: '浏览量',
          selected:
          (this.filterDataSort === SortType.ViewLow) || (this.filterDataSort === SortType.ViewHigh),
          isSort: true,
          sort: this.filterDataSort
        })
          .onClick(() => {
            if (this.filterDataSort !== SortType.ViewLow) {
              this.filterDataSort = SortType.ViewLow;
            } else {
              this.filterDataSort = SortType.ViewHigh;
            }
          })
      }

      Text('选择分类').textTitle()
      Flex({
        wrap: FlexWrap.Wrap,
        space: { main: gapLength(10), cross: gapLength(10) }
      }) {
        ForEach(this.questionTypeList, (item: QuestionType, index) => {
          FilterButton({
            text: item.name,
            isNew: item.displayNewestFlag === 1,
            selected: this.filterDataIndex === index
          })
            .onClick(() => {
              this.filterDataIndex = index;
            })
        })
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor($r('app.color.white'))
  }

  @Builder
  filterButtonBuilder() {
    Row() {
      Image($r('app.media.ic_home_filter'))
        .width(24)
        .aspectRatio(1)
        .onClick(() => {
          this.filterDataIndex = this.activeIndex;
          this.filterDataSort = this.sort;
          this.sheetShow = !this.sheetShow;
        })
    }
    .width(56)
    .height(55)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .linearGradient({
      angle: 90,
      colors: [['#00ffffff', 0], ['#ffffff', 0.285]]
    })
  }

  @Builder
  skeletonBuilder() {
    YoSkeleton() {
      Column() {
        Row({ space: 16 }) {
          YoSkeletonItem({ widthValue: 50 })
          YoSkeletonItem({ widthValue: 80 })
          YoSkeletonItem({ widthValue: 60 })
          YoSkeletonItem({ widthValue: 50 })
        }
        .width('100%')
        .height(44)

        ForEach(Array(5).fill(0), () => {
          Column({ space: 10 }) {
            YoSkeletonItem({ widthValue: '90%' })
            YoSkeletonItem({ widthValue: '50%' })
          }
          .width('100%')
          .height(80)
          .alignItems(HorizontalAlign.Start)
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      if (this.loading) {
        this.skeletonBuilder()
      } else {
        Tabs({ index: $$this.activeIndex }) {
          ForEach(this.questionTypeList, (questionType: QuestionType, index) => {
            TabContent() {
              QuestionListComp({
                typeId: questionType.id,
                sort: this.sort,
              })
            }
            .tabBar(this.tabbarBuilder(questionType, index))
          })
        }
        .scrollable(true)
        .divider({ strokeWidth: 0.5, color: $r('app.color.common_gray_border') })
        .barMode(BarMode.Scrollable)
        .onAnimationStart((_: number, target: number) => {
          this.targetIndex = target;
        })

        this.filterButtonBuilder()
      }
    }
    .width('100%')
    .layoutWeight(1)
    .backgroundColor($r('app.color.white'))
    .bindSheet($$this.sheetShow, this.filterSheetBuilder, {
      height: 400,
      showClose: false
    })
  }
}

export default HomeCategory;