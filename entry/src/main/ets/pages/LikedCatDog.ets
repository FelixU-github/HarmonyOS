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

interface Dog {
  id: string,
  url: string,
  width: number,
  height: number
}

interface Animal {
  type: 'cat' | 'dog';
  id: string;
  url: string;
  width: number;
  height: number;
}

@Entry
@Component
struct LikedCatDog {
  @State currentIndex: number = 0
  controller: TabsController = new TabsController();
  dataPreferences: preferences.Preferences = preferences.getPreferencesSync(getContext(), options);

  @State animals: Animal[] = [] // 用于存储整合后的猫狗数据
  @State savedAnimals: Animal[] = []

  @State cats: Cat[] = []
  @State saveCats: Cat[] = []
  @State dogs: Dog[] = []
  @State saveDogs: Dog[] = []

  @State catScrollPosition: number = 0;
  @State dogScrollPosition: number = 0;
  @State count: number = 0
  @State countTotal: number = 0
  @State countDog: number = 0
  @State countCat: number = 0
  @State visible: Visibility = Visibility.Hidden
  @State imageIndex: number = 0
  @State dogIndex: number = 0
  private swiperController: SwiperController = new SwiperController()

  requestDataCat() { // 请求数据
    let httpRequest = http.createHttp()
    httpRequest.request(
      'https://api.thecatapi.com/v1/images/search?limit=10',
      (err, data) => {
        if(!err) {
          let newCats: Cat[] = JSON.parse(data.result.toString())
          this.cats = [...this.cats, ...newCats]
          this.count = this.cats.length
          this.countCat = this.cats.length
          let newAnimals: Animal[] = JSON.parse(data.result.toString())
          this.animals = [...this.animals, ...newAnimals]
        }
      }
    )
  }

  requestDataDog(): void {
    let httpRequest = http.createHttp()
    httpRequest.request(
      "https://api.thedogapi.com/v1/images/search?limit=10",
      (err, data) => {
        let newDogs: Dog[] = JSON.parse(data.result.toString())
        this.dogs = [...this.dogs, ...newDogs]
        this.count = this.dogs.length
        this.countDog = this.dogs.length
        let newAnimals: Animal[] = JSON.parse(data.result.toString())
        this.animals = [...this.animals, ...newAnimals]
      }
    )
  }



  // aboutToAppear(): void {
  //   this.requestDataCat()
  //   this.requestDataDog()
  // }

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
        Text('寻找你喜欢的猫狗')
        Image($r('app.media.share'))
          .width('6%')
          .margin({right: 10})
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .borderWidth({left:0,right:0,top:0,bottom:0.1})
      .borderColor('#DCDCDC')
      .backgroundColor('#ffffff')
      .width('100%')
      .height(25)
      // .align(Alignment.Top)
      .margin({bottom: 10})



