import http from '@ohos.net.http';

export function httpRequestGet(url:string){
  let httpRequestGet = http.createHttp()
  httpRequestGet.request(url,{

  })
}