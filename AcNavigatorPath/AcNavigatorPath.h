//
//  AcNavigatorPath.h
//  AcNavigatorPath
//
//  Created by Anc on 16/1/26.
//  Copyright © 2016年 Ancc. All rights reserved.
//

#import <AppKit/AppKit.h>

@class AcNavigatorPath;

static AcNavigatorPath *sharedPlugin;

@interface AcNavigatorPath : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end




//'                :h8G895r,',
//'             ,hA@@@@@@@@#&5:',
//'            S#@Hs:;h&@@@@@@#3',
//'           8@@8      r&@@@@@@A;',
//'          9@@M;:r1r   :9#@@@@@M;',
//'         h@@@&ii391,   ;8GH@@@@B.',
//'        :#@@@8 ;5r:.       iA@@@5',
//'       .8@@@@G      ;s,:    .A@@#5',
//'       rB@@@@Bs,   .::. .;,  ;@@@M ,:',
//'      .XM@@@@#&;   sh;,..,.  h@@@B sr',
//'      .X@@@@@H@As,         ;9@@s8# si',
//'      sHM@@@@@@@@BXSsi::r19&@@@G 5,s1.',
//'      rF#P@.@e@g@gB&@&&F5P3.#e@g8  i3;,',
//'      rgM(@"@%@c@jSosi3n  hu@s@%@c,sih;i.',
//'      ,dGu@.@m@j@@@t  :;:SGM@@@@@&.:,:8&hir:',
//'       ;a@o@b@a@o@.Bc   1HM@@@@@@Ms:,;r5h;H@,',
//'        Go@m@"@)@;@G:   rsi&@@@@@@&:   ,:,X9,.',
//'     r8M@@@@@@@@@@@#8r.    G@@@@@@@B3;:,.:s::;',
//'   :G&B@@@@@@@@@@@@@@@MAXXXB@@@@@@@@@B31hi:,:;;',
//'   sGi.;3#@@@@@@@@@@@@@@@@@@@@@@@@@@@@#9rr;,,,i,',
//'    h1:  ,S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@Xhi.  ,r',
//'    13i,.  :X@@@@@@@@@@@@@@@@@@@@@@@@@@MXh...,;r:',
//'    iXh;,..  9@@@@@@@@@@@@@@@@@@@@@@@@@@MA9hr;:is:',
//'    ,X9r:,,.. 3@@@@@@@@@@@@@@@@@@@@@@@@@@@@G5s;;sh,',
//'     9&5i;:,,. S@@@@@@@@@@@@@@@@@@@@@@@@@@@B9hsrsh1',
//'     sBG9&7&5&3&1:61,31&11&9&7&5&3&1:51,31&11&9&7&5&',
//'     3&1:41,33&13&92&72&52&32&12&91&71&51&31&11&9&7&5',
//'      &3&1:31,52&32&12&91&71&51&31&11&9&7&5&3&1:21@631'

