import { Chat, ChatRole, ChatMessage } from '@changwei/chatui'
import { ChatController } from '@changwei/chatui'
import router from '@ohos.router';

@Entry
@Component
struct CustomInput {
  @State userInput: string = ''
  @State needBackButton: boolean = false
  chatController = new ChatController()

  build() {
    Row() {
      Column() {
        Chat({
          title: 'demo chatbot',
          needTitleBar: true,
          welcomeMessage: '我是你的测试bot',
          botMessageBackgroundColor: Color.Brown,
          botMessageTextColor: Color.White,
          userMessageBackgroundColor: Color.Green,
          userMessageTextColor: Color.White,
          botAvatar: $r('app.media.chat'),
          messageFontSize: 20,
          controller: this.chatController,
          needBackButton: this.needBackButton,
          onSendMessage: (ctl, message) => {
            //发送用户消息
            ctl.postMessage(message)
            this.userInput = ''
            //显示回复等待动画
            ctl.setTyping(true)
            //3秒后发送chatbot响应消息
            setTimeout(() => {
              ctl.postMessage(new ChatMessage({
                role: ChatRole.Assistant,
                content: '这是一条测试回复'
              }), false)
            }, 3000)
          }
        }) {
          Row() {
            Button() {
              Image($r('app.media.app_icon'))
            }
            .backgroundColor('#')
            .height('40')
            .width('40')
            .margin(5)

            TextInput({
              text: this.userInput
            })
              .enterKeyType(EnterKeyType.Send)
              .fontColor(Color.White)
              .backgroundColor(Color.Blue)
              .width('80%')
              .onChange((val) => {
                this.userInput = val
              })
              .onSubmit((ss) => {
                this.chatController.submitUserInput(this.userInput)
              })

          }
        }

      }
    }
    .height('100%')
  }

  aboutToAppear() {
    const params = router.getParams(); // 获取传递过来的参数对象
    if (params) {
      this.needBackButton = params['needBackButton']
    }
  }
}