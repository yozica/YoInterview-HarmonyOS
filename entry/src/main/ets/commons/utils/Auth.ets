import { User } from '../../models';

export class Auth {
  private static instance: Auth;
  static UserStoreKey = 'user';

  private constructor() {
  }

  initUser() {
    PersistentStorage.persistProp<User>(Auth.UserStoreKey, Auth.getFakeAuth());
  }

  getUser() {
    return AppStorage.get<User>(Auth.UserStoreKey) ?? Auth.getFakeAuth();
  }

  setUser(user: User) {
    AppStorage.setOrCreate(Auth.UserStoreKey, user);
  }

  clear() {
    this.setUser(Auth.getFakeAuth());
  }

  static getInstance() {
    if (!Auth.instance) {
      Auth.instance = new Auth();
    }
    return Auth.instance;
  }

  static getFakeAuth(): User {
    return {
      id: '',
      username: '',
      avatar: '',
      token: ''
    }
  }
}

export const auth = Auth.getInstance();