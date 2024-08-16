import http from '@ohos.net.http';
import { preferences } from '@kit.ArkData';
import { promptAction ,router} from '@kit.ArkUI';

let options: preferences.Options = { name: 'myStore' };
interface Dog {
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
  dataPreferences: preferences.Preferences = preferences.getPreferencesSync(getContext(), options);
  @State dogs: Dog[] = []
  @State saveDogs: Dog[] = []
  @State count: number = 0
  @State visible: Visibility = Visibility.Hidden
  @State dogIndex: number = 0

  @Builder TabBuilder(label: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({width: 25, height: 25})
      Text(label).fontColor(this.currentIndex === targetIndex ? '#1296db' : '#8a8a8a')
    }
    .width('100%')
    .onClick(() => {
      this.currentIndex = targetIndex
      this.controller.changeIndex(this.currentIndex)
    })
  }
  requestData(): void {
    let httpRequest = http.createHttp()
    httpRequest.request(
      "https://api.thedogapi.com/v1/images/search?limit=10",
      (err, data) => {
        let newDogs: Dog[] = JSON.parse(data.result.toString())
        this.dogs = [...this.dogs, ...newDogs]
        this.count = this.dogs.length
      }
    )
  }
  aboutToAppear(): void {
    this.requestData()
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
      .shadow({ radius: 5, color: '#696969' ,offsetY: 5})
      .backgroundColor('#ffffff')
      .width('100%')
      .height(40)
      .align(Alignment.Top)
      .margin({bottom: 10})

      Tabs({controller: this.controller}) {
        TabContent() {
          Stack() {
            List() {
              ForEach(
                this.dogs,
                (item: Dog, index: number) => {
                  ListItem() {
                    Column() {
                      Image(item.url)
                        .borderRadius({
                          topLeft: 10,
                          topRight: 10
                        })
                        .onClick(() => {
                          this.visible = Visibility.Visible
                          this.dogIndex = index
                        })
                      Row() {
                        Text(`${item.width} * ${item.height}`).margin({ left: 10 })
                        Text('收藏').margin({ right: 10 })
                          .onClick(() => {
                            let str: string = this.dataPreferences.getSync('dogs', '[]').toString()
                            let dogs: Dog[] = JSON.parse(str)
                            console.log('' + dogs.length)
                            if (dogs.length >= 5) {
                              promptAction.showToast({ message: '最多收藏5条狗' })
                            } else {
                              let result: boolean = dogs.some((value: Dog, index: number, array: Dog[]) => {
                                return value.id === item.id
                              })
                              if (result) {
                                promptAction.showToast({ message: '不能重复收藏' })
                              } else {
                                dogs.push(item)
                                this.dataPreferences.putSync('dogs', JSON.stringify(dogs))
                                this.dataPreferences.flush()
                                promptAction.showToast({ message: '已收藏' })
                              }
                            }
                          })
                      }
                      .width('100%')
                      .margin({ top: 10, bottom: 10 })
                      .justifyContent(FlexAlign.SpaceBetween)
                      .alignItems(VerticalAlign.Center)
                    }
                    .width('94%')
                    .margin({ bottom: 30 })
                    .borderRadius(10)
                    .shadow({
                      radius: 5,
                      color: Color.Gray,
                      offsetX: 5,
                      offsetY: 5
                    })
                  }
                  .width('100%')
                },
                (item: Dog) => {
                  return item.id
                }
              )
            }
            .width('100%')
            Text('刷新')
              .backgroundColor(Color.Pink)
              .width(50)
              .height(50)
              .textAlign(TextAlign.Center)
              .borderRadius(25)
              .position({x: '80%', y: '80%'})
              .opacity(0.8)
              .onClick(() => {
                this.dogs = []
                this.requestData()
              })
            Text('更多')
              .backgroundColor(Color.Pink)
              .width(50)
              .height(50)
              .textAlign(TextAlign.Center)
              .borderRadius(25)
              .position({x: '80%', y: '90%'})
              .opacity(0.8)
              .onClick(() => {
                this.requestData()
              })
            Text('' + this.count)
              .backgroundColor(Color.Orange)
              .width(30)
              .height(20)
              .textAlign(TextAlign.Center)
              .position({x: '85%', y: 20})
              .onClick(() => {
                this.requestData()
              })
            Swiper() {
              ForEach(this.dogs, (item: Dog) => {
                Image(item.url).objectFit(ImageFit.Contain)
              }, (item: Dog) => {
                return item.id
              })
            }
            //.autoPlay(true)
            .index(this.dogIndex)
            .interval(3000)
            .displayArrow(true, false)
            .indicator(Indicator.digit() // 设置数字导航点样式
              .bottom(50)
              .fontColor(Color.Red)
              .selectedFontColor(Color.Red)
              .digitFont({ size: 20, weight: FontWeight.Normal })
              .selectedDigitFont({ size: 20, weight: FontWeight.Normal }))
            .width('100%')
            .height('100%')
            .backgroundColor(Color.White)
            .visibility(this.visible)
            .onClick(() => {
              this.visible = Visibility.Hidden
            })
          }
        }
        .tabBar(this.TabBuilder('首页', 0, $r('app.media.home_selected'), $r('app.media.home_normal')))
        TabContent() {
          Column() {
            if (this.saveDogs.length === 0) {
              Text('您尚未收藏🐶').fontSize(24)
            }
            List() {
              ForEach(
                this.saveDogs,
                (item: Dog, index: number) => {
                  ListItem() {
                    Column() {
                      Image(item.url)
                        .borderRadius({
                          topLeft: 10,
                          topRight: 10
                        })
                      Row() {
                        Text(`${item.width} * ${item.height}`).margin({ left: 10 })
                        Text('删除').margin({ right: 10 })
                          .onClick(() => {
                            AlertDialog.show({
                              title: '提示',
                              message: '您确定要删除吗？',
                              autoCancel: false,
                              alignment: DialogAlignment.Bottom,
                              primaryButton: {
                                value: '确定',
                                action: () => {
                                  let str: string = this.dataPreferences.getSync('dogs', '[]').toString()
                                  let dogs: Dog[] = JSON.parse(str)
                                  dogs.splice(index, 1)
                                  this.saveDogs = dogs
                                  this.dataPreferences.putSync('dogs', JSON.stringify(dogs))
                                  this.dataPreferences.flush()
                                  promptAction.showToast({ message: '已删除' })
                                }
                              },
                              secondaryButton: {
                                value: '取消',
                                action: () => {
                                }
                              }
                            })
                          })
                      }
                      .width('100%')
                      .margin({ top: 10, bottom: 10 })
                      .justifyContent(FlexAlign.SpaceBetween)
                      .alignItems(VerticalAlign.Center)
                    }
                    .width('94%')
                    .margin({ bottom: 30 })
                    .borderRadius(10)
                    .shadow({
                      radius: 5,
                      color: Color.Gray,
                      offsetX: 5,
                      offsetY: 5
                    })
                  }
                  .width('100%')
                },
                (item: Dog) => {
                  return item.id
                }
              )
            }
            .width('100%')
          }
        }
        .onWillShow(() => {
          let str: string = this.dataPreferences.getSync('dogs', '[]').toString()
          this.saveDogs = JSON.parse(str)
        })
        .tabBar(this.TabBuilder('我的', 1, $r('app.media.user_selected'), $r('app.media.user_normal')))
      }
      .barPosition(BarPosition.End)
      .scrollable(false)
    }
    .height('100%')
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}