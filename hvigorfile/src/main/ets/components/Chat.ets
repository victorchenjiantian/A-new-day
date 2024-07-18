import { ChatMessage } from './ChatMessage'
import { ChatDataSource, IChatDataSource } from './ChatDataSource'
import inputMethod from '@ohos.inputMethod';
import { ChatConfig, ChatRole } from '../common/ChatConfig'
import font from '@ohos.font';
import router from '@ohos.router';
import { lvMarkdownIn } from '@luvi/lv-markdown-in'

interface IChatComponent {
  userInput: string

  //发送消息到UI
  //clearInput：指示是否清空输入框
  postMessage(msg: ChatMessage, clearInput?: boolean)

  setTyping(isTyping: boolean)

  submitUserInput(userIputText: string)
}

class ChatController {
  chatCtrl: IChatComponent

  submitUserInput(userIputText: string) {
    if (this.chatCtrl) {
      this.chatCtrl.submitUserInput(userIputText)
    }

  }
}


//@Preview
@Component
struct Chat {
  @State messages: IChatDataSource = new ChatDataSource();
  @State userInput: string = ''
  @State isResponding: boolean = false
  private listScroller: Scroller = new Scroller();
  public onClear?: (event?: ClickEvent) => void = null;
  public onSendMessage?: (ctl: IChatComponent, message: ChatMessage) => void = null;
  public botAvatar: Resource = $r('app.media.chatbot')
  public userAvatar: Resource = $r('app.media.me')
  public backIcon: Resource = $r('app.media.back')
  public clearChatIcon: Resource = $r('app.media.clear')
  @State title: string = "ChatBot"
  @State needTitleBar: boolean = true
  public welcomeMessage: string = "主人好，我是智能助理，你的贴心小助手~"
  //自定义消息颜色
  public botMessageBackgroundColor: ResourceColor = '#fff'
  public botMessageTextColor: ResourceColor = Color.Black
  public userMessageBackgroundColor: ResourceColor = '#96ed6a'
  public userMessageTextColor: ResourceColor = Color.Black
  public messageFontSize: number = 18
  public needSubmitButton: boolean = true
  public submitButtonText: string = "Send"
  public inputTextPlaceHolder: string = "Let's talk"
  public inputTextPlaceHolderColor: ResourceColor = "#999"
  public inputTextColor: ResourceColor = Color.Black
  @State needInputControl: boolean = true
  @State needBackButton: boolean = false
  public controller?: ChatController
  public useMarkdown: boolean = false

  submitUserInput(userIputText: string) {
    this.userInput = userIputText
    if (this.userInput && !this.isResponding) {
      if (this.onSendMessage) {
        this.isResponding = true
        this.onSendMessage(this, new ChatMessage({
          role: ChatRole.User,
          content: this.userInput
        }))
      }
    }
  }

  @BuilderParam InputControl: () => void = this.defaultInputText

  @Builder
  defaultInputText() {
    TextInput({
      placeholder: this.inputTextPlaceHolder,
      text: this.userInput
    })
      .fontColor(this.inputTextColor)
      .placeholderColor(this.inputTextPlaceHolderColor)
      .layoutWeight(1)
      .onChange((value: string) => {
        console.info(value);
        this.userInput = value;
      })
      .onSubmit((EnterKeyType) => {
        this.submitUserInput(this.userInput)
      })

    if (this.needSubmitButton) {
      Button(this.submitButtonText)
        .backgroundColor(0x317aff)
        .margin({ left: 10 })
        .width(60)
        .height(30)
        .onClick(() => {
          this.hideKeyboard()
          this.submitUserInput(this.userInput)
        })
    }
  }

  public setDefaultMessage(role: ChatRole, content: string) {
    if (content) {
      let systemMsg = new ChatMessage({
        role: role,
        content: content
      })
      this.messages.clearData();
      this.messages.pushData(systemMsg);
    } else {
      this.messages.clearData();
    }
  }

  //API 9接口，需要系统应用权限
  //API 10使用hideTextInput
  hideKeyboard() {
    let inputMethodController = inputMethod.getController();
    inputMethodController.hideSoftKeyboard()
  }

  //@State isTyping: boolean = false;

  setTyping(isTyping: boolean = false) {
    if (isTyping) {
      this.messages.pushData(new ChatMessage({
        role: ChatRole.Assistant,
        content: ""
      }))
      this.listScroller.scrollToIndex(this.messages.totalCount() - 1)
    } else {
      let lastMsg: ChatMessage = this.messages.getData(this.messages.totalCount() - 1)
      if (!lastMsg.content) {
        this.messages.removeData(this.messages.totalCount() - 1)
      }
    }
    this.isResponding = isTyping
  }

  postMessage(msg: ChatMessage, clearInput: boolean = true) {
    let lastMsg: ChatMessage = this.messages.getData(this.messages.totalCount() - 1)
    if (!lastMsg.content) {
      this.messages.updateData(this.messages.totalCount() - 1, msg)
    } else {
      this.messages.pushData(msg)
    }
    if (clearInput) {
      this.userInput = ''
    }
    this.listScroller.scrollToIndex(this.messages.totalCount() - 1)
    this.isResponding = false
  }

