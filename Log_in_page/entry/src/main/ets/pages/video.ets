
@Entry
@Component
struct video{

  controller = new WebController();
  build(){
    Column(){
      Web({src: "http://172.18.2.28:8080",controller:this.controller})
        .width("100%")
        .width("100%")
      Button("上")
        .position({ x:160 , y: 390 })
        .onClick(()=>{
        }).backgroundColor(Color.Black)
      Button("右")
        .position({ x:230 , y: 430 })
        .onClick(()=>{
        }).backgroundColor(Color.Black)
      Button("左")
        .position({ x:90 , y: 430 })
        .onClick(()=>{
        })
        .backgroundColor(Color.Black)
      Button("下")
        .position({ x:160 , y: 470 })
        .onClick(()=>{
        }).backgroundColor(Color.Black)

    }
    .width("100%")
    .height("100%")
  }
}