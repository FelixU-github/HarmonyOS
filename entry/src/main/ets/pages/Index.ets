// Index.ets
import {router ,promptAction} from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit';



@Entry
@Component
struct Index {





  build() {
    Column() {

      // Row(){
      //   Image($r('app.media.close'))
      //     .width('6%')
      //   Image($r('app.media.share'))
      //     .width('6%')
      // }
      // .width('100%')
      // .height(40)
      // .justifyContent(FlexAlign.SpaceBetween)
      // .backgroundColor('#DCDCDC')

      // This is LOGO
      Column({space:20}) {
        Image($r('app.media.HIT'))
          .width('80%')
          .margin({
            top: 40,
            bottom: 10
          })

        Column({space:20}){
          Text('Login to your Account')
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontSize(20)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .margin({
              top: 20,
              left:80,
              bottom:10
            })

          TextInput({
            placeholder: 'Username',
          })
            .width('80%')
            .height(50)
            .shadow({ radius: 10, color: Color.Gray })
            .borderRadius(20)

          TextInput({
            placeholder: 'Password',
          })
            .type(InputType.Password)
            .width('80%')
            .height(50)
            .shadow({ radius: 10, color: Color.Gray })
            .borderRadius(20)

          // 按钮，响应用户点击
          Button() {
            Text('Login')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .type(ButtonType.Normal)
          .borderRadius(20)
          .margin({
            top: 0,
            bottom: 40
          })
          .backgroundColor('#ff2d2dc4')
          .width('80%')
          .height(50)
          .shadow({ radius: 10, color: '#0000ff'})

          // Login
          .onClick(()=>{
            setTimeout(()=>{
              promptAction.showToast({ message: '登录成功' })
            },1000)
              promptAction.showToast({ message: '正在登录' })

            setTimeout(()=>{
              // 使用replaceUrl，销毁登录页，释放内存.
              router.pushUrl({ url: 'pages/Home'}).then(()=>{
                console.info('Succeeded in jumping to the second page')
              }).catch((err:BusinessError)=>{
                console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
              })
            },2000)
          })
        }
        .margin({ top:30 })

          Column({space:20}){
            Text('-Or sign in with-')
              .fontColor('#8a8a8a')
              .margin({
                bottom:20
              })
            Row({space:10}){
              Image($r('app.media.GoogleLogo'))
                .width('25%')
                .shadow({ radius: 30, color: '#cdcdcd' })
                .borderRadius(10)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/Google' // 目标url
                  }, router.RouterMode.Standard, (err) => {
                    if (err) {
                      console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                      return;
                    }
                    console.info('Invoke pushUrl succeeded.');
                  });
                })

              Image($r('app.media.WechatLogo'))
                .width('25%')
                .shadow({ radius: 30, color: '#cdcdcd' })
                .borderRadius(10)
              Image($r('app.media.GitHubLogo'))
                .width('25%')
                .shadow({ radius: 30, color: '#cdcdcd' })
                .borderRadius(10)
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/Github' // 目标url
                  }, router.RouterMode.Standard, (err) => {
                    if (err) {
                      console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                      return;
                    }
                    console.info('Invoke pushUrl succeeded.');
                  });
                })
            }
          }.margin({
            top:5,
            bottom: 45

          })
            Row({space:40}){
              Text('-Forgot password ?')
                .fontSize(15)
                .fontColor('#ff1111a9')
                .fontWeight(FontWeight.Medium)
                .onClick(()=>{
                  console.info('Succeeded in clicking the \'Forgot password\' button')
                  router.pushUrl({
                    url: 'pages/Forgot' // 目标url
                  }, router.RouterMode.Standard, (err) => {
                    if (err) {
                      console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                      return;
                    }
                    console.info('Invoke pushUrl succeeded.');
                  });
                })

              Text('Sign up-')
                .fontSize(15)
                .fontColor('#ff1111a9')
                .fontWeight(FontWeight.Medium)
                .onClick(()=>{
                  console.info('Succeeded in clicking the \'Sign up\' button')
                  router.pushUrl({
                    url: 'pages/Signup' // 目标url
                  }, router.RouterMode.Standard, (err) => {
                    if (err) {
                      console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                      return;
                    }
                    console.info('Invoke pushUrl succeeded.');
                  });
                })
            }
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#fff8f8fc')
  }
}