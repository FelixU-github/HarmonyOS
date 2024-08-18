import { http } from '@kit.NetworkKit';
import { promptAction, router } from '@kit.ArkUI';
import { preferences } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';

let httpRequest = http.createHttp();

let options: preferences.Options = { name: 'myStore' };
let dataPreferences: preferences.Preferences = preferences.getPreferencesSync(getContext(), options);


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
struct search {
  @State isButtonEnabled: boolean = true; // 按钮启用状态
  @State collection: string = '收藏'
  @State keyword: string = ''
  @State count: number = 0
  @State saved_universities: University[] = []
  @State universities: University[] = []
  @State search_universities: University[] = []
  @State currentIndex: number = 0
  controller: TabsController = new TabsController();


  requestData() {
    const url = `http://universities.hipolabs.com/search?name=${encodeURIComponent(this.keyword)}`;
    httpRequest.request(url, (err, data) => {
      if (!err) {
        // 解析为 University 对象数组
        let New_universities: University[] = JSON.parse(data.result.toString())
        this.universities = [...this.universities, ...New_universities]

        this.search_universities = []
        this.search_universities = [...this.search_universities, ...New_universities]


        dataPreferences.putSync('search_universities', JSON.stringify(this.search_universities))
        // dataPreferences.delete('search_universities')
        dataPreferences.flush()


        this.count = this.universities.length
        console.info('count:' + this.count)
        if (this.count === 0) {
          promptAction.showToast({message: '未找到名字包含' + this.keyword + '的大学'})
        }

        // 打印大学的信息
        New_universities.slice(0,5).forEach((university) => {
          console.info('University Name: ' + university.name);
          // console.info('Country: ' + university.country);
          // console.info('Web Pages: ' + university.web_pages.join(', '));
          // console.info('Domains: ' + university.domains.join(', '));
          // console.info('State Province: ' + university.state_province);
          // console.info('-----');
        })
      } else {
        console.info('error:' + JSON.stringify(err));
      }
    });
  }

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



