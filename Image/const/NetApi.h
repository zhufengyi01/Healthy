//
//  NetApi.h
//  测试使用侧边栏
//
//  Created by 风之翼 on 15/5/4.
//  Copyright (c) 2015年 风之翼. All rights reserved.
//

#ifndef ________NetApi_h
#define ________NetApi_h
#pragma mark  ----首页
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


#pragma mark    -----健康常识
//1.文化知识列表
#define ApiKnoleList     @"http://api.yi18.net/lore/list"
//2.文化知识详细
#define ApiKnoleDetail     @"http://api.yi18.net/lore/show"


#pragma  mark -----健康饮食
//1.取得食谱分类
#define ApiFoodcategory   @"http://api.yi18.net/cook/cookclass"

//2.取得食谱列表
#define ApiFoodList       @"http://api.yi18.net/cook/list"

//3 取得食谱详细信息
#define ApiFoodDetail     @"http://api.yi18.net/cook/show"
#endif
