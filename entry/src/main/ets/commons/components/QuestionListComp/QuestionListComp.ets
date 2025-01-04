import QuestionItemComp from '../QuestionItemComp/QuestionItemComp'

@Component
struct QuestionListComp {
  @Prop list: number[] = []
  @State isRefreshing: boolean = false;
  @State isLoading: boolean = false;
  @State isFinish: boolean = false;

  aboutToAppear(): void {
    this.list = Array(10).fill(0);
  }

  onRefresh() {
    setTimeout(() => {
      this.list = Array(10).fill(0);
      this.isRefreshing = false
    }, 3000)
  }

  onReachEnd() {
    if (this.isFinish || this.isLoading || this.isRefreshing) return
    this.isLoading = true
    setTimeout(() => {
      this.list = [...this.list, ...Array(10).fill(0)]
      if (this.list.length >= 40) {
        this.isFinish = true
      }
      this.isLoading = false
    }, 3000)
  }

  @Builder
  loadMoreBuilder() {
    ListItem() {
      if (this.isFinish) {
        Row() {
          Text('没有更多数据了')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_03'))
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      } else if (this.isLoading) {
        Row({ space: 6 }) {
          LoadingProgress()
            .width(20)
          Text('正在加载中...')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_03'))
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .height(80)
  }

  build() {
    Refresh({ refreshing: $$this.isRefreshing }) {
      List() {
        ForEach(this.list, (_: number) => {
          QuestionItemComp({
            item: {
              id: '100',
              stem: "请说下ArkUI的容器组件有哪些？",
              difficulty: 3,
              likeCount: 23,
              views: 432,
              readFlag: 1
            }
          })
        })
        // 加载更多
        this.loadMoreBuilder()
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .divider({
        strokeWidth: 0.5,
        color: $r('app.color.common_gray_border'),
        startMargin: 16,
        endMargin: 16
      })
      .onReachEnd(() => this.onReachEnd())
    }
    .onRefreshing(() => this.onRefresh())
  }
}

export default QuestionListComp;