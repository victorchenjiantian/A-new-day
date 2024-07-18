import { Chat, ChatRole, ChatMessage } from '@changwei/chatui'
import router from '@ohos.router';

@Entry
@Component
struct ChatUI {
  @State needBackButton: boolean = false

  build() {
    Row() {
      Column() {
        Chat({
          title: '默认UI',
          needBackButton: this.needBackButton,
          onSendMessage: (ctl, message) => {
            //发送用户消息
            ctl.postMessage(message)
            //显示回复等待动画
            ctl.setTyping(true)
            //3秒后发送chatbot响应消息
            setTimeout(() => {
              ctl.postMessage(new ChatMessage({
                role: ChatRole.Assistant,
                content: '这是一条测试回复'
              }))
              ctl.postMessage(new ChatMessage({
                role:ChatRole.Assistant,
                picurl:"https://foruda.gitee.com/avatar/1709712450038093632/8548349_changweizhang_1709712449.png"
              }));
            }, 3000)
          }

        })

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