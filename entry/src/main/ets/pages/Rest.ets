// Rest.ets
import {  router ,promptAction } from '@kit.ArkUI';
import { UIContext } from '@kit.ArkUI';
import { preferences } from '@kit.ArkData';
// let options: preferences.Options = { name: 'myStore' };

@Entry
@Component

struct Rest {

  @State meritCount: number = 0; // 功德计数变量
  dataPreferences: preferences.Preferences = preferences.getPreferencesSync(getContext(), { name: 'myStore' });

  // ToAppear() {
  //
  //   let savedStr: string = this.dataPreferences.getSync('meritCount', '0').toString();
  //   this.meritCount = parseFloat(savedStr);
  // }





  @State myScale: number = 1.0;
  @State myScale_font: number = 1.0;
  @State isAutoIncrementing: boolean = false; // 自动增加标志
  autoIncrementInterval: number | undefined = undefined; // 定时器
  uiContext: UIContext | undefined = undefined;

  startAutoIncrement() {
    // 启动自动功德+1定时器
    if (!this.autoIncrementInterval) {
      this.autoIncrementInterval = setInterval(() => {
        this.meritCount += 1;
      }, 1000); // 每秒增加一次功德
    }
  }

  stopAutoIncrement() {
    // 停止自动功德+1定时器
    if (this.autoIncrementInterval) {
      clearInterval(this.autoIncrementInterval);
      this.autoIncrementInterval = undefined;
    }
  }


  aboutToAppear() {
    this.uiContext = this.getUIContext?.();
    // 从本地存储读取保存的功德计数，并解析为 number 类型
    let savedStr: string = this.dataPreferences.getSync('meritCount', '0').toString();
    this.meritCount = parseFloat(savedStr);
  }

  add(): void {
    if (!this.uiContext) {
      console.info("no uiContext, keyframe failed");
      return;
    }
    this.myScale = 1;
    this.myScale_font = 1;
    // 设置关键帧动画整体播放1次
    this.uiContext.keyframeAnimateTo({ iterations: 1 }, [
      {
        // 第一段关键帧动画时长为400ms，scale属性做从1到1.5的动画
        duration: 400,
        event: () => {
          this.myScale = 1.5;
          this.myScale_font = 30;
        }
      },
      {
        // 第二段关键帧动画时长为400ms，scale属性做从1.5到1的动画
        duration: 400,
        event: () => {
          this.myScale = 1;
          this.myScale_font = 0;
        }
      }
    ]);
    this.meritCount += 1;
    this.dataPreferences.putSync('meritCount', this.meritCount.toString()); // 保存到本地存储
    this.dataPreferences.flush(); // 确保数据持久化

    // 验证保存是否成功
    let savedStr: string = this.dataPreferences.getSync('meritCount', '0').toString();
    let savedMeritCount: number = parseFloat(savedStr);

    if (savedMeritCount === this.meritCount) {
      console.log('数据保存成功:', savedMeritCount);
      promptAction.showToast({ message: '功德保存成功' });
    } else {
      console.log('数据保存失败，读取到的值:', savedMeritCount);
      promptAction.showToast({ message: '功德保存失败' });
    }

  }

  auto_add():void{
    if (!this.uiContext) {
      console.info("no uiContext, keyframe failed");
      return;
    }
    this.myScale = 1;
    this.myScale_font = 0;

    // 设置关键帧动画整体播放1次
    this.uiContext.keyframeAnimateTo({ iterations: -1 }, [
      {
        // 第一段关键帧动画时长为400ms，scale属性做从1到1.5的动画
        duration: 400,
        event: () => {
          this.myScale = 1.5;
          this.myScale_font = 20;
        }
      },
      {
        // 第二段关键帧动画时长为400ms，scale属性做从1.5到1的动画
        duration: 400,
        event: () => {
          this.myScale = 1;
          this.myScale_font = 0;
        }
      }
    ]);
    this.meritCount += 1

  }



  build() {
    Column({ space: 3 }) {
      Row(){
        Image($r('app.media.back'))
          .width('6%')
          .margin({left: 10})
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Home'
            })
          })
        Text('休息一下')
        Image($r('app.media.share'))
          .width('6%')
          .margin({right: 10})
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .shadow({ radius: 10, color: '#C0C0C0'})
      .backgroundColor('#ffffff')
      .width('100%')
      .height(40)
      .align(Alignment.Top)



      Text(`当前功德：${this.meritCount}`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      //   .onCh(() => {
      //
      //     let str: string = this.dataPreferences.getSync('meritCount', '0').toString(); // 默认值为 '0'
      //     let myNumber: number = parseFloat(str); // 将字符串转换回 number 类型
      // })


      Row() {
        Image($r('app.media.Wooden_Fish'))
          .margin({left: 120, right: 10})
          .width(100)
          .height(100)
          .scale({ x: this.myScale, y: this.myScale })
          .onClick(() => {
            this.add()
          })

        Text("功德+1")
          .fontSize(1)
          .fontColor('#000000')
          .scale({ x: this.myScale_font, y: this.myScale_font })
          .margin({left:30,bottom:100})



      }
      .margin({top: 30})
      .width('95%')
      .height(300)
      .backgroundColor('#FFFFFF')
      .borderRadius(10)
      .shadow({ radius: 10, color: '#C0C0C0'})


      Row({space:30}) {

        Button("功德+1")
          .type(ButtonType.Normal)
          .borderRadius(130)
          .width(130)
          .height(130)
          .backgroundColor(Color.Gray)
          .fontSize(15)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .onClick(() => {
            this.add()
          })


        Button("自动功德+1")
          .type(ButtonType.Normal)
          .borderRadius(130)
          .width(130)
          .height(130)
          .backgroundColor(Color.Gray)
          .fontSize(15)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .onClick(() => {
            this.auto_add()
            if (this.isAutoIncrementing) {
              // 如果已经在自动增加，停止自动增加
              this.stopAutoIncrement();
              this.isAutoIncrementing = false;
            } else {
              // 否则，开始自动增加
              this.startAutoIncrement();
              this.isAutoIncrementing = true;
            }
          })
    }
    .margin({top: 120})
    .width('100%')
    .height(100)
    .justifyContent(FlexAlign.Center)


    }
    .width("100%")
    .height("100%")
    .backgroundColor('#F8F8FF')
  }

}
