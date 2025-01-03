import HomePage from './HomePage';
import ProjectPage from './ProjectPage';
import InterviewPage from './InterviewPage';
import MinePage from './MinePage';

interface TabItem {
  name: string;
  icon: ResourceStr;
  activeIcon: ResourceStr;
}

@Entry
@Component
struct Index {
  // 安全区域
  @StorageProp('topArea') topArea: number = 0
  @StorageProp('bottomArea') bottomArea: number = 0
  // 当前tab页
  @State curIndex: number = 0;
  // tab列表
  tabList: TabItem[] = [
    { name: "首页", icon: $r('app.media.tabbar_home'), activeIcon: $r('app.media.tabbar_home_fill') },
    { name: "项目", icon: $r('app.media.tabbar_project'), activeIcon: $r('app.media.tabbar_project_fill') },
    { name: "面经", icon: $r('app.media.tabbar_interview'), activeIcon: $r('app.media.tabbar_interview_fill') },
    { name: "我的", icon: $r('app.media.tabbar_mine'), activeIcon: $r('app.media.tabbar_mine_fill') },
  ];

  @Builder
  tabItemBuilder(item: TabItem, index: number) {
    Column({ space: 4 }) {
      Image(index === this.curIndex ? item.activeIcon : item.icon)
        .width(24)
        .aspectRatio(1)
      Text(item.name)
        .fontSize(12)
        .fontColor(index === this.curIndex ? $r('app.color.black') : $r('app.color.common_gray_01'))
    }
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: $$this.curIndex }) {
        ForEach(this.tabList, (item: TabItem, index) => {
          TabContent() {
            if (index === 0) {
              HomePage()
            } else if (index === 1) {
              ProjectPage()
            } else if (index === 2) {
              InterviewPage()
            } else {
              MinePage()
            }
          }.tabBar(this.tabItemBuilder(item, index))
        })
      }
      .scrollable(false)
      .animationMode(AnimationMode.NO_ANIMATION)
      .margin({ top: this.topArea, bottom: this.bottomArea })
    }
    .height('100%')
    .width('100%')
  }
}