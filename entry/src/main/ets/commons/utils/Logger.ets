import hilog from '@ohos.hilog';

class Logger {
  private static domain: number = 0x1234;
  private static prefix: string = "yo_interview_logger";
  private static format: string = '%{public}s, %{public}s';

  private constructor() {
  }

  static debug(...args: string[]) {
    hilog.debug(Logger.domain, Logger.prefix, Logger.format, args);
  }

  static info(...args: string[]): void {
    hilog.info(Logger.domain, Logger.prefix, Logger.format, args);
  }

  static warn(...args: string[]): void {
    hilog.warn(Logger.domain, Logger.prefix, Logger.format, args);
  }

  static error(...args: string[]): void {
    hilog.error(Logger.domain, Logger.prefix, Logger.format, args);
  }
}

export default Logger;

