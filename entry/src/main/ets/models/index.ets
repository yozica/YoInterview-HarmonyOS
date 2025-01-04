export interface QuestionType {
  id: number;
  name: string;
  // 1 表示是新的， 0 表示不是新的
  displayNewestFlag: 0 | 1
}