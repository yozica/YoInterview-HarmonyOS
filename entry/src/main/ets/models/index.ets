export interface QuestionType {
  id: number;
  name: string;
  displayNewestFlag: 0 | 1; // 1 表示是新的， 0 表示不是新的
}

export interface QuestionItem {
  id: string;
  stem: string; // 题干
  difficulty: 1 | 2 | 3 | 4 | 5; // 难度
  likeCount: number; // 点赞数
  views: number; // 浏览数
  readFlag: 0 | 1; // 是否已看过
}

export interface TempObject {}

export interface PageData<T> {
  total: number;
  pageTotal: number;
  rows: T[];
}

export enum SortType {
  Default = 0,
  DifficultyLow = 10,
  DifficultyHigh = 11,
  ViewLow = 20,
  ViewHigh = 21,
  Commend = 30,
}

export interface QuestionListParams {
  type: number;
  questionBankType: 9 | 10;
  sort?: SortType;
  page?: number;
  pageSize?: number;
}

export interface User {
  id: string
  username: string
  avatar: string
  token: string
  nickName?: string
  // 学习时长
  totalTime?: number
  // 打卡次数
  clockinNumbers?: number
}