//
//  ViewController.swift
//  DBMUSIC
//
//  Created by panyong on 15/2/4.
//  Copyright (c) 2015年 monileNowGroup. All rights reserved.
//

import UIKit
import MediaPlayer


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,HttpProtocol,selectChannelProtocol {

    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var progroView: UIView!
    
    @IBOutlet weak var dbCell: UITableView!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var showBtn: UIButton!
    var eHttp:HttpController?
    var dataArr : NSMutableArray = []
    var nextData : NSMutableArray = []
    var imageCache = Dictionary<String,UIImage>()
    var audioPlay : MPMoviePlayerController = MPMoviePlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eHttp = HttpController()
        eHttp?.delegate = self;
        eHttp?.onSearch("http://douban.fm/j/mine/playlist?channel=0")
        eHttp?.onSearch("http://www.douban.com/j/app/radio/channels")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentRowData = self.dataArr[indexPath.row] as NSDictionary
        var misicSrc = currentRowData.valueForKey("url") as String
        self.playMusic(misicSrc)
        
        let cell = dbCell.cellForRowAtIndexPath(indexPath) as customTableViewCell
        var pic:UIImage = cell.imgV.image!
        self.setCurrentPlayImage(pic)
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:customTableViewCell = tableView.dequeueReusableCellWithIdentifier("douban") as customTableViewCell
        var rowData:NSDictionary = self.dataArr[indexPath.row] as NSDictionary
        var url=rowData["picture"] as String
        var image = self.imageCache[url] as UIImage!
        var str:String = rowData["title"] as String
        var timeString:String = rowData["artist"] as String
        cell.imgV.image = UIImage(named:"detail.jpg")
        cell.title.text = str //rowData["title"] as String
        cell.time.text = timeString //rowData["length"] as String
        if image == nil {
            let imgURL:NSURL = NSURL(string:url)!
            let request:NSURLRequest=NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
                var img = UIImage(data:data)
                self.imageCache[url]=img
                cell.imgV.image = img
            })
        }else{
            cell.imgV = UIImageView(image:image)
        }
        return cell
    }
    
    func didRecieveResults(results: NSDictionary) {
        if results["song"] != nil{
            dataArr = []
            var arr = results.valueForKey("song") as NSArray
            dataArr.addObjectsFromArray(arr)
            self.dbCell.reloadData()
        }else if (results["channels"] != nil) {
            self.nextData = results["channels"] as NSMutableArray
        }
    }
    
    func playMusic(url:NSString){
        audioPlay.stop()
        audioPlay.contentURL = NSURL(string: url)
        audioPlay.play()
    }
    func setCurrentPlayImage(img:UIImage){
        self.iv.image = img
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var channel:DBTableViewController = segue.destinationViewController as DBTableViewController
        channel.channelArr = self.nextData
        channel.delegate = self
        
    }
    
    func onChangeChannel(channelString:String){
        eHttp = HttpController()
        eHttp?.delegate = self;
        eHttp?.onSearch("http://douban.fm/j/mine/playlist?channel=\(channelString)")
        println("http://douban.fm/j/mine/playlist?channel=\(channelString)")
    }
    
    
    

}

