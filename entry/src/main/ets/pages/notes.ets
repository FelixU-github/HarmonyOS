// pages/NotesPage.ets
@Entry
@Component
struct NotesPage {
  // 保存事项的数组
  @State notes: string[] = ['事项1','事项2','事项3'];
  // 保存新事项的输入内容
  @State newNote: string = '';

  build() {
    Column() {
      //应用名
      Text('石小石的记事本')
        .fontSize(24)
        .fontColor('#003eb3')
        .margin({ top: 20, bottom: 20 });
      // 文本输入
      TextInput({
        // text 绑定到 newNote 状态，用于存储输入内容。
        text: this.newNote,
        placeholder: '添加新的事项',
      }).width('80%').margin({ bottom: 10 }).padding(10).fontSize(16).borderColor('#ccc').borderWidth(1).borderRadius(5)

      // 添加按钮
      Button('添加').width('80%').padding(10).fontSize(16).backgroundColor('#007AFF').fontColor('#FFF').borderRadius(5)

      // 渲染列表
      List() {
        ForEach(this.notes,(item:string,index:number)=>{
          ListItem(){
            Row(){
              Text(item).fontColor('#001d66')
              Button('删除').fontSize(14).height(18).backgroundColor('#ff4d4f').type(ButtonType.Normal).borderRadius('15%').padding({left:10,right:10})
            }.width("100%").justifyContent(FlexAlign.SpaceBetween).backgroundColor('#bae0ff').margin({bottom:5}).padding(5)
          }
        })
      }.width('80%').margin({ top: 20 })
    }.width('100%').backgroundColor('#e6f4ff').height("100%")
  }
}
