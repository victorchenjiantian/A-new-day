/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { CommonConstants } from '../common/constants/CommonConstants2';

@Entry
@Component
struct history {
  build() {
    Column() {
      Text("学习历史记录")
        .height(56)
        .textAlign(TextAlign.Start)
        .fontSize(24)
        .width("100%")
        .fontColor($r('app.color.grey_divider'))
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })
        .padding({ left: 24})
      Row() {
        Image($r('app.media.SJTU'))
          .width($r('app.float.setting_account_size'))
          .height($r('app.float.setting_account_size'))
        Column() {
          Text("SJTU")
            .fontSize($r('app.float.setting_account_fontSize'))
          Text("record time:  2024/7/19 09:28:20")
            .height(15)
            .textAlign(TextAlign.Start)
            .fontSize(14)
            .width("100%")
            .fontColor($r('app.color.grey_divider'))
              //.fontWeight(FontWeight.Bold)
            .margin({top : 10, bottom: 10 })
            .padding({ left: 24})
          Text("状态 ：已离线")
            .height(56)
            .textAlign(TextAlign.Start)
            .fontSize(14)
            .width("100%")
            .fontColor($r('app.color.grey_divider'))
              //.fontWeight(FontWeight.Bold)
            .margin({ bottom: 0 })
            .padding({ left: 24})
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: $r('app.float.setting_account_margin') })
      }
      .margin({ top: $r('app.float.setting_account_margin') })
      .alignItems(VerticalAlign.Center)
      .width(CommonConstants.FULL_PARENT)
      .height(200)
      .backgroundColor(Color.White)
      .padding({ left: $r('app.float.setting_account_padding') })
      .borderRadius($r('app.float.setting_account_borderRadius'))


      Row() {
        Image($r('app.media.SJTU'))
          .width($r('app.float.setting_account_size'))
          .height($r('app.float.setting_account_size'))
        Column() {
          Text("SJTU")
            .fontSize($r('app.float.setting_account_fontSize'))
          Text("record time:  2024/7/19 09:30:27")
            .height(15)
            .textAlign(TextAlign.Start)
            .fontSize(14)
            .width("100%")
            .fontColor($r('app.color.grey_divider'))
              //.fontWeight(FontWeight.Bold)
            .margin({top : 10, bottom: 10 })
            .padding({ left: 24})
          Text("状态 ：学习中")
            .height(56)
            .textAlign(TextAlign.Start)
            .fontSize(14)
            .width("100%")
            .fontColor($r('app.color.grey_divider'))
              //.fontWeight(FontWeight.Bold)
            .margin({ bottom: 0 })
            .padding({ left: 24})
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: $r('app.float.setting_account_margin') })
      }
      .margin({ top: $r('app.float.setting_account_margin') })
      .alignItems(VerticalAlign.Center)
      .width(CommonConstants.FULL_PARENT)
      .height(200)
      .backgroundColor(Color.White)
      .padding({ left: $r('app.float.setting_account_padding') })
      .borderRadius($r('app.float.setting_account_borderRadius'))



      Row() {
        Image($r('app.media.SJTU'))
          .width($r('app.float.setting_account_size'))
          .height($r('app.float.setting_account_size'))
        Column() {
          Text("SJTU")
            .fontSize($r('app.float.setting_account_fontSize'))
          Text("record time:  2024/7/19 09:31:16")
            .height(15)
            .textAlign(TextAlign.Start)
            .fontSize(14)
            .width("100%")
            .fontColor($r('app.color.grey_divider'))
              //.fontWeight(FontWeight.Bold)
            .margin({top : 10, bottom: 10 })
            .padding({ left: 24})
          Text("状态 ：学习中")
            .height(56)
            .textAlign(TextAlign.Start)
            .fontSize(14)
            .width("100%")
            .fontColor($r('app.color.grey_divider'))
              //.fontWeight(FontWeight.Bold)
            .margin({ bottom: 0 })
            .padding({ left: 24})
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: $r('app.float.setting_account_margin') })
      }
      .margin({ top: $r('app.float.setting_account_margin') })
      .alignItems(VerticalAlign.Center)
      .width(CommonConstants.FULL_PARENT)
      .height(200)
      .backgroundColor(Color.White)
      .padding({ left: $r('app.float.setting_account_padding') })
      .borderRadius($r('app.float.setting_account_borderRadius'))

      /*Text("schedule02")
        .height(56)
        .textAlign(TextAlign.Start)
        .fontSize(24)
        .width("100%")
        .fontColor($r('app.color.grey_divider'))
          //.fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })
        .padding({ left: 24})*/


    }
    .width("100%")
    .height("100%")
    .backgroundColor($r('app.color.grey_light'))
  }
}

/*


import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants2';
import AlarmItem from '../viewmodel/AlarmItem';
import { MainConstant } from '../common/constants/MainConstant';
import MainModel from '../viewmodel/MainViewModel2';
import ClockArea from './../view/Main/ClockArea';
import AlarmList from './../view/Main/AlarmList';
import DimensionUtil from '../common/utils/DimensionUtil';
import { http_common } from './dataManager'

@Entry
@Component
struct MainIndex {
  private mainModel: MainModel = MainModel.instant;
  @State alarmItems: Array<AlarmItem> = new Array();
  @State history_data:Object[] = [{},{},{}];

   aboutToAppear() {
      let that = this;
      that.mainModel.queryAlarmsTasker((alarms: Array<AlarmItem>) => {
        that.alarmItems = alarms;
      })
    }


  build() {
    Column() {
      ForEach(this.history_data,(index:number[])=>{
        Row() {

        }
      })
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r('app.color.grey_light'))
  }
}

@Component
struct alist(){
  @State data:number = 0

  build(){

  }
}

*/