  aboutToAppear() {
    if (this.controller) {
      this.controller.chatCtrl = this
    }
    this.submitUserInput.bind(this)
    this.postMessage.bind(this)
    this.setTyping.bind(this)
    if (this.welcomeMessage) {
      this.setDefaultMessage(ChatRole.Assistant, this.welcomeMessage)
    }
  }

  build() {
    Column({ space: 0 }) {
      if (this.needTitleBar) {
        RelativeContainer() {
          Text(this.title)
            .fontWeight(FontWeight.Bold)
            .fontSize(20)
            .id('titleBar')
            .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              middle: { anchor: '__container__', align: HorizontalAlign.Center }
            })

          Button() {
            Image(this.clearChatIcon).width(30).height(30)
          }
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            right: { anchor: '__container__', align: HorizontalAlign.End }
          })
          .margin({ right: 10 })
          .id('clearBtn')
          .onClick((evt) => {
            this.onClear(evt);
            this.setDefaultMessage(ChatRole.Assistant, this.welcomeMessage)
          })
          .backgroundColor('#0fff')

          if (this.needBackButton) {
            Button() {
              Image(this.backIcon).width(30).height(30)
            }
            .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              left: { anchor: '__container__', align: HorizontalAlign.Start }
            })
            .margin({ left: 10 })
            .id('backBtn')
            .onClick(() => {
              router.back()
            })
            .backgroundColor('#0fff')
          }
        }
        .height(60)
        .border({ width: { top: 0, bottom: 1 }, color: '#999' })
        .width('100%')

      }
      List({ scroller: this.listScroller }) {
        LazyForEach(this.messages, (item: ChatMessage) => {
          ListItem() {

            if (item.role == ChatRole.User.toString()) {
              Row() {
                Blank()
                  .width(55)
                Column() {
                  if (item.picurl) {
                    Image(item.picurl)

                  } else {
                    if (this.useMarkdown) {
                      lvMarkdownIn({
                        text: item.content,
                        textStyle: {
                          textSize: this.messageFontSize,
                          textColor: this.userMessageTextColor as string,
                          textMarkBackground: '#00000000'
                        }
                      })

                    } else {
                      Text(item.content)
                        .fontSize(this.messageFontSize)
                        .textAlign(TextAlign.Start)
                        .width('100%')
                        .fontColor(this.userMessageTextColor)
                    }
                  }
                }
                .backgroundColor(this.userMessageBackgroundColor)
                .layoutWeight(1)
                //.height(80)
                .padding(15)
                .margin({ right: 15 })
                .borderRadius(5)

                Button() {
                  Image(this.userAvatar)
                    .width(40)
                    .height(40)
                }
                .type(ButtonType.Circle)
                .backgroundColor('#eee')
                .width(40)
                .height(40)
              }
              .justifyContent(FlexAlign.End)
              .padding(10)
              .alignItems(VerticalAlign.Top)
              .width('100%')
            } else {
              Row() {
                Button() {
                  Image(this.botAvatar)
                    .width(40)
                    .height(40)
                }
                .type(ButtonType.Circle)
                .width(40)
                .height(40)
                .backgroundColor(Color.Transparent)

                Column() {
                  if (this.isResponding && !item.content.length) {
                    LoadingProgress()
                      .color(this.botMessageTextColor)
                      .width(40)
                      .height(40)
                  } else {
                    if (item.picurl) {
                      Image(item.picurl)

                    } else {
                      if (this.useMarkdown) {
                        lvMarkdownIn({
                          text: item.content,
                          textStyle: {
                            textSize: this.messageFontSize,
                            textColor: this.userMessageTextColor as string,
                            textMarkBackground: '#00000000'
                          }
                        })
                      } else {
                        Text(item.content)
                          .fontSize(this.messageFontSize)
                          .textAlign(TextAlign.Start)
                          .width('100%')
                          .fontColor(this.botMessageTextColor)
                      }
                    }
                  }
                }
                .alignItems(HorizontalAlign.Start)
                .backgroundColor(this.botMessageBackgroundColor)
                .layoutWeight(1)
                //.height(80)
                .padding(15)
                .margin({ left: 15 })
                .borderRadius(5)

                Blank()
                  .width(55)
              }
              .alignItems(VerticalAlign.Top)
              .padding(10)
              .width('100%')
            }


          }

        })

      }
      .layoutWeight(1)
      .cachedCount(3)
      .scrollBar(BarState.Auto)

      if (this.needInputControl) {
        Row() {
          this.InputControl()

        }
        .margin({ bottom: 10 })
        .borderWidth({ top: 1 })
        .borderColor('#999')
        .padding(10)
        .width('100%')
        .height(60)
      }
    }

    .backgroundColor('#eee')
    .height('100%')
    .width('100%')
  }

  aboutToDisappear() {
    if (this.controller) {
      this.controller = null
    }

  }
}

export { Chat, IChatComponent, ChatController }