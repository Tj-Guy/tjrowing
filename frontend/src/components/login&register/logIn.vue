<template>
  <v-container class="fill-height">
    <v-sheet width="500" class="mx-auto">
      <v-form v-model="valid" >
        <v-container class="mb-6 bg-surface-variant fill-height">
          <v-row>
            <v-col
              cols="12"
              ld="4"
            >
              <v-text-field
                v-model="form.Id"
                :rules="nameRules"
                label="用户名"
                required
              ></v-text-field>
              <v-text-field
                v-model="tempPW"
                :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                :type="show1 ? 'text' : 'password'"
                :rules="pdRules"
                label="密码"
                @click:append="show1 = !show1"
                required
              ></v-text-field>
              <v-btn @click="submit">
                登录
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </v-form>
    </v-sheet>
  </v-container>
</template>

<script setup>


</script>

<script>
import loginToBack from "@/ax";
import {ElMessage} from "element-plus";
import md5 from "js-md5";

export default {
  data: () =>({
    show1: false,
    valid: false,
    alert_visible: false,
    tempPW: '',
    form: {
      Id: null,
      Password: '',
    },
    nameRules: [
      value => {
        if (value) return true

        return 'Name is required.'
      },
      value => {
        if (value?.length <= 20) return true

        return 'Name must be less than 20 characters.'
      },
    ],
    pdRules: [
      value => {
        if (value) return true

        return 'Please enter the password.'
      },
    ],
    message: {
      type: '',
      msg: '',
    }
  }),
  methods: {
    submit(){
      this.form.Password = md5(this.tempPW);
      console.log(this.form);
      loginToBack.post("/log/UserLogin", this.form)
        .then((res) => {
          console.log(res)
          if(res.status === 200)
          {
            this.$router.replace({path: "/"})
            // let token = res.headers['authorization'];
            // localStorage.setItem('tokenID', token);
            ElMessage({
              type: "success",
              message: "登录成功"
            })
          }
        })
    },
  }
}
</script>

<style scoped>

</style>
