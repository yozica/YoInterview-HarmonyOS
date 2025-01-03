import { window } from "@kit.ArkUI";

class StatusBar {
  static async setBar(properties: window.SystemBarProperties) {
    const ctx = AppStorage.get<Context>('context');

    if (!ctx) {
      throw new Error('未获取到 Context')
    }

    const win = await window.getLastWindow(ctx);
    await win.setWindowSystemBarProperties(properties);
  }

  static setDarkBar() {
    StatusBar.setBar({ statusBarContentColor: "#000000" })
  }

  static setLightBar() {
    StatusBar.setBar({ statusBarContentColor: "#ffffff" })
  }
}

export default StatusBar;