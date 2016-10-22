//
//  TVEvent.swift
//  SDKFrontiOS
//
//  Created by Jonathan Castro Miguel on 22/10/16.
//  Copyright © 2016 Tagsonomy. All rights reserved.
//

import Foundation
import SwiftyJSON

internal class TVEvent : NSObject, Validatable{
    
    var tvEventId : String;
    var channelId : String;
    var channelName : String;
    var startDate : Int;
    var card : MiniCard;
    var alarmMinutesBefore : Int?;
    
    init(data: JSON){
        
        //validated variables
        self.tvEventId = data["tv_event_id"].object as! String;
        self.channelId = data["channel_id"].object as! String;
        self.channelName = data["channel_name"].object as! String;
        self.startDate = data["start_date"].intValue;
        self.card = MiniCard(data: data["mini_card"]);
        
        if let _alarmMinutesBefore = data["alarm_minutes_before"].int{
            self.alarmMinutesBefore = _alarmMinutesBefore;
        }
        
        super.init();
    }
    
    class func validate(data: JSON?) throws{
        
        guard let _data = data where _data != nil else{
            try DataModelErrors.ThrowError(DataModelErrors.CreateTVEventErrors.emptyData);
            return;
        }
        
        guard case let (_tvEventId as String, _channelId as String, _channelName as String) = (_data["tv_event_id"].object, _data["channel_id"].object, _data["channel_name"].object)
            where _tvEventId != "" && _channelId != "" && _channelName != "" && _data["start_date"].int != nil else{
                //Throw indavilData Error
                try DataModelErrors.ThrowError(DataModelErrors.CreateTVEventErrors.invalidData);
                return;
        }
        
        try MiniCard.validate(_data["mini_card"]);
    }
}