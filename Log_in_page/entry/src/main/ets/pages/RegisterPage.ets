/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import prompt from '@ohos.promptAction';
import router from '@ohos.router';
import CommonConstants from '../common/constants/CommonConstants';

@Extend(TextInput) function inputStyle () {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor($r('app.color.background'))
  .width(CommonConstants.FULL_PARENT)
  .padding({ left: CommonConstants.INPUT_PADDING_LEFT })
  .margin({ top: $r('app.float.input_margin_top') })
}

@Extend(Line) function lineStyle () {
  .width(CommonConstants.FULL_PARENT)
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

@Extend(Text) function blueTextStyle () {
  .fontColor($r('app.color.login_blue_text_color'))
  .fontSize($r('app.float.small_text_size'))
  .fontWeight(FontWeight.Medium)
}

/**
 * Login page
 */
@Entry
@Component
struct LoginPage {
  @State account: string = '';
  @State password: string = '';
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;

  @Builder imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height($r('app.float.other_login_image_size'))
    .width($r('app.float.other_login_image_size'))
    .backgroundColor($r('app.color.background'))
  }

  login() {
    if (this.account === '' || this.password === '') {
      prompt.showToast({
        message: $r('app.string.input_empty_tips')
      })
    } else {
      prompt.showToast({
        message: $r('app.string.wait_tips')
      })
      //this.isShowProgress = true;
      if (this.timeOutId === -1) {
        this.timeOutId = setTimeout(() => {
          //this.isShowProgress = false;
          //this.timeOutId = -1;
          console.info(`pages/MainPage`)
          router.pushUrl({ url: 'pages/MainPage' }).then(() => {
            console.info('Succeeded in jumping to the second page.')

          }).catch((err) => {
            console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
          })
        }, CommonConstants.LOGIN_DELAY_TIME);
      }
    }
  }
  Back() {
      //this.isShowProgress = true;
      //if (this.timeOutId === -1) {
    prompt.showToast({
      message: $r('app.string.wait_tips')
    })
        this.timeOutId = setTimeout(() => {
          //this.isShowProgress = false;
          //this.timeOutId = -1;
          console.info(`pages/LoginPage`)
          router.pushUrl({ url: 'pages/zhuce' }).then(() => {
            console.info('Succeeded in jumping to the second page.')

          }).catch((err) => {
            console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
          })
        }, CommonConstants.LOGIN_DELAY_TIME);


  }

  aboutToDisappear() {
    clearTimeout(this.timeOutId);
    this.timeOutId = -1;
  }

  build() {
    Column() {
      Image($r('app.media.img_2'))
        .width($r('app.float.logo_image_size'))
        .height($r('app.float.logo_image_size'))
        .margin({ top: $r('app.float.logo_margin_top'), bottom: $r('app.float.logo_margin_bottom') })
      Text($r('app.string.login_page'))
        .fontSize($r('app.float.page_title_text_size'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.title_text_color'))
      Text("欢迎登录 A New Day")
        .fontColor(Color.Gray)
        .fontSize(14)
        .margin({
          top: '15vp'
        })

      TextInput({ placeholder: '请输入手机号' })
        .onChange((value: string) => {
          this.account = value;
        })
        .margin({ bottom: '10vp' })
        //.type(InputType.Password)
        .maxLength(CommonConstants.INPUT_ACCOUNT_LENGTH)
        .inputStyle()

      TextInput({ placeholder: '请输入验证码' })
        .onChange((value: string) => {
          this.password = value;
        })
        .margin({ bottom: '10vp' })
        .type(InputType.Password)
        .maxLength(CommonConstants.INPUT_ACCOUNT_LENGTH)
        .inputStyle()

      Row() {
        Text("获取短信验证码").fontColor("#007DFF")
          .fontSize(12)
          .margin({left:5})
        //Text("忘记密码").fontColor("#007DFF").fontSize(12)
      }
      .margin({ top: 10})
      .width("100%").justifyContent(FlexAlign.SpaceBetween)

      Button("下一步", { type: ButtonType.Capsule })
        .width(CommonConstants.BUTTON_WIDTH)
        .height($r('app.float.login_button_height'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.login_button_color'))
        .margin({ top: $r('app.float.back_button_margin_top'), bottom: $r('app.float.login_button_margin_bottom') })
        .onClick(() => {
          this.Back();
        })

      if (this.isShowProgress) {
        LoadingProgress()
          .color($r('app.color.loading_color'))
          .width($r('app.float.login_progress_size'))
          .height($r('app.float.login_progress_size'))
          .margin({ top: $r('app.float.login_progress_margin_top') })
      }

      Blank()
      Text("其他注册方式")
        .fontColor($r('app.color.other_login_text_color'))
        .fontSize($r('app.float.little_text_size'))
        .fontWeight(FontWeight.Medium)
        .margin({ top: $r('app.float.other_login_margin_top'), bottom: $r('app.float.other_login_margin_bottom') })
      Row({ space: CommonConstants.LOGIN_METHODS_SPACE }) {
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
    }
    .backgroundImage($r("app.media.img"))
    .backgroundImageSize({
      height:'100%'
    })
    .height(CommonConstants.FULL_PARENT)
    .width(CommonConstants.FULL_PARENT)
    .padding({
      left: $r('app.float.page_padding_hor'),
      right: $r('app.float.page_padding_hor'),
      bottom: $r('app.float.login_page_padding_bottom')
    })
  }
}