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