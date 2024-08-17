// Home.ets
import { router , promptAction} from '@kit.ArkUI';
class DividerTmp {
  strokeWidth: Length = 1
  startMargin: Length = 30
  endMargin: Length = 30
  color: ResourceColor = '#C0C0C0'

  constructor(strokeWidth: Length, startMargin: Length, endMargin: Length, color: ResourceColor) {
    this.strokeWidth = strokeWidth
    this.startMargin = startMargin
    this.endMargin = endMargin
    this.color = color
  }
  // startMargin和endMargin属性分别用于设置分隔线距离列表侧边起始端的距离和距离列表侧边结束端的距离。
}
@Entry
@Component
struct Home {
  @State egDivider: DividerTmp = new DividerTmp(0.5, 30, 45, '#C0C0C0')
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
  @State egLanes: LengthConstrain = { minLength: 200, maxLength: 300 }


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
      .borderWidth({left:0,right:0,top:0,bottom:0.1})
      .borderColor('#DCDCDC')
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
                } // 海报轮播图
                .loop(true)
                .autoPlay(true)
                .interval(3000)
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
                        url: 'pages/LikedCatDog' // 目标url
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
                    .onClick(() => {
                      router.pushUrl({
                        url: 'pages/Rest' // 目标url
                      }, router.RouterMode.Standard, (err) => {
                        if (err) {
                          console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
                          return;
                        }
                        console.info('Invoke pushUrl succeeded.');
                      });
                    })
                  Text('休息一下')
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
              } // app内容

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
              } // app 内容
              .margin({left:4,right:4,top:5,bottom:5})

            }
            .backgroundColor('#ffffffff')
            .shadow({ radius: 10, color: '#C0C0C0'})
            .borderRadius(10)
              .width('95%')
              .margin({left:10,right:10})


          Column(){
            Row(){
              Text('校园资讯 |')
                .fontSize(12)
                .textAlign(TextAlign.Start)
                .margin({left:10,right:5})
                .fontColor('#ff00000')

              Text('学校要闻')
                .fontSize(12)
                .textAlign(TextAlign.Start)
                .margin({right:230})
                .fontColor('#A9A9A9')

            }
            .justifyContent(FlexAlign.Start)
            .margin({top:10,left:8,bottom:2})

            List() {

              ListItem(){
                Row({ }) {
                  Text('通知')
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({left:20,right:1,bottom:5,top:10})
                  Text("：")
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({bottom:5,top:10})
                  Text('关于开展2024年全国大学生陶艺作品展校内作品征集的通知')
                    .width(235)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ top:10,bottom:5})
                  Image($r('app.media.Notification1'))
                    .width(15)
                    .margin({left:10,right:5,bottom:5,top:10})
                }
              }

              ListItem(){
                Row({ }) {
                  Text('通知')
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({left:20,right:1,bottom:5})
                  Text("：")
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({bottom:5})
                  Text('关于2024年秋季学期本科生注册安排的通知')
                    .width(235)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ bottom:5})
                  Image($r('app.media.Notification1'))
                    .width(15)
                    .margin({left:10,right:5,bottom:5})
                }
                .margin({top:10})
              }

              ListItem(){
                Row({ }) {
                  Text('资讯')
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({left:20,right:1,bottom:5})
                  Text("：")
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({bottom:5})
                  Text('助力师生创新创业 2024年度“天壹训练营”结营')
                    .width(235)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ bottom:5})
                  Image($r('app.media.Hot_review'))
                    .width(15)
                    .margin({left:10,right:5,bottom:5})
                }
                .margin({top:10})
              }

              ListItem(){
                Row({ }) {
                  Text('会议')
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({left:20,right:1,bottom:5})
                  Text("：")
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({bottom:5})
                  Text('关于举办“多模态智能及应用”学术报告会的通知')
                    .width(235)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ bottom:5})
                  Image($r('app.media.Meeting'))
                    .width(15)
                    .margin({left:10,right:5,bottom:5})
                }
                .margin({top:10})
              }

              ListItem(){
                Row({ }) {
                  Text('公示')
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({left:20,right:1,bottom:5})
                  Text("：")
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({bottom:5})
                  Text('2024年度北京市科学技术奖提名项目候选单位公示')
                    .width(235)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ bottom:5})
                  Image($r('app.media.Notification1'))
                    .width(15)
                    .margin({left:10,right:5,bottom:5})
                }
                .margin({top:10})
              }

              ListItem(){
                Row({ }) {
                  Text('通知')
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({left:20,right:1,bottom:5})
                  Text("：")
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({bottom:5})
                  Text('关于组织开展国家国防科工局“十五五”关键材料和基础机电产品发展论证工作的通知')
                    .width(235)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ bottom:5})
                  Image($r('app.media.Notification1'))
                    .width(15)
                    .margin({left:10,right:5,bottom:5})
                }
                .margin({top:10})
              }

              ListItem(){
                Row({ }) {
                  Text('资讯')
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({left:20,right:1,bottom:5})
                  Text("：")
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({bottom:5})
                  Text('助力师生创新创业 2024年度“天壹训练营”结营')
                    .width(235)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ bottom:5})
                  Image($r('app.media.Hot_review'))
                    .width(15)
                    .margin({left:10,right:5,bottom:5})
                }
                .margin({top:10})
              }

              ListItem(){
                Row({ }) {
                  Text('通知')
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({left:20,right:1,bottom:5})
                  Text("：")
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({bottom:5})
                  Text('关于2024年秋季学期本科生注册安排的通知')
                    .width(235)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ bottom:5})
                  Image($r('app.media.Notification1'))
                    .width(15)
                    .margin({left:10,right:5,bottom:5})
                }
                .margin({top:10})
              }

              ListItem(){
                Row({ }) {
                  Text('资讯')
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({left:20,right:1,bottom:5})
                  Text("：")
                    .fontSize(12)
                    .fontColor('#0000ff')
                    .margin({bottom:5})
                  Text('助力师生创新创业 2024年度“天壹训练营”结营')
                    .width(235)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                    .fontSize(12)
                    .fontColor('#000000')
                    .margin({ bottom:5})
                  Image($r('app.media.Hot_review'))
                    .width(15)
                    .margin({left:10,right:5,bottom:5})
                }
                .margin({top:10})
              }

            } // 这是新闻列表
            .lanes(this.egLanes)
            .scrollBar(BarState.Auto)
            .divider(this.egDivider)
            .height(190)

          }
          .backgroundColor('#ffffffff')
          .shadow({ radius: 10, color: '#C0C0C0'})
          .borderRadius(10)
          .width('95%')
          .height(215)
          .margin({left:10,right:10,top:10,bottom:5})

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

                    Row() {
                      Search({ placeholder: '搜索' })
                        .searchButton('SEARCH')
                        .onChange((value) => {
                          this.keyword = value
                        })
                        .onClick(() => {
                          if (this.keyword === '') {
                            promptAction.showToast({ message: '请输入想要查找的内容' })
                          } else {
                            promptAction.showToast({ message: '未查找到' + this.keyword + '内容' })
                          }
                        })
                        .width('95%')
                        .height(40)
                        .margin({ left: 10, right: 10, top: 10 })
                    }
                    .margin({
                      left: 10,
                      right: 10,
                      top: -30,
                      bottom: 40
                    })

                    Row({ space: 10 }) {
                      Column() {
                        Image($r('app.media.Notice'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('校园热榜')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Map'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('校园地图')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Benefit'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('爱公益')
                          .fontSize(12)
                      }
                    }
                    .justifyContent(FlexAlign.Center)
                    .margin({ left: 10 })

                    Row({ space: 10 }) {
                      Column() {
                        Image($r('app.media.Lab'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('实验室')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Calender'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('校历')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Uni'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
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
                        Text('发现大学')
                          .fontSize(12)
                      }
                    }
                    .justifyContent(FlexAlign.Center)
                    .margin({ left: 10 ,top:10})

                    Row({ space: 10 }) {
                      Column() {
                        Image($r('app.media.Forum'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('校园论坛')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Benefit'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('爱公益')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Benefit'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('爱公益')
                          .fontSize(12)
                      }
                    }
                    .justifyContent(FlexAlign.Center)
                    .margin({ left: 10 ,top:10})

                    Row({ space: 10 }) {
                      Column() {
                        Image($r('app.media.Lab'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('实验室')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Wait'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('待开发')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Wait'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('待开发')
                          .fontSize(12)
                      }
                    }
                    .justifyContent(FlexAlign.Center)
                    .margin({ left: 10 ,top:10})

                    Row({ space: 10 }) {
                      Column() {
                        Image($r('app.media.Lab'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('实验室')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Calender'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('校历')
                          .fontSize(12)
                      }

                      Column() {
                        Image($r('app.media.Uni'))
                          .width(70)
                          .height(70)
                          .margin({
                            left: 5,
                            right: 5,
                            bottom: 5,
                            top: 2
                          })
                          .borderRadius(10)
                          .shadow({ radius: 10, color: '#C0C0C0' })
                        Text('发现大学')
                          .fontSize(12)
                      }
                    }
                    .justifyContent(FlexAlign.Center)
                    .margin({ left: 10 ,top:10})


                  }

              }
              .tabBar('校园服务')
              .backgroundColor('#ffffffff')
              .borderWidth({left:1,right:0,top:0,bottom:0})
              .borderColor('#DCDCDC')


              TabContent() {
                Flex({ wrap: FlexWrap.Wrap }) {

                  Row() {
                    Search({ placeholder: '搜索' })
                      .searchButton('SEARCH')
                      .onChange((value) => {
                        this.keyword = value
                      })
                      .onClick(() => {
                        if (this.keyword === '') {
                          promptAction.showToast({ message: '请输入想要查找的内容' })
                        } else {
                          promptAction.showToast({ message: '未查找到' + this.keyword + '内容' })
                        }
                      })
                      .width('95%')
                      .height(40)
                      .margin({ left: 10, right: 10, top: 10 })
                  }
                  .margin({
                    left: 10,
                    right: 10,
                    top: -90,
                    bottom: 10
                  })

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.CatDog'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('发现猫狗')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Rest'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('休息一下')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }
                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 })

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Cat'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('发现猫咪')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Dog'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('发现狗狗')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }
                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 ,top:10})

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }
                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 ,top:10})

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }



                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 ,top:10})


                }

              }
              .tabBar('生活服务')
              .backgroundColor('#ffffffff')
              .borderWidth({left:1,right:0,top:0,bottom:0})
              .borderColor('#DCDCDC')

              TabContent() {
                Flex({ wrap: FlexWrap.Wrap }) {

                  Row() {
                    Search({ placeholder: '搜索' })
                      .searchButton('SEARCH')
                      .onChange((value) => {
                        this.keyword = value
                      })
                      .onClick(() => {
                        if (this.keyword === '') {
                          promptAction.showToast({ message: '请输入想要查找的内容' })
                        } else {
                          promptAction.showToast({ message: '未查找到' + this.keyword + '内容' })
                        }
                      })
                      .width('95%')
                      .height(40)
                      .margin({ left: 10, right: 10, top: 10 })
                  }
                  .margin({
                    left: 10,
                    right: 10,
                    top: -90,
                    bottom: 10
                  })

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }
                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 })

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }
                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 ,top:10})

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }
                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 ,top:10})

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }



                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 ,top:10})


                }
              }
              .tabBar('公共服务')
              .backgroundColor('#ffffffff')
              .borderWidth({left:1,right:0,top:0,bottom:0})
              .borderColor('#DCDCDC')

              TabContent() {
                Flex({ wrap: FlexWrap.Wrap }) {

                  Row() {
                    Search({ placeholder: '搜索' })
                      .searchButton('SEARCH')
                      .onChange((value) => {
                        this.keyword = value
                      })
                      .onClick(() => {
                        if (this.keyword === '') {
                          promptAction.showToast({ message: '请输入想要查找的内容' })
                        } else {
                          promptAction.showToast({ message: '未查找到' + this.keyword + '内容' })
                        }
                      })
                      .width('95%')
                      .height(40)
                      .margin({ left: 10, right: 10, top: 10 })
                  }
                  .margin({
                    left: 10,
                    right: 10,
                    top: -90,
                    bottom: 10
                  })

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }
                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 })

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }
                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 ,top:10})

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }
                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 ,top:10})

                  Row({ space: 10 }) {
                    Column() {
                      Image($r('app.media.Lab'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('实验室')
                        .fontSize(12)
                    }

                    Column() {
                      Image($r('app.media.Benefit'))
                        .width(70)
                        .height(70)
                        .margin({
                          left: 5,
                          right: 5,
                          bottom: 5,
                          top: 2
                        })
                        .borderRadius(10)
                        .shadow({ radius: 10, color: '#C0C0C0' })
                      Text('爱公益')
                        .fontSize(12)
                    }



                  }
                  .justifyContent(FlexAlign.Center)
                  .margin({ left: 10 ,top:10})


                }
              }
              .tabBar("其他服务")
              .backgroundColor('#ffffffff')
              .borderWidth({left:1,right:0,top:0,bottom:0})
              .borderColor('#DCDCDC')
            }
            .vertical(true)
            .barWidth(80)
            .barHeight(200)
            .backgroundColor('#00000000') // 这是第二个页面的容器的背景

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
            .borderWidth({left:0,right:0,top:0,bottom:0.1})
            .borderColor('#DCDCDC')


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
          .backgroundColor('#F8F8FF')

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