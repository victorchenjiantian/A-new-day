import { ChatConfig, ChatRole } from '../common/ChatConfig';
import { IChatMessage, ChatMessage } from './ChatMessage'

interface IChatDataSource extends IDataSource {
  addData(index: number, data: IChatMessage): void

  pushData(data: ChatMessage): void

  updateData(index: number, data: IChatMessage): void

  clearData(): void

  removeData(index: number): void
}

class ChatDataSource implements IChatDataSource {
  private originDataArray: IChatMessage[] = [];
  private listeners: DataChangeListener[] = [];




  public getAllData(): IChatMessage[] {
    return this.originDataArray;
  }

  removeData(index: Number): void {
    this.originDataArray = this.originDataArray.slice(0, -2)
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  getData(index: number) {
    return this.originDataArray[index];
  }

  totalCount(): number {
    return this.originDataArray.length;
  }
  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    })
  }

  public addData(index: number, data: IChatMessage): void {
    this.originDataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: ChatMessage): void {
    this.originDataArray.push(data);
    this.notifyDataAdd(this.originDataArray.length - 1);
  }

  public updateData(index: number, data: IChatMessage): void {
    if (this.originDataArray.length <= index) {
      this.originDataArray.push(data)
    }
    else {
      this.originDataArray[index].role = data.role
      this.originDataArray[index].content = data.content;
      this.originDataArray[index].name = data.name
    }
    this.notifyDataChange(index)
  }

  public clearData(): void {
    this.originDataArray = []
    //this.setDefaultMessage()
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }
}

export { ChatDataSource, IChatDataSource }