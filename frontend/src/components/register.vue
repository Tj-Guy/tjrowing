<script setup>

</script>

<template>
  <v-container class="fill-height">
  <v-sheet width="500" class="mx-auto">
    <v-form v-model="valid" ref="form">
      <v-container class="mb-6 bg-surface-variant fill-height">
        <v-row>
          <v-col
            cols="12"
            ld="4"
          >
            <v-text-field
              v-model="form.Id"
              :rules="idRules"
              label="账号"
              required
            ></v-text-field>
            <v-text-field
              v-model="form.email"
              :rules="mailRules"
              label="电子邮箱"
              required
            ></v-text-field>
            <v-text-field
              v-model="form.Password"
              :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show1 ? 'text' : 'password'"
              :rules="pdRules.notNULL"
              label="输入密码"
              @click:append="show1 = !show1"
              required
            ></v-text-field>
            <v-text-field
              v-model="confirm_pd"
              :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
              :type="show2 ? 'text' : 'password'"
              :rules="pdRules.confirm"
              label="确认密码"
              @click:append="show2 = !show2"
              required
            ></v-text-field>
            <v-btn @click="submit">
              Sign up
            </v-btn>
          </v-col>
        </v-row>
      </v-container>
    </v-form>
  </v-sheet>
  </v-container>
</template>

<script>
import loginToBack from "@/ax";
import {ElMessage} from "element-plus";
export default {
  data () {
    const conf = (value) => {
      return value === this.form.Password;
    }
    return {
    form: {
      Id: null,
      email: '',
      Password: '',
    },
    show1: false,
    show2: false,
    valid: false,
    alert_visible: false,
    confirm_pd: '',
    idRules: [
      value => {
        if (value) return true

        return 'Name is required.'
      },
      value => {
        if (value?.length <= 20) return true

        return 'Name must be less than 20 characters.'
      },
    ],
    mailRules: [
      value => {
        let reg=/^([a-zA-Z0-9]+[_|-|.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|-|.]?)*[a-zA-Z0-9]+.[a-zA-Z]{2,3}$/gi;
        if(reg.test(value)) return true

        return '您输入的邮箱有误。'
      }
    ],
    pdRules: {
      notNULL: [
        value => {
        if (value) return true

        return '请输入密码。'
        },
      ],
      confirm: [
        value => {
          if(conf(value)) return true

          return "两次输入的密码不一致"
        }
      ]
    },
    message: {
      type: '',
      msg: '',
    }
  }
  },
  methods: {
    submit(){
      console.log({
        ID: this.form.Id,
        EMAIL: this.form.email,
        PASSWORD: this.form.Password
      })
      loginToBack.post("/signup", {
        ID: this.form.Id,
        EMAIL: this.form.email,
        PASSWORD: this.form.Password
      })
        .then((res) => {
          console.log(res)
          if(res.status === 200)
          {
            this.$router.replace({path: "/"})
            let token = res.headers['authorization'];
            localStorage.setItem('tokenID', token);
            ElMessage({
              type: "success",
              message: "注册成功"
            })
          }
        })
    },
  }
}
</script>

<style scoped>

</style>
