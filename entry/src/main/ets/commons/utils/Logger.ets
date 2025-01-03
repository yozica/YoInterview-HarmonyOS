import hilog from '@ohos.hilog';

class Logger {
  private static domain: number = 0x1234;
  private static tag: string = "yo_interview_logger";

  private constructor() {
  }

  private static assign(...args: string[]) {
    return args.reduce((preValue, curValue) => {
      return preValue + ' ' + curValue;
    }, '')
  }

  static debug(...args: string[]) {
    hilog.debug(Logger.domain, Logger.tag, Logger.assign(...args));
  }

  static info(...args: string[]): void {
    hilog.info(Logger.domain, Logger.tag, Logger.assign(...args));
  }

  static warn(...args: string[]): void {
    hilog.warn(Logger.domain, Logger.tag, Logger.assign(...args));
  }

  static error(...args: string[]): void {
    hilog.error(Logger.domain, Logger.tag, Logger.assign(...args));
  }
}

export default Logger;

