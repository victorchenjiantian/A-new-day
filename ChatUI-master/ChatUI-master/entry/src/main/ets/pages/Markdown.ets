import { Chat, ChatRole, ChatMessage } from '@changwei/chatui'
import router from '@ohos.router';

@Entry
@Component
struct Markdown {
  @State needBackButton: boolean = false

  build() {
    Row() {
      Column() {
        Chat({
          title: '默认UI',
          useMarkdown: true,
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
                content: '## 这是一条测试列表\n - item 1\n- item 2\n![图片](https://gitee.com/changweizhang/ChatUI/raw/master/demo.gif)'
              }), false)
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