  build() {

    Column(){

      Row(){
        Image($r('app.media.back'))
          .width('6%')
          .margin({left: 10})
          .onClick(() => {
            router.back({
              url: 'pages/Home'
            })
          })
        Text('发现大学')
        Image($r('app.media.share'))
          .width('6%')
          .margin({right: 10})
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .shadow({ radius: 5, color: '#696969' })
      .backgroundColor('#ffffff')
      .width('100%')
      .height(40)
      .align(Alignment.Top)


      Tabs({ controller: this.controller ,barPosition: BarPosition.End}){
        TabContent(){
          Column(){

            Column(){

              Text('发现你喜欢的大学')
                .fontSize(24)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
                .margin({
                  top:25
                })
              Row(){
                Text('(使用本地存储-用户首选项) ')
                  .fontSize(10)
                Text(' (使用网络)')
                  .fontSize(10)
              }
              .margin({top:10})


              Search({ placeholder: '搜索'})
                .searchButton('SEARCH')
                .onChange((value) => {
                  this.keyword = value
                })
                .width('90%')
                .height(40)
                .margin({left:10,right:10,top:15})
                .onClick(()=>{
                  if(this.keyword === ''){
                    promptAction.showToast({message: '请输入大学名称'})
                  }else {

                    this.universities = [] // 清空搜索数组
                    this.requestData()

                  }
                })
            }
            .height(150)
            .width('95%')
            .backgroundColor('#ffffffff')
            .borderRadius(10)
            .margin({left:10,right:10,top:10})
            .shadow({ radius: 10, color: '#D3D3D3'})


            Column() {
              if (this.search_universities.length === 0) {
                Image($r("app.media.wasp"))
                  .width(200)
                  .margin({top:10})

                Text('正在等待发现大学')
                  .fontSize(20)
                  .margin({top:10})
              }
              else {
                Text('找到'+ this.count + '所名字含有'+ this.keyword + '的大学')
                  .fontSize(20)
                  .margin({top:10})

              }


              List({ space: 20, initialIndex: 0 }) {
                ForEach(this.search_universities, (item: University) => {
                  ListItem() {
                    Column({space:5}){
                      Row({space: 10}){
                        Image($r('app.media.university'))
                          .width(50)
                          .height(50)
                          .margin({left: 10,top: 10,bottom: 10})
                          .border({radius: 10})
                          .shadow({ radius: 10, color: '#C0C0C0'})

                        Text(item.name)
                          .width(250)
                          .maxLines(2)
                          .margin(5)
                          .fontSize(14)
                          .fontStyle(FontStyle.Italic)
                          .fontWeight(FontWeight.Bold)
                          .fontColor('#0000ff')

                      }
                      .width('100%')
                      .margin({left: 10,right: 10})
                      .backgroundColor('#fff8f8fc')
                      .border({radius: 10})

                      Column({space: 10}){
                        Text('国家：'+item.country)
                          .width('100%')
                          .fontSize(16)
                          .textAlign(TextAlign.Start)
                          .margin({left:20})

                        Text('省份的信息：'+item.state_province)
                          .width('100%')
                          .fontSize(16)
                          .textAlign(TextAlign.Start)
                          .margin({left:20})

                        Text('官方域名：'+item.domains)
                          .width('100%')
                          .fontSize(16)
                          .textAlign(TextAlign.JUSTIFY)
                          .margin({left:20})

                        Text('官方网站：'+item.web_pages)
                          .width('100%')
                          .fontSize(16)
                          .textAlign(TextAlign.JUSTIFY)
                          .margin({left:20, bottom:15})

                        Row(){
                          Button(item.state_province === undefined ? '收藏' : '已收藏')
                            .enabled(item.state_province === undefined) // 按钮启用状态
                            .width('50%')
                            .fontSize(16)
                            .margin({left:10, bottom:10})
                            .onClick(() => {
                              let value: string = dataPreferences.getSync('saved_universities', '[]').toString();
                              let saved_universities: University[] = JSON.parse(value)

                              let value_search: string = dataPreferences.getSync('search_universities', '[]').toString();
                              let search_universities: University[] = JSON.parse(value_search)

                              if(saved_universities.length >= 100) {
                                promptAction.showToast({message: '最多收藏100所大学'})
                              }
                              else{
                                let result = saved_universities.some((value) => {
                                  return value.name === item.name
                              })

                              if(result) {

                                item.state_province = 'collected'; // 更新 state_province 表示已收藏
                                search_universities.push(item);
                                dataPreferences.putSync('search_universities', JSON.stringify(search_universities));
                                dataPreferences.flush()
                                promptAction.showToast({ message: '不能重复收藏' })

                              } else {
                                saved_universities.push(item);
                                dataPreferences.putSync('saved_universities', JSON.stringify(saved_universities))
                                dataPreferences.flush()
                                promptAction.showToast({ message: '已成功收藏' })

                                }
                              }

                            })
                        }

                      }
                      .margin({top:10,left:5})

                    }
                    .borderRadius(10)
                    .width('95%') // 卡片宽度
                    .backgroundColor(0xFFFFFF)
                    .shadow({
                      radius: 10,
                      color: '#C0C0C0'
                    })

                  }
                  .margin({top:10})
                  .width('100%')
                }, (item: University) => {
                  return item.name;
                })

              }
              .width('100%')
              .height(400)
              .margin({top:10})
              .scrollBar(BarState.Auto)
            }

            .width('95%')
            .height('70%')
            .backgroundColor("#ffffffff")
            .margin({top:10})
            .borderRadius(10)
            .shadow({ radius: 10, color: '#D3D3D3'})


          }
          .backgroundColor('#F8F8FF')

        }
        .width('100%')
        .height('100%')
        .tabBar(this.LabelImage('发现', 0, $r('app.media.search_selected'), $r('app.media.search_normal')))
        // .onWillShow(() => {
        //   let value: string = dataPreferences.getSync('search_universities', '[]').toString();
        //   this.search_universities = JSON.parse(value)
        // })


        TabContent() {

          Column(){
            Row(){
              Image($r('app.media.img'))
                .width("20%")
                .shadow({ radius: 10, color: '#C0C0C0'})
                .borderRadius(50)
                .margin({left:30,right:10})
              Column(){
                Text('大王叫我来巡山')
                  .fontSize(25)
                  .margin({left:20,right:10,top:-5})


                if (this.saved_universities.length > 0) {
                  Text('您已收藏 '+this.saved_universities.length+' 所大学')
                    .fontSize(20)
                    .margin({left:20,right:10,top:20})
                }else {
                  Text('您还没有收藏大学')
                    .fontSize(20)
                    .margin({left:20,right:10,top:20})
                }

              }

            }
            .width('95%')
            .height(120)
            .backgroundColor("#ffffffff")
            .borderRadius(10)
            .shadow({ radius: 10, color: '#D3D3D3'})
            .margin({top:10})


            Column(){
              if (this.saved_universities.length === 0){
                Image($r("app.media.wasp"))
                  .width(200)
                Text('等待收藏大学')
                  .fontSize(20)
                  .margin({top:10})
              }else {
                List() {
                  ForEach(this.saved_universities,
                    (item: University, index: number) => {
                      ListItem() {
                        Column() {
                          Row({space: 10}){
                            Image($r('app.media.university'))
                              .width(50)
                              .height(50)
                              .margin({left: 10,top: 10,bottom: 10})
                              .border({radius: 10})
                              .shadow({ radius: 10, color: '#C0C0C0'})

                            Text(item.name)
                              .width(250)
                              .maxLines(2)
                              .margin(5)
                              .fontSize(14)
                              .fontStyle(FontStyle.Italic)
                              .fontWeight(FontWeight.Bold)
                              .fontColor('#0000ff')

                          }
                          .width('100%')
                          .margin({left: 10,right: 10})
                          .backgroundColor('#fff8f8fc')
                          .border({radius: 10})

                          Column({space: 10}) {
                            Text('国家：' + item.country)
                              .width('100%')
                              .fontSize(16)
                              .textAlign(TextAlign.Start)
                              .margin({ left: 20 })

                            Text('省份的信息：' + item.state_province)
                              .width('100%')
                              .fontSize(16)
                              .textAlign(TextAlign.Start)
                              .margin({ left: 20 })

                            Text('官方域名：' + item.domains)
                              .width('100%')
                              .fontSize(16)
                              .textAlign(TextAlign.JUSTIFY)
                              .margin({ left: 20 })

                            Text('官方网站：' + item.web_pages)
                              .width('100%')
                              .fontSize(16)
                              .textAlign(TextAlign.JUSTIFY)
                              .margin({ left: 20, bottom: 15 })

                            Image(item.name)
                              .borderRadius({
                                topLeft: 10,
                                topRight: 10
                              })
                              .width('94%')

                            Row() {
                              Button('删除')
                                .margin({ right: 15,bottom: 10 })
                                .onClick(() => {
                                  AlertDialog.show({
                                    title: '提示',
                                    message: '确定要删除吗？',
                                    autoCancel: true,
                                    alignment: DialogAlignment.Bottom,
                                    primaryButton: {
                                      value: '确定',
                                      action: () => {
                                        let value: string = dataPreferences.getSync('saved_universities', '[]').toString();
                                        let universities: University[] = JSON.parse(value)
                                        universities.splice(index, 1)
                                        dataPreferences.putSync('saved_universities', JSON.stringify(universities))
                                        dataPreferences.flush()
                                        // this.saved_universities = universities
                                        promptAction.showToast({
                                          message: '已删除'
                                        })
                                        // this.isButtonEnabled = true;
                                        // this.collection = '收藏'
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
                            .margin({ top: -20 ,left: 10})
                            .justifyContent(FlexAlign.SpaceBetween)

                          }

                        }
                        .width('95%')
                        .borderRadius(10)
                        .margin({ top: 10, bottom: 10 })
                        .shadow({
                          radius: 10,
                          color: Color.Gray
                        })
                      }.width('100%')
                    }, (item: University) => {
                      return item.name
                    })
                }
                .height(465).margin({top:10})
              }
            }
            .width('95%')
            .height('75%')
            .backgroundColor("#ffffff")
            .borderRadius(10)
            .margin({ top: 10 })
            .shadow({ radius: 10, color: '#D3D3D3' })

          }
          .backgroundColor("#F8F8FF")
          .width('100%')

        }
        .tabBar(this.LabelImage('收藏', 1, $r('app.media.like_selected'), $r('app.media.like_normal')))
        .onWillShow(() => {
          let value: string = dataPreferences.getSync('saved_universities', '[]').toString();
          this.saved_universities = JSON.parse(value)
        })
      }

    }

  }

}