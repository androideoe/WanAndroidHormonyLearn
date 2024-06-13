export class TabItem {
  title: string;
  index: number;
  sel_icon: Resource;
  unSel_icon: Resource;

  constructor(title: string, index: number, sel_icon: Resource, unSel_icon: Resource) {
    this.title = title
    this.index = index
    this.sel_icon = sel_icon
    this.unSel_icon = unSel_icon
  }
}

export const tabsList: TabItem[] = [
  new TabItem('首页', 0, $r('app.media.ic_tab_home_fill'), $r('app.media.ic_tab_home')),
  new TabItem('广场', 1, $r('app.media.ic_tab_discover_fill'), $r('app.media.ic_tab_discover')),
  new TabItem('体系', 2, $r('app.media.ic_tab_tree_fill'), $r('app.media.ic_tab_tree')),
  new TabItem('公众号', 3, $r('app.media.ic_tab_wechat_fill'), $r('app.media.ic_tab_wechat')),
  new TabItem('我的', 4, $r('app.media.ic_tab_my_fill'), $r('app.media.ic_tab_my'))
]