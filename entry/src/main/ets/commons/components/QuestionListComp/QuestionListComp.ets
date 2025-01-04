import QuestionItemComp from '../QuestionItemComp/QuestionItemComp'
import request from '../../utils/request';
import { PageData, QuestionItem, QuestionListParams, SortType } from '../../../models';

@Component
struct QuestionListComp {
  @Prop typeId: number;
  @Prop sort: SortType = SortType.Default;
  @State list: QuestionItem[] = [];
  @State isRefreshing: boolean = false;
  @State isLoading: boolean = false;
  @State isFinish: boolean = false;
  @State page: number = 1;
  @State pageSize: number = 10;

  async getQuestionList() {
    const res = await request<PageData<QuestionItem>>({
      url: "/question/list",
      params: {
        type: this.typeId,
        questionBankType: 10,
        sort: this.sort,
        page: this.page,
        pageSize: this.pageSize
      } as QuestionListParams
    })
    return res;
  }

  async onLoad(isRefresh = false) {
    if (this.isFinish || this.isLoading || this.isRefreshing) return;
    this.isLoading = true;
    const res = await this.getQuestionList();
    isRefresh ? (this.list = [...res.rows]) : this.list.push(...res.rows);
    this.isLoading = false;
    if (this.list.length >= res.total) {
      this.isFinish = true;
    } else {
      this.page++;
    }
  }

  async onRefresh() {
    this.page = 1;
    this.isFinish = false;
    this.isRefreshing = false;
    await this.onLoad(true);
  }

  onReachEnd() {
    this.onLoad();
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
        ForEach(this.list, (question: QuestionItem) => {
          QuestionItemComp({ item: question })
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