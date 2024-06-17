import router from '@ohos.router';

/**
 * 1.web的使用
 * 2.获取上一页的跳转参数
 * 3.联网权限（module.json5）
 */

@Entry
@Component
struct MyWeb {
  url: string = '';
  controller: WebController = new WebController();

  aboutToAppear() {
    this.url = router.getParams()['url'];
    console.log("TAG123 url=" + this.url);
  }

  build() {
    Column() {
      Web({ src: this.url, controller: this.controller })
    }.width('100%').height('100%').backgroundColor(Color.Blue)
  }
}