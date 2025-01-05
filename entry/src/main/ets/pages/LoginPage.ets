import { YoNavBar } from '../commons/components';

@Extend(TextInput)
function customStyle() {
  .placeholderColor("#c3c3c5")
  .caretColor("#fa711d")
  .height(44)
  .borderRadius(0)
  .backgroundColor($r('app.color.white'))
  .border({
    width: { bottom: 0.5 },
    color: $r('app.color.common_gray_border')
  })
}

@Entry
@Component
struct LoginPage {
  @State mobile: string = 'yozica';
  @State code: string = '';
  @State isAgree: boolean = false;
  @State loading: boolean = false;

  build() {
    Column() {
      YoNavBar({ showRightIcon: false })
      Column() {
        Image($r('app.media.icon'))
          .width(120)
          .aspectRatio(1)
        Text("面试通")
          .fontSize(28)
          .margin({ bottom: 15 })
        Text("搞定企业面试真题，就用面试通")
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
      }
      .padding(16)

      Column({ space: 15 }) {
        TextInput({ placeholder: "请输入用户名", text: $$this.mobile })
          .customStyle()
        TextInput({ placeholder: "请输入密码", text: $$this.code })
          .customStyle()
          .type(InputType.Password)
          .showPasswordIcon(false)
        Row() {
          Checkbox()
            .shape(CheckBoxShape.ROUNDED_SQUARE)
            .selectedColor("#fa711d")
            .size({ width: 14, height: 14 })
            .select($$this.isAgree)
          Text('已阅读并同意')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_01'))
            .padding({ right: 4 })
          Text('用户协议')
            .fontSize(14)
            .padding({ right: 4 })
          Text('和')
            .fontSize(14)
            .fontColor($r('app.color.common_gray_01'))
            .padding({ right: 4 })
          Text('隐私政策')
            .fontSize(14)
        }
        .width('100%')

        Button({ type: ButtonType.Normal }) {
          Row() {
            if (this.loading) {
              LoadingProgress()
                .color($r('app.color.white'))
                .size({ width: 24, height: 24 })
                .margin({ right: 10 })
            }
            Text('立即登录')
              .fontColor($r('app.color.white'))
          }
        }
        .width('100%')
        .height(44)
        .backgroundColor('none')
        .borderRadius(4)
        .linearGradient({
          direction: GradientDirection.Right,
          colors: [['#fc9c1c', 0], ['#fa711d', 1]]
        })
        .stateEffect(false)
        .onClick(() => {
        })
      }
      .padding({ left: 16, right: 16, top: 30 })

      Column() {
        Text('其他登录方式')
          .fontSize(14)
          .fontColor($r('app.color.common_gray_01'))
      }
      .padding({ top: 70, bottom: 100 })
    }
    .height('100%')
    .width('100%')
  }
}