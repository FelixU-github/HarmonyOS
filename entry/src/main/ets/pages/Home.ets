// Home.ets
import { router , promptAction} from '@kit.ArkUI';

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
    .backgroundColor('#ffffffff')
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
      .backgroundColor('#ffffffff')
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
                  .onClick(() => {
                    if(this.keyword === ''){
                      promptAction.showToast({message: '请输入想要查找的内容'})
                    }else {
                      promptAction.showToast({message: '未查找到'+this.keyword+'内容'})
                    }
                  })
                  .width('95%')
                  .height(40)
                  .margin({left:10,right:10,top:10})
              }

              Column(){
                Swiper() {
                  Image($r('app.media.hit_poster1'))
                    .width('100%')
                    .height('100%')
                    .backgroundColor(Color.Gray)
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})

                  Image($r('app.media.hit_poster2'))
                    .width('100%')
                    .height('100%')
                    .backgroundColor(Color.Green)
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})


                  Image($r('app.media.hit_poster3'))
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
                  .fontColor('#ff00000')

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
                    .fontSize(12)
                }

                Column(){
                  Image($r('app.media.CatDog'))
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
                  Text('看猫狗')
                    .fontSize(12)
                }

                Column(){
                  Image($r('app.media.Rest'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('打坐')
                    .fontSize(12)
                }

                Column(){
                  Image($r('app.media.Map'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('校园地图')
                    .fontSize(12)
                }

                Column(){
                  Image($r('app.media.Forum'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('论坛')
                    .fontSize(12)
                }
              }

              .margin({left:4,right:4})

              Row({space:5}){
                Column(){
                  Image($r('app.media.Lab'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('实验室')
                    .fontSize(12)
                }

                Column(){
                  Image($r('app.media.Benefit'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('爱公益')
                    .fontSize(12)
                }

                Column(){
                  Image($r('app.media.Notice'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('校园热榜')
                    .fontSize(12)
                }
                Column(){
                  Image($r('app.media.Calender'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('校历')
                    .fontSize(12)
                }
                Column(){
                  Image($r('app.media.More1'))
                    .width(50)
                    .height(50)
                    .margin({left:5,right:5,bottom:5,top:2})
                    .borderRadius(10)
                    .shadow({ radius: 10, color: '#C0C0C0'})
                  Text('更多')
                    .fontSize(12)
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
            Tabs({ barPosition: BarPosition.Start }) {
              // TabContent的内容:首页、发现、推荐、我的
              TabContent() {
                Flex({ wrap: FlexWrap.Wrap }) {
                  Text('首页的内容').fontSize(30)
                }


              }
              .tabBar('首页')

              TabContent() {
                Text('推荐的内容').fontSize(30)
              }
              .tabBar('推荐')

              TabContent() {
                Text('发现的内容').fontSize(30)
              }
              .tabBar('发现')

              TabContent() {
                Text('我的内容').fontSize(30)
              }
              .tabBar("我的")
            }
            .vertical(true)
            .barWidth(100)
            .barHeight(200)

          }

        }
        .width('100%')
        .height('50%')
        .tabBar(this.LabelImage('发现', 1, $r("app.media.find_selected"), $r("app.media.find_normal")))


        TabContent(){
          Column(){
            Row(){
              Image($r('app.media.img'))
                .width("15%")
                .shadow({ radius: 10, color: '#C0C0C0'})
                .borderRadius(50)
                .margin({left:30,right:10})

              Column(){
                Row(){
                  Text('大王叫我来巡山')
                    .fontSize(20)

                }
                .margin({left:10,right:10,top:30})

                Row(){
                  Text('ID：')
                    .fontColor("#808080")
                  Text('2023120253')
                    .fontColor("#808080")

                }
                .margin({left:-15,top:15})
              }
              .margin({right:-20,bottom:30})

              Row(){

                Image($r('app.media.QRCode'))
                .width(20)
                .margin({left:40})

                Image($r('app.media.More'))
                  .width(25)
                  .margin({left:10})
              }
              .margin({left:15})

            }
            .width('100%')
            .height(120)
            .backgroundColor("#ffffffff")
            .margin({left:10,right:10,top:-161})


            Row(){
              Image($r('app.media.Cloud'))
                .width(25)
                .margin({left:20})
              Text('云空间')
                .margin({left:20})
              Image($r('app.media.More'))
                .width(25)
                .margin({left:200})
            }
            .width('100%')
            .height(50)
            .backgroundColor("#ffffffff")
            .margin({top:10})

            Row(){
              Image($r('app.media.Moments'))
                .width(25)
                .margin({left:20})
              Text('朋友圈')
                .margin({left:20})
              Image($r('app.media.More'))
                .width(25)
                .margin({left:200})
            }
            .width('100%')
            .height(50)
            .backgroundColor("#ffffffff")
            .margin({top:1})

            Row(){
              Image($r('app.media.Notification'))
                .width(25)
                .margin({left:20})
              Text('我的消息')
                .margin({left:20})
              Image($r('app.media.More'))
                .width(25)
                .margin({left:185})
            }
            .width('100%')
            .height(50)
            .backgroundColor("#ffffffff")
            .margin({top:1})

            Row(){
              Image($r('app.media.Liking'))
                .width(25)
                .margin({left:20})
              Text('关注')
                .margin({left:20})
              Image($r('app.media.More'))
                .width(25)
                .margin({left:215})
            }
            .width('100%')
            .height(50)
            .backgroundColor("#ffffffff")
            .margin({top:1})

            Row(){
              Image($r('app.media.Wallet'))
                .width(25)
                .margin({left:20})
              Text('我的钱包')
                .margin({left:20})
              Image($r('app.media.More'))
                .width(25)
                .margin({left:185})
            }
            .width('100%')
            .height(50)
            .backgroundColor("#ffffffff")
            .margin({top:1})

            Row(){
              Image($r('app.media.Settings'))
                .width(25)
                .margin({left:20})
              Text('设置')
                .margin({left:20})
              Image($r('app.media.More'))
                .width(25)
                .margin({left:215})

            }
            .width('100%')
            .height(50)
            .backgroundColor("#ffffffff")
            .margin({top:10})

            Row(){
              Image($r('app.media.Service'))
                .width(25)
                .margin({left:20})
              Text('客服')
                .margin({left:20})
              Image($r('app.media.More'))
                .width(25)
                .margin({left:215})
            }
            .width('100%')
            .height(50)
            .backgroundColor("#ffffffff")
            .margin({top:1})

          }

        }
        .width('100%')
        .height('100%')
        .tabBar(this.LabelImage('我的', 2, $r('app.media.user_selected'), $r('app.media.user_normal')))


      }


    }
    .height('100%')
    .backgroundColor('#F8F8FF')
  }
}