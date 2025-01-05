import { YoClockIn } from '../commons/components';
import { router } from '@kit.ArkUI';
import { StatusBar } from '../commons/utils';
import { User } from '../models';
import { formatTime } from '../commons/utils/common';
import { auth, Auth } from '../commons/utils/Auth';

interface ClickElement {
  icon: ResourceStr;
  name: string;
  onClick?: () => void;
}

interface Nav extends ClickElement {
  other?: string;
}

interface Tool extends ClickElement {
  value?: string;
}

const tools: Tool[] = [
  {
    icon: $r('app.media.ic_mine_notes'),
    name: "开发常用词",
    onClick: () => {
    }
  },
  {
    icon: $r('app.media.ic_mine_ai'),
    name: "面通 AI"
  },
  {
    icon: $r('app.media.ic_mine_invite'),
    name: "推荐分享"
  },
  {
    icon: $r("app.media.ic_mine_file"),
    name: "意见反馈"
  },
  {
    icon: $r("app.media.ic_mine_info"),
    name: "关于我们"
  },
  {
    icon: $r('app.media.ic_mine_setting'),
    name: "设置",
    onClick: () => {
    }
  }
]

@Component
struct MinePage {
  @StorageProp('topArea')
  topArea: number = 0;
  @Watch('watchUser')
  @StorageProp(Auth.UserStoreKey)
  user: User = Auth.getFakeAuth();
  @State
  navs: Nav[] = [
    {
      icon: $r('app.media.ic_mine_history'),
      name: "历史记录",
      onClick: () => {
      }
    },
    {
      icon: $r('app.media.ic_mine_collect'),
      name: "我的收藏",
      onClick: () => {
      }
    },
    {
      icon: $r('app.media.ic_mine_like'),
      name: "我的点赞",
      onClick: () => {
      }
    },
    {
      icon: $r('app.media.ic_mine_study'),
      name: "累计学时",
      other: formatTime(this.user.totalTime ?? 0),
      onClick: () => {
      }
    }
  ];

  watchUser() {
    this.navs[3] = {
      icon: $r('app.media.ic_mine_study'),
      name: "累计学时",
      other: formatTime(this.user.totalTime ?? 0),
      onClick: () => {
      }
    }
  }

  @Builder
  navBuilder(nav: Nav) {
    GridCol() {
      Column() {
        Image(nav.icon)
          .width(30)
          .aspectRatio(1)
          .margin({ bottom: 10 })
        Text(nav.name)
          .fontSize(14)
          .fontColor($r('app.color.common_gray_03'))
          .margin({ bottom: 4 })
        if (nav.other) {
          Row() {
            Text(nav.other)
              .fontSize(12)
              .fontColor($r('app.color.common_gray_01'))
            Image($r('sys.media.ohos_ic_public_arrow_right'))
              .width(12)
              .aspectRatio(1)
              .fillColor($r('app.color.common_gray_01'))
          }
        }
      }
      .onClick(() => {
        nav.onClick && nav.onClick()
      })
    }
  }

  @Builder
  toolBuilder(tool: Tool) {
    Row() {
      Image(tool.icon)
        .width(16)
        .aspectRatio(1)
        .margin({ right: 12 })
      Text(tool.name)
        .fontSize(14)
      Blank()
      if (tool.value) {
        Text(tool.value)
          .fontSize(12)
          .fontColor($r('app.color.common_gray_01'))
      }
      Image($r('sys.media.ohos_ic_public_arrow_right'))
        .width(16)
        .aspectRatio(1)
        .fillColor($r('app.color.common_gray_01'))
    }
    .width('100%')
    .height(50)
    .padding({ left: 16, right: 10 })
    .onClick(() => {
      tool.onClick && tool.onClick();
    })
  }

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Image($r('app.media.ic_mine_avatar'))
          .alt($r('app.media.ic_mine_avatar'))
          .width(55)
          .aspectRatio(1)
          .borderRadius(55)
        if (this.user.token) {
          Column({ space: 4 }) {
            Text(this.user.nickName ?? this.user.username)
              .fontSize(18)
              .fontWeight(500)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
            Row({ space: 4 }) {
              Text('编辑信息')
                .fontSize(12)
                .fontColor($r('app.color.common_gray_01'))
              Image($r('app.media.ic_mine_edit'))
                .width(12)
                .aspectRatio(1)
                .fillColor($r('app.color.common_gray_01'))
            }
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        } else {
          Text('立即登录')
            .fontSize(18)
            .fontWeight(500)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
            .onClick(() => {
              router.pushUrl({
                url: "pages/LoginPage"
              })
            })
        }
        YoClockIn({ clockInCount: 10 })
      }
      .width('100%')
      .height(100)
      .margin({ top: this.topArea })

      GridRow({ columns: 4 }) {
        ForEach(this.navs, (nav: Nav) => {
          this.navBuilder(nav)
        })
      }
      .padding(16)
      .borderRadius(8)
      .backgroundColor($r('app.color.white'))

      Column() {
        ForEach(tools, (tool: Tool) => {
          this.toolBuilder(tool)
        })
      }
      .borderRadius(8)
      .backgroundColor($r('app.color.white'))

      if (this.user.token) {
        Button('退出登录')
          .onClick(() => {
            auth.clear();
            router.pushUrl({
              url: 'pages/LoginPage'
            })
          })
      }
      Button('模拟token失效')
        .onClick(() => {
          const user = auth.getUser();
          user.token = Date.now().toString()
          auth.setUser(user);
        })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor($r('app.color.common_gray_bg'))
    .linearGradient({
      colors: [["#ffb071", 0], [$r('app.color.common_gray_bg'), 0.3], [$r('app.color.common_gray_bg'), 1]]
    })
    .onVisibleAreaChange([0, 1], (isVisible) => {
      if (isVisible) {
        StatusBar.setLightBar();
      } else {
        StatusBar.setDarkBar();
      }
    })
  }
}

export default MinePage;