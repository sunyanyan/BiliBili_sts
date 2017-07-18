#  模仿Bilibili（Bilibili - ( ゜- ゜)つロ 乾杯~）
> 练习工程 模仿bilibili

![](./BiliBili_sts/Res/quickLook.gif)

##  接口

>使用 m.bilibili.com中使用的

###  首页接口

* 滚动推荐: http://api.bilibili.com/x/web-show/res/loc?jsonp=jsonp&pf=7&id=1695
* 最近搜索关键词排行 ：http://www.bilibili.com/search?action=hotword&main_ver=v1
* 3天内排行： http://www.bilibili.com/index/ranking-3day.json
* 番剧更新：http://www.bilibili.com/api_proxy?app=bangumi&action=timeline_v2
* 科技区/动画区等各个区的排行：http://m.bilibili.com/index/ding.html
    * 修改为 http://api.bilibili.com/x/web-interface/dynamic/index?jsonp=jsonp
* 直播推荐: http://api.live.bilibili.com/h5/recommendRooms?callback=jQuery17209296492127193972_1494936264824&_=1494936265374

####  滚动推荐

>http://api.bilibili.com/x/web-show/res/loc?jsonp=jsonp&pf=7&id=1695

该链接在 m.bilibili.com/index.html 源代码254行产生。

### 播放

比如： http://m.bilibili.com/video/av11413190.html 

* 视频：http://tx.acgvideo.com/9/55/18869362-1.mp4?txTime=1498036248&platform=html5&txSecret=118d82eb2e76a4a3d9f92e7e27d9deb8&oi=3078728740&rate=110000
    * 视频链接来自于：
        * http://api.bilibili.com/playurl?callback=callbackfunction&aid=11413190&page=1&platform=html5&quality=1&vtype=mp4&type=jsonp&token=4ad38e0fb723286165c5e492335a21d1
        * playurl链接由其他js脚本拼接而成，(其中token参数没有也没关系)那么知道aid就可以获得拼接后的链接了。
        * playurl链接需要cookies
* 弹幕: http://comment.bilibili.com/18869362.xml
    * 18869362 为cid
    * cid 也由playurl请求中返回

##  第三方

* [Alamofire](https://github.com/Alamofire/Alamofire) 网络请求
* [GDPerformanceView](https://github.com/dani-gavrilov/GDPerformanceView-Swift) 显示fps
* [SnapKit](https://github.com/SnapKit/SnapKit) autolayout
* [HandyJSON](https://github.com/alibaba/HandyJSON) json序列化
* [SDWebImage](https://github.com/rs/SDWebImage) image downloader with cache support
* [Refresher](https://github.com/jcavar/refresher) 一个可以简单自定义刷新视图的下拉刷新组件

* 弃用
    * [PageMenu](https://github.com/PageMenu/PageMenu) 分页（自定义麻烦）
    * [iOSPalette](https://github.com/tangdiforx/iOSPalette)获取图片主色调（有比较大几率获取到不正确的颜色）	

## 文件模板

### viewcontroller

>life cycle & property

>setup UI & add Constraints
