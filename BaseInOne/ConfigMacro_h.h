//
//  ConfigMacro_h.h
//  qujiyi
//
//  Created by jason on 2019/6/6.
//  Copyright © 2019 jason. All rights reserved.
//

#ifndef ConfigMacro_h_h
#define ConfigMacro_h_h

//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//Build号
#define kAppBuildVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//一些缩写
#define kKeyWindow          [UIApplication sharedApplication].keyWindow

/// iPhone X 边距
#define iPhoneXPortraitTopPadding 34.0f
#define iPhoneXPortraitBottomPadding iPhoneXPortraitTopPadding
#define iPhoneXLandscapeLeftPadding iPhoneXPortraitTopPadding
#define iPhoneXLandscapeRightPadding iPhoneXPortraitTopPadding

//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ 尺寸 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
#define kFSScreenWidth [UIScreen mainScreen].bounds.size.width
#define kFSScreenHeight [UIScreen mainScreen].bounds.size.height

#define KFit6P_W(WIDTH)  ((WIDTH) /(1920.0/2208.0))/3.0 * ((kFSScreenWidth)/414.0)
#define KFit6P_H(HEIGHT)  ((HEIGHT) /(1920.0/2208.0))/3.0 * ((kFSScreenHeight /736.0))
#define KFit6S_W(WIDTH)  ((WIDTH)/2.0*((kFSScreenWidth)/375.0))
#define KFit6S_H(HEIGHT)  ((HEIGHT)/2.0*((kFSScreenHeight)/667.0))
#define kFit6Font(x) (kFSScreenWidth*((x)/375.0))

// 基准屏幕宽度
#define kRefereWidth 375.0
// 以屏幕宽度为固定比例关系，来计算对应的值。假设：基准屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
#define AdaptW(floatValue) (floatValue*[[UIScreen mainScreen] bounds].size.width/kRefereWidth)


//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ 颜色 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
//颜色
#define kRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define SHORTCOLOR(r)          ([UIColor colorWithRed:(r)/255.0f green:(r)/255.0f blue:(r)/255.0f alpha:(1)])

#define kRandomColor  [UIColor colorWithRed:(arc4random_uniform(256))/255.0 green:arc4random_uniform(256)/255.0 blue:(arc4random_uniform(256))/255.0 alpha:1.0]
#define RGB(r, g, b) kRGBColor(r,g,b)
#define RGBA(r, g, b,a) kRGBAColor(r,g,b,a)
//主题颜色 // FF6600   FF8533
//#define GGColor kRGBColor(255,102,0)
#define GGColor kRGBColor(255,133,51)
#define GGGrayBarColor kRGBColor(51,51,51)

#define kRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kMainColor                              [UIColor colorWithHexString:@"67CDD5"]
#define kSubColor                               [UIColor colorWithHexString:@"FE5420"]
#define kBGColor                               [UIColor colorWithHexString:@"F4FFEE"]
#define kGrayColor                              [UIColor colorWithHexString:@"EAEAEA"]

#define kMainTextColor                        [UIColor colorWithHexString:@"67CDD5"]  




// .h
#define single_interface(class) +(class *) shared##class;

// .m
// \ 代表下一行也属于宏
// ## 是分隔符
#define single_implementation(class, initPrivate)                                                                                                              \
\
+(class *) shared##class {                                                                                                                                 \
static class *_instance;                                                                                                                               \
static dispatch_once_t onceToken;                                                                                                                      \
dispatch_once(&onceToken, ^{                                                                                                                           \
_instance = [[self alloc] initPrivate];                                                                                                            \
});                                                                                                                                                    \
return _instance;                                                                                                                                      \
} - (instancetype) init {                                                                                                                                  \
@throw [NSException exceptionWithName:@"Singleton" reason:@"Singleton should not be init again" userInfo:nil];                                         \
return nil;                                                                                                                                            \
}

//开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define KKLog(...) NSLog(@"%s [line:%d] %@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define KKLog(...)
#endif

//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ Notification ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
#define kUserLoginNotification @"kUserLoginNotification"
#define kUserLogoutNotification @"kUserLogoutNotification"
#define kUserPersonalInfoChangeNotification @"kUserPersonalInfoChangeNotification"
#define kUserCourseChangeNotification @"kUserCourseChangeNotification"
#define kExamFinishNotification @"kExamFinishNotification"



