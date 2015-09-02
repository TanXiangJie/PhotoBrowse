//
//  Const.swift
//  BaiduFM
//
//  Created by lumeng on 15/4/23.
//  Copyright (c) 2015年 lumeng. All rights reserved.
//

import Foundation

// MARK: - 通知
let CHANNEL_MUSIC_LIST_CLICK_NOTIFICATION = "CHANNEL_MUSIC_LIST_CLICK_NOTIFICATION" //某类别歌曲列表点击通知

let OTHER_MUSIC_LIST_CLICK_NOTIFICATION = "OTHER_MUSIC_LIST_CLICK_NOTIFICATION" //下载，喜欢，最近播放列表点击通知

// MARK: - 常量

//获取歌曲分类列表
let http_channel_list_url = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedan&page_no=1&page_size=30&from=ios&version=5.2.7&from=ios&channel=appstore"
//获取某个分类歌曲类别 http_song_list_url + "分类名"

let http_song_list_url = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios"

//获取歌曲info信息
let http_song_info = "http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.song.getInfos&ts=1439540214&songid="
//
//获取歌曲link信息
let http_song_link = "&listid=5659&version=5.2.7&from=ios&channel=appstore"

let http_song_lrc = "http://fm.baidu.com"
