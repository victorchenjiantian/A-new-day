@Entry
@Component
struct Index {
  build(){
    Column({space:10}) {
      Image($r("app.media.img_2"))
        .width(80)
        .height(80)
        .borderRadius(50)
        .margin({
          top: "120vp"
        })
      Text("欢迎登录 A New Day")
        .fontColor(Color.Gray)
        .fontSize(14)
        .margin({
          top: '15vp'
        })
      TextInput({ placeholder: '请输入用户名' })
        .margin({ bottom: '10vp' })
      TextInput({ placeholder: '请输入密码' })
        .type(InputType.Password)

      Row() {
        Text("短信验证码").fontColor("#007DFF")
          .fontSize(12)
          .margin({left:5})
        Text("忘记密码").fontColor("#007DFF").fontSize(12)
      }.width("100%").justifyContent(FlexAlign.SpaceBetween)

      Button("登录").width("100%").type(ButtonType.Capsule)
      Text("注册账号").fontColor("#007DFF").fontSize(14)
      LoadingProgress().width(50).height(50).color(Color.Blue)
      Blank()
      Row() {
        Line().width("20%").height(0.5)
          .borderColor(Color.Gray)
        Text("其他登录方式").fontSize(14)
          .margin({
            left:10,
            right:10
          }).fontColor(Color.Gray)
        Line().width("20%").height(0.5)
          .borderColor(Color.Gray)
      }

      Row({space:50}) {
        Button() {
          Image($r("app.media.wechat")).width(35).height(35)
        }.backgroundColor(Color.Transparent)

        Button() {
          Image($r("app.media.QQ")).width(35).height(35)
        }.backgroundColor(Color.Transparent)

        Button() {
          Image($r("app.media.weibo")).width(35).height(35)
        }.backgroundColor(Color.Transparent)
      }
      .width("100%")
      .margin({
        bottom:10
      })
      .justifyContent(FlexAlign.Center)
    }
    .backgroundImage($r("app.media.img"))
    .backgroundImageSize({
      height:'100%'
    })
    .padding({
      left:'10vp',
      right:'10vp',
      bottom:'10vp'
    })

    .border({width:1 })
    .width("100%")
    .height("100%")

  }
}
