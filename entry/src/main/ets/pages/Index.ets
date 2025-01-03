import { Logger, StatusBar } from '../commons/utils';

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
          StatusBar.setLightBar();
        })
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Black)
  }
}