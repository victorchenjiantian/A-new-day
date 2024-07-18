
@Entry
@Component
struct video{

  controller = new WebController();
  build(){
    Column(){
      Web({src: "http://172.18.2.28:8080",controller:this.controller})
        .width("100%")
        .width("100%")

    }
    .width("100%")
    .height("100%")
  }
}