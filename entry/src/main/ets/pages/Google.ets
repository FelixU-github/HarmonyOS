// Google.ets
import { promptAction, router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
@Entry
@Component
struct Index {
  @State message: string = 'This is Google login page.'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button() {
          Text('Login')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }

        .type(ButtonType.Normal)
        .borderRadius(20)
        .margin({
          top: 400,
          bottom: 40
        })
        .backgroundColor('#ff2d2dc4')
        .width('80%')
        .height(50)
        .shadow({ radius: 10, color: '#0000ff'})

        .onClick(() => {
          router.pushUrl({
            url: 'pages/Home' // 目标url
          }, router.RouterMode.Standard, (err) => {
            if (err) {
              console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
              return;
            }
            console.info('Invoke pushUrl succeeded.');
          });
        })


      }
      .width('100%')
    }
    .height('100%')
  }
}