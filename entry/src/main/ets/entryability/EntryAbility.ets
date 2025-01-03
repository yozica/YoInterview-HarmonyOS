import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { FullScreen, Logger } from '../commons/utils';

export default class EntryAbility extends UIAbility {
  onCreate(_: Want, __: AbilityConstant.LaunchParam): void {
    Logger.info('Ability onCreate');
    AppStorage.setOrCreate('context', this.context);
  }

  onDestroy(): void {
    Logger.info('Ability onDestroy');

  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    Logger.info('Ability onWindowStageCreate');

    FullScreen.enable(); // 默认开启全屏

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        Logger.error(`Failed to load the content. Cause: ${JSON.stringify(err) ?? ''}`);
        return;
      }
      Logger.info('Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Logger.info('Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    Logger.info('Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    Logger.info('Ability onBackground');
  }
}