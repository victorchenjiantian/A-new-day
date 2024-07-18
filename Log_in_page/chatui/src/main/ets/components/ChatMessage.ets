// 消息格式
import { ChatRole } from '../common/ChatConfig'
interface IChatMessage{
  name?:string
  content?:string
  picurl?:string
  role:ChatRole

}


class ChatMessage implements IChatMessage{
  name?:string
  picurl?:string
  content?:string //|string[]
  role:ChatRole
  // constructor(mRole:ChatRole,mContent?:string,mName?:string,picUrl?:string) {
  //   this.content=mContent
  //   this.role=mRole
  //   this.name=mName
  //   this.picurl=picUrl
  // }
  constructor(data:IChatMessage) {
    this.content=data.content
    this.role=data.role
    this.name=data.name
    this.picurl=data.picurl
  }
}

export {IChatMessage,ChatMessage}


