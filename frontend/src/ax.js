import axios from "axios"
import {ElMessage} from "element-plus";

const loginToBack =  axios.create({
  baseURL: "http://47.117.160.47",
  headers: {
    "Content-Type": "application/json",
  },
  timeout: 5000,
})

loginToBack.interceptors.request.use(
  configs => {
    configs.url = configs.url.replace("/api", "")
    return configs
  },
  error => {
    console.log(this.baseURL + configs.url)
    console.log(error)
    return Promise.reject("request error")
  }
)

loginToBack.interceptors.response.use(
  response => {
      return response;
  },
  async error => {
    let { response } = error
    let err_msg = ''
    if(response)
    {
      switch(response.status){
        case 401:
          ElMessage({
            type: "error",
            message: "登陆失败"
          })
          setTimeout("location.reload()", 1000)
      }
    }
    console.log(error);
    return Promise.reject(err_msg)
  }
)
export default loginToBack
