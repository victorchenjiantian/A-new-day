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
  @State history_data:Object = JSON.parse(http_common("1",{asd})) ;

   aboutToAppear() {
      let that = this;
      that.mainModel.queryAlarmsTasker((alarms: Array<AlarmItem>) => {
        that.alarmItems = alarms;
      })
    }
    */

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