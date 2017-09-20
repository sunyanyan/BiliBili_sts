//
//  TSPlayerCommentModel.swift
//  BiliBili_sts
//
//  Created by sts on 2017/8/10.
//  Copyright © 2017年 sts. All rights reserved.
//

import Foundation
//评论信息
class TSPlayerCommentModel:TSBaseModel{
    required init() {
        super.init()
    }
    var data:TSPlayerCommentDataModel?
}

class TSPlayerCommentDataModel:TSBaseModel{
    required init() {
        super.init()
    }
    var replies:[TSPlayerCommentReplyModel]?
}

class TSPlayerCommentReplyModel:TSBaseModel{
    required init() {
        super.init()
    }
    var oid:String?
    var ctime:String?
    var member:TSPlayerCommentMemberModel?
    var content:TSPlayerCommentContentModel?
    var replies:[TSPlayerCommentReplyModel]?
}
class TSPlayerCommentMemberModel:TSBaseModel{
    required init() {
        super.init()
    }
    var uname:String?
    var sign:String?
    var avatar:String?
}

class TSPlayerCommentContentModel:TSBaseModel{
    required init() {
        super.init()
    }
    var message:String?
}
