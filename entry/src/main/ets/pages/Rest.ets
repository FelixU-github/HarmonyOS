import { FunctionalButton } from '@hms.core.atomicserviceComponent.atomicserviceUi'

@Entry
@Component
struct ImageExample1 {
  @State widthSize: number = 500
  @State heightSize: number = 200
  @State fontSize: number = 30
  @State fontColor: Color = Color.Black
  @State imageSize: boolean = false;
  @State flag: boolean = true
  @State message: string = '功德+1';
  @State backColor :Color = Color.Black


  build() {
    Column({ space: 3 }) {
      Column() {
        Text(this.message)
          .width("100%")
          .height("100%")
          .fontSize(this.fontSize)
          .fontColor(this.fontColor)
          .textAlign(TextAlign.Center)
          .backgroundColor(this.backColor)

          .onClick(() => {
            if (this.flag) {
              this.backColor = Color.Black
            } else {
              this.backColor = Color.White
            }
            this.flag = !this.flag
          })
          .animation({
            duration: 2000,
            curve: Curve.EaseOut,
            iterations:3,
            playMode: PlayMode.Normal
          })

      }.width("100%").height( "50")
      Column(){


        Stack(){

          // 加载png格式图片
          Image($r('app.media.Wooden_Fish'))
            .onClick(() => {
              if (this.flag) {
                this.widthSize = 700
                this.heightSize = 200
                this.fontSize = 100
                this.backColor = Color.Red
              } else {
                this.widthSize = 500
                this.heightSize = 200
                this.fontSize = 150
                this.backColor = Color.White
              }
              this.flag = !this.flag
            })
            .width(this.widthSize)
            .height(this.heightSize)
            .margin(10)
            .align(Alignment.Center)
            .animation({
              duration: 500,
              curve: Curve.EaseOut,
              iterations: -1,
              playMode: PlayMode.Alternate
            })



        }.width("100%").height("70%")
      }

      Column() {

        Button("功德+1").width(300).height(80)
          .onClick(() => {
            console.log('on click')
            if (this.flag) {
              this.widthSize = 700
              this.heightSize = 200
              this.backColor = Color.Black
            } else {
              this.widthSize = 500
              this.heightSize = 200
              this.backColor = Color.White
            }
            this.flag = !this.flag
          })

          .backgroundColor(Color.Gray)
          .fontSize(20)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .stateEffect(true)
      }
      Column() {
        Button("Auto功德+1").width(300).height(80)
          .onClick(() => {
            console.log('on click')
            if (this.flag) {
              this.widthSize = 700
              this.heightSize = 200
            } else {
              this.widthSize = 500
              this.heightSize = 200
            }
            this.flag = !this.flag
          })


          .backgroundColor(Color.Gray)
          .fontSize(20)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .stateEffect(true)
      }
    }.width("100%").height("100%").backgroundColor(Color.Black)
  }

}
