import { window } from '@kit.ArkUI';

class FullScreen {
  static status: boolean = false;

  private constructor() {
  }

  private static async changeStatus(status: boolean): Promise<window.Window> {
    const ctx = AppStorage.get<Context>('context');

    if (!ctx) {
      throw new Error('未获取到 Context')
    }

    const win = await window.getLastWindow(ctx);
    win.setWindowLayoutFullScreen(status);
    FullScreen.status = status;
    return win;
  }

  static async enable() {
    const win = await FullScreen.changeStatus(true);

    const topArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect;
    const bottomArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect;

    AppStorage.setOrCreate('topArea', px2vp(topArea.height));
    AppStorage.setOrCreate('bottomArea', px2vp(bottomArea.height));
  }

  static async disable() {
    await FullScreen.changeStatus(false);
    AppStorage.setOrCreate('topArea', 0);
    AppStorage.setOrCreate('bottomArea', 0);
  }
}

export default FullScreen;