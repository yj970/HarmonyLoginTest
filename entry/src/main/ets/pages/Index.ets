import router from '@ohos.router'
/**
 * 1.基本UI控件（Text、TextInput、Image、Span、Button）
 * 2.定时器（setInterval）
 * 3.创建方法（updateLoginBtnUI）
 * 4.Text中，指定文本高亮处理（Span）
 * 5.route（页面跳转、携带参数)
 */

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State checked: boolean = false
  @State phone: string = ''
  @State code: string = ''
  @State codeText: string = '获取验证码'
  codeTime: number = 0;
  @State loginEnable: boolean = false;
  // 控制器有啥用？
  phoneTextInputController: TextInputController = new TextInputController();
  codeTextInputController: TextInputController = new TextInputController();

  build() {
    Column() {
      Text('欢迎使用XXXX APP')
        .fontSize(20)
        .fontColor('#222222')
        .width('100%')
        .textAlign(TextAlign.Center)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 60 })

      Text('若该手机号未注册，我们将自动为您注册')
        .fontSize(14)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 5 })
      // 账号
      Column() {
        Row() {
          Image($r('app.media.phone'))
            .width(23).height(23)
          TextInput({ text: this.phone, placeholder: '手机号', controller: this.phoneTextInputController })
            .onChange((v) => {
              this.phone = v;
              this.updateLoginBtnUI();
            })
            .layoutWeight(1)
            .backgroundColor(Color.Transparent)
            .type(InputType.Number)
          Image($r('app.media.close'))
            .width(23).height(23).onClick(() => {
            this.phone = '';
          })
        }

        Divider().color(Color.Black)
      }
      .margin({ top: 52, left: 46, right: 46 })
      // 密码
      Column() {
        Row() {
          Image($r('app.media.code'))
            .width(23).height(23)
          TextInput({ placeholder: '验证码', controller: this.codeTextInputController })
            .onChange((v) => {
              this.code = v;
              this.updateLoginBtnUI()
            })
            .layoutWeight(1)
            .backgroundColor(Color.Transparent)
          Text(this.codeText).fontColor('#222222').fontSize(16)
            .onClick(() => {
              // 定时器60s
              if (this.codeTime == 0) {
                this.codeTime = 60
                this.codeText = this.codeTime + 's';
                const id = setInterval(() => {
                  this.codeTime--;
                  if (this.codeTime != 0) {
                    this.codeText = this.codeTime + 's';
                  } else {
                    this.codeText = '获取验证码'
                    clearInterval(id)
                  }
                }, 1000)
              }
            })
        }

        Divider().color(Color.Black)
      }
      .margin({ top: 29, left: 46, right: 46 })
      // 隐私政策
      Row() {
        Image(this.checked ? $r('app.media.yes_check') : $r('app.media.no_check'))
          .width(22)
          .onClick(() => {
            this.checked = !this.checked
            this.updateLoginBtnUI()
          })
        Text() {
          Span('请认真阅读并同意').fontColor('#222222')
          Span('用户协议').fontColor(Color.Blue).onClick(() => {
            // 模拟跳转
            router.pushUrl({
              url: 'pages/MyWeb',
              params: { url: 'https://www.baidu.com/' }
            }, router.RouterMode.Standard)
          })
          Span('、').fontColor('#222222')
          Span('隐私政策').fontColor(Color.Blue).onClick(() => {
          })
          Span('、').fontColor('#222222')
          Span('儿童隐私政策').fontColor(Color.Blue).onClick(() => {
          })
        }
        .fontSize(13)
        .margin({ left: 12 })
      }.margin({ top: 39, left: 46, right: 46 })
      // 立即登录
      Button('立即登录')
        .width(283)
        .height(44)
        .backgroundColor(this.loginEnable ? Color.Black : Color.Gray)
        .fontColor(Color.White)
        .margin({ top: 48 })
    }
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }

  // 更新登录按钮UI
  updateLoginBtnUI() {
    const phoneNoEmpty: boolean = this.phone.length > 0;
    const codeNoEmpty: boolean = this.code.length > 0;
    this.loginEnable = phoneNoEmpty && codeNoEmpty && this.checked;
  }
}


