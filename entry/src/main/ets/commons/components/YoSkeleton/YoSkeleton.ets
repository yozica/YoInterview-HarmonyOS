import { YoSkeletonItem } from "..";

@Component
struct YoSkeleton {
  @State opacityValue: number = 1;
  @BuilderParam
  default: () => void = this.defaultBuilder;

  @Builder
  defaultBuilder() {
    YoSkeletonItem()
  }

  build() {
    Row() {
      this.default()
    }
    .opacity(this.opacityValue)
    .animation({
      duration: 600,
      iterations: -1,
      playMode: PlayMode.Alternate,
      curve: Curve.Linear
    })
    .onAppear(() => {
      this.opacityValue = 0.5;
    })
  }
}

export default YoSkeleton;