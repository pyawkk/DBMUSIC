//
//  DBTableViewController.swift
//  DBMUSIC
//
//  Created by panyong on 15/2/5.
//  Copyright (c) 2015年 monileNowGroup. All rights reserved.
//

import UIKit

protocol selectChannelProtocol{
    func onChangeChannel(channelString:String)
}

class DBTableViewController: UITableViewController {
    var delegate :selectChannelProtocol?
    var channelArr:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return channelArr.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("db", forIndexPath: indexPath) as UITableViewCell
        var arr:NSDictionary = channelArr[indexPath.row] as NSDictionary
        var str = arr.valueForKey("name") as String
        cell.textLabel?.text = str
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //选择
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            var dic = self.channelArr[indexPath.row] as NSDictionary
            let url = dic.valueForKey("channel_id") as String
            self.delegate?.onChangeChannel(url)
        })
    }
    

   
}
