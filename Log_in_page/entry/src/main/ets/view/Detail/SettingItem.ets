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

import { CommonConstants } from '../../common/constants/CommonConstants2';
import { AlarmSettingType } from '../../common/constants/AlarmSettingType';
import AlarmSettingItem from '../../viewmodel/AlarmSettingItem';
import DimensionUtil from '../../common/utils/DimensionUtil';
import IntervalDialog from './dialog/IntervalDialog';
import DurationDialog from './dialog/DurationDialog';
import RenameDialog from './dialog/RenameDialog';
import RepeatDialog from './dialog/RepeatDialog';

@Component
export default struct SettingItem {
  @Link settingInfo: Array<AlarmSettingItem>;
  repeatDialogController: CustomDialogController = new CustomDialogController({
    builder: RepeatDialog(),
    autoCancel: true
  });
  reNameDialogController: CustomDialogController = new CustomDialogController({
    builder: RenameDialog(),
    autoCancel: true
  });
  durationDialogController: CustomDialogController = new CustomDialogController({
    builder: DurationDialog(),
    autoCancel: true
  });
  intervalDialogController: CustomDialogController = new CustomDialogController({
    builder: IntervalDialog(),
    autoCancel: true
  });

  private showSettingDialog(sType: AlarmSettingType) {
    switch (sType) {
      case AlarmSettingType.REPEAT:
        this.repeatDialogController.open();
        break;
      case AlarmSettingType.ALARM_NAME:
        this.reNameDialogController.open();
        break;
      case AlarmSettingType.RING_DURATION:
        this.durationDialogController.open();
        break;
      case AlarmSettingType.INTERVAL:
        this.intervalDialogController.open();
        break;
      default:
        break
    }
  }

  build() {
    Column() {
      ForEach(this.settingInfo, (item: AlarmSettingItem, index: number | undefined) => {
        Divider()
          .visibility(index === 0 ? Visibility.Hidden : Visibility.Visible)
          .opacity($r('app.float.divider_opacity'))
          .color($r('app.color.grey_divider'))
          .lineCap(LineCapStyle.Round)
          .margin({
            left: 12,
            right: 12
          })
        Row() {
          Text(item.title)
            .fontSize(16)
            .fontWeight(FontWeight.Regular)
            .fontColor($r('app.color.grey_divider'))
            .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
          Text(item.content)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor($r('app.color.grey_divider'))
            .opacity($r('app.float.setting_item_content_font_opacity'))
          Image($r('app.media.ic_right'))
            .width(6.7)
            .height(12.8)
            .objectFit(ImageFit.Fill)
            .margin({
              left: 7
            })
        }
        .height(56)
        .alignItems(VerticalAlign.Center)
        .padding({
          left: 12,
          right: 12
        })
        .onClick(() => {
          this.showSettingDialog(item.sType);
        })
      }, (item: AlarmSettingItem, index: number | undefined) => JSON.stringify(item) + index)
    }
    .margin({
      bottom: 12,
      left: 12,
      right: 12
    })
    .borderRadius(24)
    .backgroundColor(Color.White)
  }
}