      Tabs({controller: this.controller}) {

        TabContent() {

          Column() {
            if (this.cats.length === 0){
              Image($r("app.media.wasp"))
                .width(200)
                .margin({top: -100})

              Text('正在等待发现猫狗')
                .fontSize(20)
                .margin({top:10})

              Button('点击开始发现')
                .margin({top:100})
                .width(160)
                .height(160)
                .backgroundColor('#1296db')
                .onClick(() => {
                  this.requestDataCat()
                  this.requestDataDog()
                })
            } else {
              Row(){
                Text('已经发现了' + this.countCat+ '只猫和' + this.countDog + '只狗')
                  .margin({left: 80})

              }
              .backgroundColor('#ffffffff')
              .width(`98%`)
              .height(40)
              .borderRadius(10)
              .borderWidth({left:1,right:1,top:1,bottom:1})
              .borderColor('#DCDCDC')
              // .position({ x: '85%', y: 10 })


              Row() {
                Stack() {
                  List() {
                    ForEach(this.cats, (item: Cat, index: number) => {
                      ListItem() {
                        Column() {
                          Image(item.url)
                            .borderRadius({
                              topLeft: 10,
                              topRight: 10,
                            })
                            .width('94%')
                            .onClick(() => {
                              this.visible = Visibility.Visible
                              this.imageIndex = index
                            })
                          Row() {
                            Text(`ID：${item.id} `).margin({ left: 10 })
                            Text('收藏').margin({ right: 15 })
                              .onClick(() => {
                                let value: string = dataPreferences.getSync('cats', '[]').toString();
                                let cats: Cat[] = JSON.parse(value)
                                if (cats.length >= 5) {
                                  promptAction.showToast({ message: '最多收藏5只猫' })
                                } else {
                                  let result = cats.some((value) => {
                                    return value.id === item.id
                                  })
                                  if (result) {
                                    promptAction.showToast({ message: '不能重复收藏' })
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
                          .width('90%')
                          .height(30)
                          .margin({ top: 10 })
                          .justifyContent(FlexAlign.SpaceBetween)
                        }
                        .borderRadius(10)
                        .margin({ bottom: 5 })
                        .borderWidth({left:1,right:1,top:1,bottom:1})
                        .borderColor('#DCDCDC')

                      }
                      .width('100%')
                      .margin({ top:5 })

                    }, (item: Cat) => {
                      return item.id
                    })
                  }
                  .width('100%')
                  .height('100%')




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

                  Text('刷新一下猫咪')
                    .backgroundColor('#E6E6FA')
                    .width(160)
                    .height(50)
                    .textAlign(TextAlign.Center)
                    .borderRadius(25)
                    .position({ x: '10', y: '75%' })
                    .opacity(0.8)
                    .onClick(() => {
                      this.cats = []
                      this.requestDataCat()
                    })

                  Text('发现更多猫咪')
                    .backgroundColor('#E6E6FA')
                    .width(160)
                    .height(50)
                    .textAlign(TextAlign.Center)
                    .borderRadius(25)
                    .position({ x: '10', y: '85%' })
                    .opacity(0.8)
                    .onClick(() => {
                      this.requestDataCat()
                    })

                }
                .width('50%')
                .height('100%')

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
                              Text(`ID:${item.id}`).margin({ left: 10 })
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
                          .margin({ bottom: 10 })
                          .borderRadius(10)
                          .borderWidth({left:1,right:1,top:1,bottom:1})
                          .borderColor('#DCDCDC')
                        }
                        .width('100%')
                      },
                      (item: Dog) => {
                        return item.id
                      }
                    )
                  }
                  .width('100%')

                  Text('刷新一下狗狗')
                    .backgroundColor('#E6E6FA')
                    .width(160)
                    .height(50)
                    .textAlign(TextAlign.Center)
                    .borderRadius(25)
                    .position({ x: '10', y: '75%' })
                    .opacity(0.8)
                    .onClick(() => {
                      this.dogs = []
                      this.requestDataDog()
                    })

                  Text('发现更多狗狗')
                    .backgroundColor('#E6E6FA')
                    .width(160)
                    .height(50)
                    .textAlign(TextAlign.Center)
                    .borderRadius(25)
                    .position({ x: '10', y: '85%' })
                    .opacity(0.8)
                    .onClick(() => {
                      // this.requestDataCat()
                      this.requestDataDog()
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
                  .indicator(Indicator.digit()// 设置数字导航点样式
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
                .width('50%')
                .height('100%')

              }
              .margin({top: 10})

            }



          }

        }
        .tabBar(this.LabelImage('首页', 0, $r('app.media.home_selected'), $r('app.media.home_normal')))



        TabContent() {
          Column() {
            Row() {
              Image($r('app.media.img'))
                .width("20%")
                .shadow({ radius: 10, color: '#C0C0C0' })
                .borderRadius(50)
                .margin({ left: 30, right: 10 })
              Column() {
                Text('大王叫我来巡山')
                  .fontSize(25)
                  .margin({ left: 20, right: 10, top: -5 })


                if (this.savedAnimals.length > 0) {
                  Text('您已收藏 ' + this.saveCats.length + ' 只猫咪和' + this.saveDogs.length + ' 只狗')
                    .fontSize(15)
                    .maxLines(2)
                    .margin({ left: 20, right: 10, top: 20 })
                } else {
                  Text('您还没有收藏猫狗')
                    .fontSize(20)
                    .margin({ left: 20, right: 10, top: 20 })
                }

              }

            }
            .width('95%')
            .height(120)
            .backgroundColor("#ffffffff")
            .borderRadius(10)
            .shadow({ radius: 10, color: '#D3D3D3' })
            .margin({ top: 10 })

          Column(){
            if (this.savedAnimals.length === 0){
              Image($r("app.media.wasp"))
                .width(200)
              Text('正在等待收藏猫狗')
                .fontSize(20)
                .margin({top:10})
            }else {
              Row(){
                List() {
                  ForEach(this.savedAnimals,
                    (item: Animal, index: number) => {
                      ListItem() {
                        Column() {
                          Image(item.url)
                            .borderRadius({
                              topLeft: 10,
                              topRight: 10
                            })
                            .width('94%')

                          Row() {
                            Text(`ID:${item.id}`).margin({ left: 15 })
                            Text('删除').margin({ right: 15 })
                              .onClick(() => {
                                AlertDialog.show({
                                  title: '提示',
                                  message: '确定要删除吗？',
                                  autoCancel: true,
                                  alignment: DialogAlignment.Bottom,
                                  primaryButton: {
                                    value: '确定',
                                    action: () => {
                                let itemToDelete = this.savedAnimals[index];

                                if (itemToDelete.type === 'cat') {
                                  // 从 cats 数组中删除
                                  this.saveCats = this.saveCats.filter(cat => cat.id !== itemToDelete.id);
                                  // 更新本地存储
                                  dataPreferences.putSync('cats', JSON.stringify(this.saveCats));
                                } else if (itemToDelete.type === 'dog') {
                                  // 从 dogs 数组中删除
                                  this.saveDogs = this.saveDogs.filter(dog => dog.id !== itemToDelete.id);
                                  // 更新本地存储
                                  dataPreferences.putSync('dogs', JSON.stringify(this.saveDogs));
                                }

                                // 更新 savedAnimals 数组
                                this.savedAnimals = this.savedAnimals.filter(animal => animal.id !== itemToDelete.id);

                                // 刷新 UI
                                dataPreferences.flush();
                                promptAction.showToast({
                                  message: '已删除'
                                });
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
                      .width('94%')
                      .height(30)
                      .margin({ top: 10 })
                      .justifyContent(FlexAlign.SpaceBetween)
                      }
                      .borderRadius(10)
                      .margin({ bottom: 20 })
                      .borderWidth({left:1,right:1,top:1,bottom:1})
                      .borderColor('#DCDCDC')

                      }
                      .width('100%')

                    }, (item: Animal) => {
                      return item.id
                    })
                }
                .width('100%')
                .height('100%')
              }
              .margin({ top: 10 })
              }
            }
          .width('100%')
          .height('520')

          }
          .width('100%')
          .height('100%')
        }
        .tabBar(this.LabelImage('我的', 1, $r('app.media.user_selected'), $r('app.media.user_normal')))
        .onWillShow(() => {
          let value: string = dataPreferences.getSync('cats', '[]').toString();
          this.saveCats = JSON.parse(value)

          // 将猫数据转换为 Animal 类型
          let catAnimals: Animal[] = this.saveCats.map((cat: Cat): Animal => ({
            type: 'cat',
            id: cat.id,
            url: cat.url,
            width: cat.width,
            height: cat.height,
          }));



          let valueDog: string = dataPreferences.getSync('dogs', '[]').toString();
          this.saveDogs = JSON.parse(valueDog)


          // 将狗数据转换为 Animal 类型
          let dogAnimals: Animal[] = this.saveDogs.map((dog: Dog): Animal => ({
            type: 'dog',
            id: dog.id,
            url: dog.url,
            width: dog.width,
            height: dog.height,
          }));

          this.savedAnimals = [...catAnimals, ...dogAnimals];

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