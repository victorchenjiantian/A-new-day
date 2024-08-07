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
import DimensionUtil from '../common/utils/DimensionUtil';

@Component
export default struct BackContainer {
  private header: string | Resource = $r('app.string.new_alarm');
  private backImgRes: string | Resource = $r('app.media.ic_cancel');
  private backFunc?: () => void;
  @BuilderParam closer?: () => void;

  build() {
    Row() {
      Button() {
        Image(this.backImgRes == null ? $r('app.media.ic_public_back') : this.backImgRes).objectFit(ImageFit.Fill)
      }
      .backgroundColor($r('app.color.trans_parent'))
      .width(24)
      .height(24)
      .onClick(() => {
          this.backFunc ? this.backFunc() : router.back();
      })

      Text(this.header)
        .fontSize(20)
        .lineHeight(28)
        .margin({ left: 16 })
        .fontColor($r('app.color.grey_divider'))
        .fontWeight(FontWeight.Bold)
      Blank()
      if (this.closer) {
        this.closer();
      }
    }
    .padding({
      left: 24,
      right: 24
    })
    .height(56)
    .width(CommonConstants.FULL_LENGTH)
  }
}