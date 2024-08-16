import http from '@ohos.net.http';
import { preferences } from '@kit.ArkData';
import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';

let options: preferences.Options = { name: 'myStore' };
let dataPreferences: preferences.Preferences = preferences.getPreferencesSync(getContext(), options);

interface Cat {
  id: string,
  url: string,
  width: number,
  height: number
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  controller: TabsController = new TabsController();

  @State cats: Cat[] = []
  @State saveCats: Cat[] = []
  @State count: number = 0
  @State visible: Visibility = Visibility.Hidden
  @State imageIndex: number = 0
  private swiperController: SwiperController = new SwiperController()

  requestData() { // 请求数据
    let httpRequest = http.createHttp()
    httpRequest.request(
      'https://api.thecatapi.com/v1/images/search?limit=10',
      (err, data) => {
        if(!err) {
          let newCats: Cat[] = JSON.parse(data.result.toString())
          this.cats = [...this.cats, ...newCats]
          this.count = this.cats.length
        }
      }
    )
  }

  aboutToAppear(): void {
    this.requestData()
  }

  @Builder LabelImage(label: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({width: 25, height: 25})
      Text(label)
        .fontColor(this.currentIndex === targetIndex ? '#1296db' : '#8a8a8a')
    }
    .onClick(() => {
      this.currentIndex = targetIndex
      this.controller.changeIndex(this.currentIndex)
    })
    .backgroundColor('#FFFFFF')
    .width('100%')


  }

  build() {
    Column() {
      Row(){
        Image($r('app.media.back'))
          .width('6%')
          .margin({left: 10})
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Home'
            })
          })
        Text('寻找你喜欢的猫咪')
        Image($r('app.media.share'))
          .width('6%')
          .margin({right: 10})
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .borderWidth({left:0,right:0,top:0,bottom:0.1})
      .borderColor('#DCDCDC')
      .backgroundColor('#ffffff')
      .width('100%')

      .align(Alignment.Top)
      .margin({bottom: 10})

      Tabs({controller: this.controller}) {

        TabContent() {
          Stack() {
            List() {
              ForEach(this.cats, (item: Cat, index: number) => {
                ListItem() {
                  Column() {
                    Image(item.url)
                      .borderRadius({
                        topLeft: 10,
                        topRight: 10
                      })
                      .width('94%')
                      .onClick(() => {
                        this.visible = Visibility.Visible
                        this.imageIndex = index
                      })
                    Row() {
                      Text(`${item.width} * ${item.height}`).margin({left: 15})
                      Text('收藏').margin({right: 15})
                        .onClick(() => {
                          let value: string = dataPreferences.getSync('cats', '[]').toString();
                          let cats: Cat[] = JSON.parse(value)
                          if(cats.length >= 5) {
                            promptAction.showToast({message: '最多收藏5只猫'})
                          } else {
                            let result = cats.some((value) => {
                              return value.id === item.id
                            })
                            if(result) {
                              promptAction.showToast({message: '不能重复收藏'})
                            } else {
                              cats.push(item)
                              dataPreferences.putSync('cats', JSON.stringify(cats))
                              dataPreferences.flush()
                              promptAction.showToast({
                                message: '已收藏'
                              })
                            }
                          }
                        })
                    }
                    .width('94%')
                    .height(30)
                    .margin({top: 10})
                    .justifyContent(FlexAlign.SpaceBetween)
                  }
                  .borderRadius(10)
                  .margin({bottom: 20})
                  .shadow({
                    radius: 10,
                    color: Color.Gray
                  })
                }.width('100%')
              },(item: Cat) => {
                return item.id
              })
            }
            .width('100%')
            .height('100%')
            Text('刷新')
              .onClick(() => {
                this.cats = []
                this.requestData()
                promptAction.showToast({message: '已刷新'})
              })
              .width(50)
              .height(50)
              .backgroundColor(Color.Pink)
              .opacity(0.7)
              .textAlign(TextAlign.Center)
              .borderRadius(25)
              .position({x: '80%', y: '80%'})
            Text('更多')
              .onClick(() => {
                this.requestData()
                promptAction.showToast({message: '已加载更多猫'})
              })
              .width(50)
              .height(50)
              .backgroundColor(Color.Pink)
              .opacity(0.7)
              .textAlign(TextAlign.Center)
              .borderRadius(25)
              .position({x: '80%', y: '90%'})
            Text('' + this.count)
              .width(30)
              .height(30)
              .fontSize(18)
              .backgroundColor(Color.Orange)
              .textAlign(TextAlign.Center)
              .position({x: '85%', y: 10})

            Swiper(this.swiperController) {
              ForEach(this.cats, (item: Cat) => {
                Image(item.url)
                  .width('90%')
                  .height(160)
                  .backgroundColor(0xAFEEEE)
                  .onClick(() => {
                    this.visible = Visibility.Hidden
                  })
              }, (item: Cat) => item.id)
            }
            .visibility(this.visible)
            .width('98%')
            .height('100%')
            .cachedCount(2)
            .index(this.imageIndex)
            .autoPlay(true)
            .interval(4000)
            .indicator( // 设置圆点导航点样式
              new DotIndicator()
                .itemWidth(15)
                .itemHeight(15)
                .selectedItemWidth(15)
                .selectedItemHeight(15)
                .color(Color.Pink)
                .selectedColor(Color.Blue))
            .loop(true)
            .duration(1000)
            .itemSpace(0)
            .displayArrow(true, false)
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.LabelImage('首页', 0, $r('app.media.home_selected'), $r('app.media.home_normal')))



        TabContent() {
          Column() {
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

            List() {
              ForEach(this.saveCats,
                (item: Cat, index: number) => {
                ListItem() {
                  Column() {
                    Image(item.url)
                      .borderRadius({
                        topLeft: 10,
                        topRight: 10
                      })
                      .width('94%')
                    Row() {
                      Text(`${item.width} * ${item.height}`).margin({left: 15})
                      Text('删除').margin({right: 15})
                        .onClick(() => {
                          AlertDialog.show({
                            title: '提示',
                            message: '确定要删除吗？',
                            autoCancel: true,
                            alignment: DialogAlignment.Bottom,
                            primaryButton: {
                              value: '确定',
                              action: () => {
                                let value: string = dataPreferences.getSync('cats', '[]').toString();
                                let cats: Cat[] = JSON.parse(value)
                                cats.splice(index, 1)
                                dataPreferences.putSync('cats', JSON.stringify(cats))
                                dataPreferences.flush()
                                this.saveCats = cats
                                promptAction.showToast({
                                  message: '已删除'
                                })
                              }
                            },
                            secondaryButton: {
                              value: '取消',
                              action: () => {}
                            }
                          })
                        })
                    }
                    .width('94%')
                    .height(30)
                    .margin({top: 10})
                    .justifyContent(FlexAlign.SpaceBetween)
                  }
                  .borderRadius(10)
                  .margin({bottom: 20})
                  .shadow({
                    radius: 10,
                    color: Color.Gray,
                    offsetX: 10,
                    offsetY: 10
                  })
                }.width('100%')
              },(item: Cat) => {
                return item.id
              })
            }
            .width('100%')
            .height('100%')
          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.LabelImage('我的', 1, $r('app.media.user_selected'), $r('app.media.user_normal')))
        .onWillShow(() => {
          let value: string = dataPreferences.getSync('cats', '[]').toString();
          this.saveCats = JSON.parse(value)
        })
      }
      .barPosition(BarPosition.End)
      .scrollable(false)
      .height('100%')

    }
    .height('100%')
    .width('100%')
  }
}