//#define kShouldShowGroupMemberNotification @"kShouldShowGroupMemberNotification"
//#define kKeyboardShouldShowNotification @"kKeyboardShouldShowNotification"
//#define kReplaceTELNotification @"kReplaceTELNotification"
//#define kAskCanlendarTitleDateNotificaton @"kAskCanlendarTitleDateNotificaton"
//#define kAnswerCanlendarTitleDateNotificaton @"kAnswerCanlendarTitleDateNotificaton"
//#define kInputBarWillShowNotification @"kInputBarWillShowNotification"
//#define kInputBarWillHideNotification @"kInputBarWillHideNotification"
//#define kDidReceiveRemoteNotification @"kDidReceiveRemoteNotification"
//#define kGlobalJumpWillJumpNotification @"kGlobalJumpWillJumpNotification"
//#define kDownloadIsEmptyNotification @"kDownloadIsEmptyNotification"
//#define kCollectionIsEmptyNotification @"kCollectionIsEmptyNotification"

///三方支付完成 服务器返回"已完成"or轮询超时 发送此通知 status = 0:成功 1:失败
//#define kFSThreePartyPaymentCompletionNotification @"kThreePartyPaymentCompletionNotification"

//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ NSUserDefaults Keys ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
#define UDKey_AppConfigGlobalInfo @"UDKey_AppConfigGlobalInfo"

#define UDKey_AppAccountLoginDate @"UDKey_AppAccountLoginDate"

#define UDKey_UserID                    @"UDKey_UserID"
#define UDKey_UserInfoPrefix                  @"UDKey_UserInfoPrefix"
#define UDKey_BUY_TYPE_SELF             @"UDKey_BUY_TYPE_SELF"
//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ 标签Keys ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
#define FSGuideIsShowed @"FSGuideIsShowed"
#define FSGuideLearnShowed @"FSGuideLearnShowed"
#define FSGuideSlideShowed @"FSGuideSlideShowed"


//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ 第三方账号 ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
#ifdef UUSSEERR
#define BUGLY_APPID                             @"d93b0520c4" //bugly(已改)
#else
#define BUGLY_APPID                             @"104cbb719d" //bugly(已改)
#endif
//#define MWA_APPID                               @"KEMRGGPQY08XQY7PKKQ5Q1LHH1G83YKH" //魔窗(已改)
//#define MWA_HOST                                @"lxeap.cn" //魔窗host
//#define MWA_SCHEME                              @"lixin" //魔窗scheme
//#define TTencentAppKey                          @"1105807776" //QQ AppKey
//#define TWeChatAppKey                           @"wx650dfef049626c82" //微信AppKey(已改)wx65e7a1747b2ea0ea
//#define TWeChatAppSecret                        @"51b18cbcbdd740a389868c0edb2abc7c" //微信AppSecret(已改)
//#define TSinaAppKey                             @"880074791" //新浪AppKey
//#define TSinaRedirectURI                        @"" //新浪A。gh_d09d5c26733d
//#define SMALL_PROGRAM_ORIGINAL_ID               @"gh_d09d5c26733d" //小程序原始ID
//
//#ifdef DEBUG
//#define ZHUGE_APPKEY                            @"e1fdd59a9a3341ee92b4ff13074643f0" //诸葛IO
//#define JPUSH_APPKEY                            @"0a2159f9c99c1530d04ad2c4" //极光推送(已改)
//#define RONGCLOUD_KEY                           @"8brlm7uf8zxq3" //融云(已改)
//#else
//#define ZHUGE_APPKEY                            @"1963f16bf5854a4f96dbe30d734eae1a" //诸葛IO
//#define JPUSH_APPKEY                            @"0a2159f9c99c1530d04ad2c4" //极光推送(已改)
//#define RONGCLOUD_KEY                           @"lmxuhwaglifed" //融云(已改)
//#endif

//YY和RAC都有这个宏，s会报warning，所以自己写一下
#ifndef fs_weakify
#if DEBUG
#if __has_feature(objc_arc)
#define fs_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define fs_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define fs_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define fs_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef fs_strongify
#if DEBUG
#if __has_feature(objc_arc)
#define fs_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define fs_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define fs_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define fs_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* ConfigMacro_h_h */
