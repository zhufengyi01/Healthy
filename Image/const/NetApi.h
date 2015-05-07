//
//  NetApi.h
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/4.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#ifndef ________NetApi_h
#define ________NetApi_h
//首页
//新闻资讯

#define ApiBase        @"http://www.yi18.net/"
//1、取得资讯信息列表

#define ApiNewList     @"http://api.yi18.net/news/list"

//2、取得资讯分类列表

#define ApiNewClass    @"http://api.yi18.net/news/newsclass"

//3、取得资讯信息详细

#define ApiNewDetail    @"http://api.yi18.net/news/show"

//4、搜索资讯

#define ApiNewSearch    @"http://api.yi18.net/news/search?_dc=1389418170037&keyword=%@"

//文化知识
#define ApiKnoleList     @"http://api.yi18.net/lore/list"

#define ApiKnoleDetail     @"http://api.yi18.net/lore/show"

#define ApiFoodcategory   @"http://api.yi18.net/cook/cookclass"
#endif
