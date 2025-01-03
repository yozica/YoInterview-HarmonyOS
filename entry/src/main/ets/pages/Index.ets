import { FullScreen, Logger } from '../commons/utils';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Button(this.message)
        .id('HelloWorld')
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          try {
            FullScreen.status ? FullScreen.disable() : FullScreen.enable();
          } catch (e) {
            Logger.error(e);
          }
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Pink)
  }
}