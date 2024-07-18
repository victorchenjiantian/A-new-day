# ChatUI

## 简介

[ChatUI](https://gitee.com/changweizhang/ChatUI) ，是一个ArkTS编写的HarmonyOS原生聊天UI框架，提供了开箱即用的聊天对话组件。


![demo](https://gitee.com/changweizhang/ChatUI/raw/master/demo.gif) |![自定义UI](https://gitee.com/changweizhang/ChatUI/raw/master/customUI.gif)  | ![markdown消息](https://gitee.com/changweizhang/ChatUI/raw/master/markdown.gif)


[查看集成ChatGPT演示视频](https://www.ixigua.com/7325423931936997922)

## 下载安装

```javascript
ohpm install @changwei/chatui
```

OpenHarmony ohpm 环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://gitee.com/openharmony-tpc/docs/blob/master/OpenHarmony_har_usage.md)



## 接口和属性列表
接口列表

| **接口**                        | 参数                                                                                                                                                 | 功能         |
|-------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|------------|
| setTyping(isTyping)           | isTyping：布尔值                                                                                                                                       | 显示/隐藏消息加载动画      |
| postMessage(msg,clearInput)   | msg：[ChatMessage](https://gitee.com/changweizhang/ChatUI/blob/master/chatui/src/main/ets/components/ChatMessage.ets)类型<br />clearInput: boolean类型。 | 在对话界面中显示消息<br />指示展示消息时是否清空输入框内容，默认清除。 |
| submitUserInput(userIputText) | userIputText：string类型。                                                                                                                             | 触发Chat组件用户发送消息事件 |
| onSendMessage(callback)       | callback:(ctl,message)=>void                                                                                                                       | 用户发送输入消息回调事件 |
| onClear(callback)             | callback:(event)=>void  | 用户清空聊天记录回调事件|

属性列表

| **属性**                           | 描述                                                                        |
|----------------------------------|---------------------------------------------------------------------------|
| messages            | 聊天消息列表，[IChatDataSource](https://gitee.com/changweizhang/ChatUI/blob/master/chatui/src/main/ets/components/ChatDataSource.ets)类型。支持懒加载显示的数据源 |
| botAvatar              | chatbot头像（可选）。Resource类型                                                |
| userAvatar              | 我的头像（可选）。Resource类型                                                |
| title              | 标题栏标题。string类型                                               |
| needTitleBar             | 是否显示标题栏。boolean类型                                               |
| welcomeMessage              | chatbot默认欢迎语。string类型                                                |
| botMessageBackgroundColor | chatbot消息的背景颜色。string类型             |
| botMessageTextColor | chatbot消息的文本颜色。string类型                           |
| userMessageBackgroundColor | 用户消息的背景颜色。string类型 |
| userMessageTextColor | 用户消息的文本颜色。string类型 |
| messageFontSize | 消息文本的字体大小。number类型 |
| needBackButton | 是否显示顶部返回按钮。点击返回导航上一页。boolean类型 |
| needInputControl | 是否需要底部输入区域。 boolean类型 |
| InputControl | 底部输入区域，@BuilderParams类型。该区域可自定义为你自己的布局 |
| controller | 自定义输入控制器，自定义输入区时必填。[ChatController]([chatui/src/main/ets/components/Chat.ets · Codex/ChatUI - Gitee.com](https://gitee.com/changweizhang/ChatUI/blob/master/chatui/src/main/ets/components/Chat.ets))类型 |
| backIcon | 返回按钮图标。Resource类型 |
| clearChatIcon | 清楚聊天按钮图标。Resource类型 |
| submitButtonText | 提交消息按钮文本。string类型 |
| inputTextPlaceHolder | 输入框提示文本。string类型 |
| inputTextPlaceHolderColor | 输入框提示文本的颜色。string类型 |
| inputTextColor | 输入文本的颜色。string类型 |
| needSubmitButton | 是否显示提交消息按钮。boolean类型 |
| useMarkdown | 是否渲染markdown消息。boolean类型 |



## 使用示例

#### 这里演示简单的调用ChatUI组件

```typescript
import { Chat, ChatRole, ChatMessage } from '@changwei/chatui'

@Entry
@Component
struct Index {
  build() {
    Row() {
      Column() {
        Chat({
          title:'demo chatbot',
          welcomeMessage: '我是你的测试bot',
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
              // 图片消息
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
}
```



#### 深度定制聊天UI。替换输入区域为你自己的输入组件，替换头像，文本颜色等。



```typescript
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
          botAvatar:$r('app.media.chat'),
          messageFontSize: 20,
          userInput: this.userInput,
          controller: this.chatController,
          needBackButton:this.needBackButton,
          onSendMessage: (ctl, message) => {
            //发送用户消息
            ctl.postMessage(message)
            this.userInput = ''
            //显示回复等待动画
            ctl.setTyping(true)
            //3秒后发送chatbot响应消息
            setTimeout(() => {
              ctl.postMessage(new ChatMessage({role:ChatRole.Assistant, content:'这是一条测试回复'}))
            }, 3000)
          }
        })
        {
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
      if(params) {
        this.needBackButton = params['needBackButton']
      }
    }
}
```
#### 使用Markdown格式显示消息
```typescript
 Chat({useMarkdown:true})
```
markdown消息效果请看上面的demo gif

## 约束与限制

在下述版本验证通过：
DevEco Studio: 4.0.0.600, SDK: API9

## 贡献代码

使用过程中发现任何问题都可以提[Issue](https://gitee.com/changweizhang/ChatUI/issues) 给我 。

## 开源协议

本项目基于 [MIT](https://gitee.com/openharmony-sig/axios/blob/master/LICENSE) ，请自由地享受和参与开源。

## 联系我

B站 @[Changwei同学](https://space.bilibili.com/395257724)

抖音/西瓜 @梦断代码

**求点赞 求关注 求分享**