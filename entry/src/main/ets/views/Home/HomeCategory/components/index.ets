import { SortType } from "../../../../models";

@Component
struct FilterButton {
  @Prop text: string = '';
  @Prop isSort: boolean = false;
  @Prop isNew: boolean = false;
  @Prop selected: boolean = false;
  @Watch('watchSort')
  @Prop
  sort: SortType = SortType.Default;
  @State isUp: boolean = this.getIsUp();
  @State isDown: boolean = this.getIsDown();

  watchSort() {
    this.isUp = this.getIsUp();
    this.isDown = this.getIsDown();
  }

  getIsUp() {
    return this.selected && ((this.sort === SortType.DifficultyLow) || (this.sort === SortType.ViewLow));
  }

  getIsDown() {
    return this.selected && ((this.sort === SortType.DifficultyHigh) || (this.sort === SortType.ViewHigh));
  }

  build() {
    Row() {
      Text(this.text)
        .fontSize(12)
        .fontColor(this.selected ? $r('app.color.common_main_color') : $r('app.color.black'))
      if (this.isSort) {
        Column() {
          Image($r('sys.media.ohos_ic_public_arrow_up'))
            .size({ width: 12, height: 6 })
            .fillColor(this.isUp ? $r('app.color.common_main_color') : $r('app.color.black'))
          Image($r('sys.media.ohos_ic_public_arrow_down'))
            .size({ width: 12, height: 6 })
            .fillColor(this.isDown ? $r('app.color.common_main_color') : $r('app.color.black'))
        }
        .margin({ left: 2 })
      }
      if (this.isNew) {
        Image($r('app.media.ic_home_new'))
          .width(32)
          .height(14)
          .objectFit(ImageFit.Contain)
          .position({ right: -26, top: -7 })
      }
    }
    .height(32)
    .padding({ left: 10, right: 10 })
    .borderRadius(4)
    .backgroundColor($r('app.color.common_blue_bg'))
    .margin({ right: this.isNew ? 10 : 0 })
  }
}

export { FilterButton }