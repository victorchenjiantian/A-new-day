import socket from '@ohos.net.socket';
import connection from '@ohos.net.connection';
import wifi from '@ohos.wifi';
import display from '@ohos.display';

// 创建一个TCPSocket连接，返回一个TCPSocket对象。
let tcp = socket.constructTCPSocketInstance();
let ipAddress=wifi.getIpInfo().ipAddress
let ip=(ipAddress>>>24)+'.'+(ipAddress>>16&0xFF)+'.'+(ipAddress>>>8&0xFF)+'.'+(ipAddress&0xFF);
//console.log("aaaaaaaaa:"+ip)

let tcp_message_from_py = ""
let bindAddress = {
  address:ip,
  port: 7777, // 绑定端口，如1234
  family: 1
};

let connectAddress = {
  address: '172.18.30.161',
  port: 7777, // 连接端口，如5678
  family: 1
};

// console.info("ipaddr"+ip)
@Entry
@Component
struct TCPsocket {
  @State message: string = ip //'hello'
  @State message_from_python: string ="" //add by gyh

  aboutToAppear(){

    tcp.on('message', value => {
      console.log("_s_on message")
      let buffer = value.message
      let dataView = new DataView(buffer)
      let str = ""  //add by gyh

      for (let i = 0; i < dataView.byteLength; ++i) {
        str += String.fromCharCode(dataView.getUint8(i))
      }
      this.message_from_python = str //add by gyh

      console.log("_s_on connect received:" + str)
    });
    tcp.on('connect', () => {
      console.log("_s_on connect")
    });
    tcp.on('close', () => {
      console.log("_s_on close")
    });

  }

  build() {
    Row() {
      Column({space:10}) {

        Text(this.message )

        Button("open").width(150).height(75).fontSize(60)
          .onClick(()=>{

            tcp.bind(bindAddress, err => {
              tcp.connect({
                address: connectAddress, timeout: 6000
              }, err => {
                tcp.send({
                  data: this.message
                }, err => {
                  console.log('_s_send  '+`${this.message}`+' success');
                })
              });
            });
            setTimeout(() => {
              tcp.close((err) => {
                console.log('close socket.')
              });
              tcp.off('message');
              tcp.off('connect');
              tcp.off('close');
            }, 10 * 1000);
            this.message = 'received from py:' + this.message_from_python //add by gyh
          })
        Button("new").width(200).height(200).fontSize(60).type(ButtonType.Normal).onClick(()=>{
          this.message="new"
        })
        Button("close").width(300).height(150).fontSize(80)

          .onClick(()=>{
            this.message='off'
            tcp.bind(bindAddress, err => {
              tcp.connect({
                address: connectAddress, timeout: 6000
              }, err => {
                tcp.send({
                  data: this.message
                }, err => {
                  console.log('send  '+`${this.message}`+' success');
                })
              });
            });
            setTimeout(() => {
              tcp.close((err) => {
                console.log('close socket.')
              });
              tcp.off('message');
              tcp.off('connect');
              tcp.off('close');
            }, 10 * 1000);
          })

      }
      .width('100%')
    }
    .height('100%')
  }
}
