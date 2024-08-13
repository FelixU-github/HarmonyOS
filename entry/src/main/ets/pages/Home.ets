// Home.ets
import { router , promptAction} from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';


interface University {
  alpha_two_code: string;
  name: string;
  domains: string[];
  country: string;
  state_province: string | null;
  web_pages: string[];
}

@Entry
@Component
struct Home {
  @State currentIndex: number = 0
  controller: TabsController = new TabsController();

  @Builder LabelImage(label: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({width: 25})
      Text(label)
        .fontColor(this.currentIndex === targetIndex ? '#1296db' : '#8a8a8a')
      .fontSize(12)
    }
    .onClick(() => {
      this.currentIndex = targetIndex
      this.controller.changeIndex(this.currentIndex)
    })
    .backgroundColor('#FFFFFF')
    .width('100%')
    .height('100%')

  }

  @State keyword: string = ''
  @State count: number = 0


  build() {
    Column() {

      Row(){
        Image($r('app.media.exit'))
          .width('6%')
          .margin({left: 10})
          .onClick(() => {
            router.back({
              url: 'pages/Index'
            })
          })
        Text('Hi Hit')
        Image($r('app.media.share'))
          .width('6%')
          .margin({right: 10})
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .shadow({ radius: 5, color: '#696969' ,offsetY: 5})
      .backgroundColor('#ffffff')
      .width('100%')
      .height(40)
      .align(Alignment.Top)

      Tabs({ controller: this.controller ,barPosition: BarPosition.End}){

        TabContent(){


          Stack({ alignContent: Alignment.Bottom }) {

            Flex({ wrap: FlexWrap.Wrap }) {
              Row(){
                Search({ placeholder: '搜索'})
                  .searchButton('SEARCH')
                  .onChange((value) => {
                    this.keyword = value
                  })
                  .width('95%')
                  .height(40)
                  .margin({left:10,right:10,top:10})
              }

              Column(){
                Swiper() {
                  Image($r('app.media.hitposter1'))
                    .width('100%')
                    .height('100%')
                    .backgroundColor(Color.Gray)
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})

                  Image($r('app.media.hitposter2'))
                    .width('100%')
                    .height('100%')
                    .backgroundColor(Color.Green)
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})


                  Image($r('app.media.hitposter3'))
                    .width('100%')
                    .height('100%')
                    .backgroundColor(Color.Pink)
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                }
                .loop(true)
              }
              .height(180)
              .width("95%")
              .margin(10)
              .borderRadius(10)
              .shadow({ radius: 10, color: '#ff000000'})

            Column(){
              Row(){
                Text('最近使用 |')
                  .fontSize(12)
                  .textAlign(TextAlign.Start)
                  .margin({left:10,right:5})
                  .fontColor('#ff000000')

                Text('日常办公')
                  .fontSize(12)
                  .textAlign(TextAlign.Start)
                  .margin({right:230})
                  .fontColor('#A9A9A9')

              }
              .justifyContent(FlexAlign.Start)
              .margin({top:5,left:8,bottom:2})


              Row({space:5}){
                Column(){
                  Image($r('app.media.Uni'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                    .onClick(() => {
                      router.pushUrl({
                        url: 'pages/Search' // 目标url
                      }, router.RouterMode.Standard, (err) => {
                        if (err) {
                          console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                          return;
                        }
                        console.info('Invoke pushUrl succeeded.');
                      });
                    })
                  Text('找大学')
                    .fontSize(14)
                }

                Column(){
                  Image($r('app.media.Cat'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                    .onClick(() => {
                      router.pushUrl({
                        url: 'pages/MyCat' // 目标url
                      }, router.RouterMode.Standard, (err) => {
                        if (err) {
                          console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                          return;
                        }
                        console.info('Invoke pushUrl succeeded.');
                      });
                    })
                  Text('找猫咪')
                    .fontSize(14)
                }

                Column(){
                  Image($r('app.media.GoogleLogo'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('日历')
                    .fontSize(14)
                }
                Column(){
                  Image($r('app.media.GoogleLogo'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('日历')
                    .fontSize(14)
                }
                Column(){
                  Image($r('app.media.GoogleLogo'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('日历')
                    .fontSize(14)
                }
              }

              .margin({left:4,right:4})

              Row({space:5}){
                Column(){
                  Image($r('app.media.GoogleLogo'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('日历')
                    .fontSize(14)
                }

                Column(){
                  Image($r('app.media.GoogleLogo'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                    .onClick(() => {
                      router.pushUrl({
                        url: 'pages/MyCat' // 目标url
                      }, router.RouterMode.Standard, (err) => {
                        if (err) {
                          console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                          return;
                        }
                        console.info('Invoke pushUrl succeeded.');
                      });
                    })
                  Text('日历')
                    .fontSize(14)
                }

                Column(){
                  Image($r('app.media.GoogleLogo'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('日历')
                    .fontSize(14)
                }
                Column(){
                  Image($r('app.media.GoogleLogo'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('日历')
                    .fontSize(14)
                }
                Column(){
                  Image($r('app.media.GoogleLogo'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('更多')
                    .fontSize(14)
                }
              }
              .margin({left:4,right:4,top:5,bottom:5})

            }
            .backgroundColor('#ffffffff')
            .shadow({ radius: 10, color: '#C0C0C0'})
            .borderRadius(10)
              .width('95%')
              .margin({left:10,right:10})


          Column(){

          }
          .backgroundColor('#ffffffff')
          .shadow({ radius: 10, color: '#C0C0C0'})
          .borderRadius(10)
          .width('95%')
          .margin({left:10,right:10})

            }.width('100%').height('100%') // 这是首页的容器

          }
          .backgroundColor('#fff8f8fc')
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height('100%')
        .tabBar(this.LabelImage('首页', 0, $r('app.media.home_selected'), $r('app.media.home_normal')))


        TabContent(){ // 这是第二个页面

          Column(){

          }

        }
        .width('100%')
        .height('50%')
        .tabBar(this.LabelImage('发现', 1, $r("app.media.find_selected"), $r("app.media.find_normal")))


        TabContent(){
          Text('123test')

        }
        .width('100%')
        .height('100%')
        .tabBar(this.LabelImage('我的', 2, $r('app.media.user_selected'), $r('app.media.user_normal')))


      }


    }
    .height('100%')
    .backgroundColor('#CFD0CF')
  }
}