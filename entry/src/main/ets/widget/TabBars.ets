import { TabItem, tabsList } from '../net/model/InitalData'
import { Home } from '../pages/Home'
import { Square } from '../pages/Square'
import { Mine } from '../pages/Mine'
import { Wechat } from '../pages/Wechat'
import { TreeTab } from '../pages/TreeTab'

@Component
export struct TabBars {
  private tabsController = new TabsController()
  @State currentIndex: number = 0
  @State list: TabItem[] = tabsList

  @Builder
  TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 24, height: 24 })
        .fillColor(this.currentIndex === targetIndex ? $r("app.color.red") : $r("app.color.navi_tab_unselect"))
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? $r("app.color.red") : $r("app.color.navi_tab_unselect"))
        .fontSize(11)
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r("app.color.navi_bar_bg"))
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex
      this.tabsController.changeIndex(targetIndex)
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      ForEach(this.list, (item: TabItem, index: number) => {
        TabContent() {
          if (index == 0) {
            Home()
          } else if (index == 1) {
            Square()
          } else if (index == 2) {
            TreeTab()
          } else if (index == 3) {
            Wechat()
          } else {
            Mine()
          }
        }
        .tabBar(this.TabBuilder(item.title, item.index, item.sel_icon, item.unSel_icon)) // 标题
      })

    }.onChange((index: number) => {
      this.currentIndex = index
    })
    .scrollable(false)
    .backgroundColor($r("app.color.start_window_background"))
  }
}
