//
//  HttpController.swift
//  DBMUSIC
//
//  Created by panyong on 15/2/5.
//  Copyright (c) 2015年 monileNowGroup. All rights reserved.
//

import UIKit

protocol HttpProtocol{
    func didRecieveResults(results:NSDictionary)
}


class HttpController: NSObject, NSURLConnectionDataDelegate,NSURLConnectionDelegate{
    var delegate:HttpProtocol?
    var data: AnyObject?
    var conn: NSURLConnection!
    func onSearch(url:String){
        var nsUrl:NSURL=NSURL(string:url)!
        var request:NSMutableURLRequest=NSMutableURLRequest(URL:nsUrl)
        request.HTTPMethod = "GET"
        request.timeoutInterval = 20
        var response:NSURLResponse?
        var error:NSError?

//         data = NSURLConnection.sendSynchronousRequest(request,returningResponse:&response,error:&error) as NSData?
//        
//        if error == nil{
//            var jsonResult:NSDictionary = NSJSONSerialization.JSONObjectWithData(data? as NSData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//            self.delegate?.didRecieveResults(jsonResult)
//        }
        
        
        NSURLConnection.sendAsynchronousRequest(request,queue:NSOperationQueue.mainQueue(),completionHandler:{
            (response: NSURLResponse!,data:NSData!,error:NSError!)-> Void in
            if error == nil && data?.length > 0{
                var jsonResult:NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                self.delegate?.didRecieveResults(jsonResult)
            }
        })
        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse?,data:NSData?,error:NSError!)->Void in
//            var jsonResult:NSDictionary=NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//            self.delegate?.didRecieveResults(jsonResult)
//        })
    }
}
