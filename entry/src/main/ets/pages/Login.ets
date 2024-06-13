import router from '@ohos.router'
import { toast } from '../common/Toast'
import Api from '../net/Api'
import UserService from '../service/UserService'
import { LoadState, PageLoading } from '../widget/PageLoading'
import { TitleLayout } from '../widget/TitleLayout'


@Entry
@Component
struct Login {
  @State loadState: LoadState = LoadState.SUCCESS;
  @State showLoading: boolean = false;
  @State title: string = "登录";
  private account: string;
  private password: string;
  private repassword: string;
  @State isVisible: boolean = false;

  async login() {
    if (!this.account) {
      toast("请输入用户名");
      return;
    }
    if (!this.password) {
      toast("请输入密码");
      return;
    }
    this.showLoading = true;
    let res = await Api.get().login(this.account, this.password);
    this.showLoading = false;
    if (res.isSuccessWithData()) {
      toast("登录成功");
      UserService.get().setUser(res.data);
      let user = await UserService.get().updateUser();
      if (user) {
        router.back();
      }
    } else {
      toast(res.errorMsg);
    }
  }

  async register() {
    if (!this.account) {
      toast("请输入用户名");
      return;
    }
    if (!this.password) {
      toast("请输入密码");
      return;
    }
    if (!this.repassword) {
      toast("请再次输入密码");
      return;
    }
    if (this.password != this.repassword) {
      toast("输入的两次密码不一致");
      return;
    }
    this.showLoading = true;
    let res = await Api.get().register(this.account, this.password, this.repassword);
    this.showLoading = false;
    if (res.isSuccessWithData()) {
      toast("注册成功");
      UserService.get().setUser(res.data);
      let user = await UserService.get().updateUser();
      if (user) {
        router.back();
      }
    } else {
      toast(res.errorMsg);
    }
  }

  build() {
    Stack() {
      PageLoading({
        loadState: $loadState,
        showLoading: $showLoading
      }) {
        Column() {
          TitleLayout({
            title: $title
          })
          Column() {
            TextInput({
              placeholder: "请输入用户名"
            })
              .fontSize(15)
              .fontColor($r("app.color.text_h1"))
              .type(InputType.Email)
              .onChange((value) => {
                this.account = value
              })
            TextInput({
              placeholder: "请输入密码"
            })
              .margin({ top: 16 })
              .fontSize(15)
              .fontColor($r("app.color.text_h1"))
              .type(InputType.Password)
              .onChange((value) => {
                this.password = value
              })
            if (this.isVisible) {

            }
            TextInput({
              placeholder: "请再次输入密码"
            })
              .margin({ top: 16 })
              .fontSize(15)
              .fontColor($r("app.color.text_h1"))
              .type(InputType.Password)
              .onChange((value) => {
                this.repassword = value
              })
              .visibility(this.isVisible ? Visibility.Visible : Visibility.None)
            Button("登录", {
              type: ButtonType.Capsule
            })
              .width('80%')
              .margin({ top: 50 })
              .fontSize(15)
              .onClick((e) => {
                this.login();
              })

            Text('注册账号')
              .fontColor($r("app.color.text_h2"))
              .margin({ top: 15 })
              .onClick((e) => {
                this.isVisible = true
                this.register()
              })
          }
          .width('100%')
          .margin({ top: 120 })
          .padding({ left: 16, right: 16 })
        }
        .width('100%')
        .height('100%')
      }
    }
    .width('100%')
    .height('100%')
  }
}