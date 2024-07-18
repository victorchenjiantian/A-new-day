import { Chat, ChatRole, ChatMessage } from '@changwei/chatui'
import router from '@ohos.router';

@Entry
@Component
struct Index {
  build() {
    Row() {
      Column() {
        Navigation() {
          List({ space: 20 }) {
            ListItem() {
              Column() {
                Text('@changwei/chatui 是一个ArkTS编写的HarmonyOS原生聊天UI框架，提供了开箱即用的聊天对话组件。UI可定制,支持大量消息懒加载绑定,性能卓越')
                  .width('100%')
                  .padding({left:20,right:20})
              }
              .alignItems(HorizontalAlign.Center)
              .alignSelf(ItemAlign.Center)
            }
            ListItem() {
              Button('默认聊天UI')
                .width("100%")
                .borderRadius(24)
                .fontSize(16)
                .fontWeight(500)
                .onClick((evt) => {
                  router.pushUrl({
                    url: 'pages/ChatUI',
                    params: {
                      needBackButton: true
                    }
                  })
                })

            }
            .width("90%")
            .margin({ left: 12 })


            ListItem() {
              Button('自定义聊天UI')
                .width('100%')
                .onClick((evt) => {
                  router.pushUrl({
                    url: 'pages/CustomInput',
                    params: {
                      needBackButton: true
                    }
                  })

                })
            }
            .width("90%")
            .margin({ left: 12 })

            ListItem() {
              Button('Markdown消息')
                .width('100%')
                .onClick((evt) => {
                  router.pushUrl({
                    url: 'pages/Markdown',
                    params: {
                      needBackButton: true
                    }
                  })

                })
            }
            .width("90%")
            .margin({ left: 12 })
          }
        }
        .title('ChatUI示例')
        .mode(NavigationMode.Auto)

      }

    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}