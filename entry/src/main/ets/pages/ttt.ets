import { router } from '@kit.ArkUI';
import { UIContext } from '@kit.ArkUI';

@Entry
@Component
struct Rest {
  @State myScale: number = 1.0;
  @State myScale_font: number = 1.0;
  @State meritCount: number = 0; // 功德计数
  @State isAutoIncrementing: boolean = false; // 自动增加标志
  uiContext: UIContext | undefined = undefined;
  autoIncrementInterval: number | undefined = undefined; // 定时器引用

  aboutToAppear() {
    this.uiContext = this.getUIContext?.();
  }

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

      Row() {
        Image($r('app.media.Wooden_Fish'))
          .margin({left: 120, right: 10})
          .width(100)
          .height(100)
          .scale({ x: this.myScale, y: this.myScale })
          .onClick(() => {
            if (!this.uiContext) {
              console.info("no uiContext, keyframe failed");
              return;
            }
            this.myScale = 1;
            this.myScale_font = 1;
            // 设置关键帧动画整体播放1次
            this.uiContext.keyframeAnimateTo({ iterations: 1 }, [
              {
                duration: 400,
                event: () => {
                  this.myScale = 1.5;
                  this.myScale_font = 30;
                }
              },
              {
                duration: 400,
                event: () => {
                  this.myScale = 1;
                  this.myScale_font = 0;
                }
              }
            ]);
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
            if (!this.uiContext) {
              console.info("no uiContext, keyframe failed");
              return;
            }
            this.myScale = 1;
            this.myScale_font = 0;

            this.uiContext.keyframeAnimateTo({ iterations: 1 }, [
              {
                duration: 400,
                event: () => {
                  this.myScale = 1.5;
                  this.myScale_font = 20;
                }
              },
              {
                duration: 400,
                event: () => {
                  this.myScale = 1;
                  this.myScale_font = 0;
                }
              }
            ]);

            // 增加功德计数
            this.meritCount += 1;
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

      // 显示功德计数
      Row() {
        Text(`当前功德：${this.meritCount}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 20 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

    }
    .width("100%")
    .height("100%")
    .backgroundColor('#F8F8FF')
  }
}