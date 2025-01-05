import axios, { AxiosError, InternalAxiosRequestConfig } from '@ohos/axios';
import type { AxiosResponse } from '@ohos/axios';
import { auth } from './Auth';
import { promptAction, router } from '@kit.ArkUI';

interface ResType<T> {
  code: 10000 | number;
  success: boolean;
  message: "success" | string;
  data: T;
}

interface RequestOptions<Req> {
  url: string;
  method?: "GET" | "POST";
  params?: object;
  data?: Req;
}

const service = axios.create({
  baseURL: "https://api-harmony-teach.itheima.net/hm",
  timeout: 5000,
})

service.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    const user = auth.getUser();
    if (user.token) {
      config.headers['Authorization'] = 'Bearer ' + user.token;
    }
    return config;
  },
  (err: AxiosError) => {
    return Promise.reject(err);
  }
)

service.interceptors.response.use(
  (response: AxiosResponse) => {
    return response;
  },
  (err: AxiosError) => {
    if (err.response?.status === 401) {
      auth.clear();
      router.pushUrl({
        url: 'pages/LoginPage'
      }, router.RouterMode.Single);
      promptAction.showToast({ message: "登录失效" });
    }
    return Promise.reject(err);
  }
)

const request = async<Res, Req = Object>(options: RequestOptions<Req>) => {
  const response = await service<null, AxiosResponse<ResType<Res>, Req>, Req>({
    url: options.url,
    method: options.method || "GET",
    params: options.params,
    data: options.data,
  });

  const res = response.data;

  if (res.code !== 10000) {
    return Promise.reject(res);
  }

  return res.data;
}

export default request;