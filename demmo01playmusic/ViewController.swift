//
//  ViewController.swift
//  demmo01playmusic
//
//  Created by Kien on 4/13/16.
//  Copyright © 2016 Kienpham. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    var player:AVAudioPlayer!
    var timer:Timer!
    var i:Int = 0
    var dong:Int!
    
    @IBAction func hienam(_ sender: AnyObject) {
        if  am == false{
            volume.alpha=1
            am=true
            
        }else{
            volume.alpha=0
            am=false
        }
        
        
    }
    
    @IBOutlet weak var volum: UIButton!
    var hinhanh:[String]=["ala.jpg","b copy.jpg","o.jpg","l.jpg","d.jpg"]
    
    
    
    @IBOutlet weak var myImage: UIImageView!
    
    
    @IBAction func amluong(_ sender: AnyObject) {
        player.volume=volume.value
    }
    
    @IBOutlet weak var volume: UISlider!{
        didSet{
            volume.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    var kiemtra,am:Bool!
    var player:AVAudioPlayer!
    
    
    @IBOutlet weak var myslide: UISlider!
    
    @IBOutlet weak var xuoi: UILabel!
    
    @IBOutlet weak var nguoc: UILabel!
    var ten:[String]=["fade","bom clap","counting stars","i live","angel of the morning"]
    
    @IBOutlet weak var see: UIButton!
    
    @IBOutlet weak var myTable: UITableView!
    
    
    
    
    @IBAction func chinh(_ sender: AnyObject) {
        player.currentTime=Double(myslide.value)
    }
    
    
    
    @IBAction func play(_ sender: AnyObject) {
        if kiemtra==true{
            player.pause()
            kiemtra=false
            let hinh=UIImage(named: "Play.png")
            see.setImage(hinh, for:UIControlState())
            timer.invalidate()
            
        }else{
            player.play()
            kiemtra=true
            let hinh=UIImage(named: "pause.p.g")
            see.setImage(hinh, for: UIControlState())
            timer=Timer.scheduledTimer(timeInterval: 1, target:self , selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        }
    }
    
    
    
    
    
       override func viewDidLoad() {
        super.viewDidLoad()
        volume.alpha=0
        myslide.alpha=1
        xuoi.alpha=0
        nguoc.alpha=0
//        myImage.layer.cornerRadius = 90
        self.myImage.layer.cornerRadius = self.myImage.frame.size.width / 2
        self.myImage.clipsToBounds = true
        myImage.layer.masksToBounds = true
        myImage.clipsToBounds=true
        myTable.delegate=self
        myTable.dataSource=self
        // Do any additional setup after loading the view, typically from a nib.
    }
    var t:CGFloat=CGFloat(M_PI_4)
    func update()
    {
        UIView.animate(withDuration: 1.0, animations: {  ()->
            Void in
            self.myImage.transform=CGAffineTransform(rotationAngle: self.t)
    })
        t=t+CGFloat(M_PI_4)
        if t==CGFloat(M_PI_4*9){
            t=CGFloat(M_PI_4)
        }
        myslide.value=myslide.value+1
        var m:Int=0
        var s:Int = 0
        m = (Int(myslide.value))/60
        s = Int(myslide.value) - m*60
        var time_m:String=m<10 ? "0\(m)":"\(m)"
        var time_s:String=s<10 ? "0\(s)":"\(s)"
        xuoi.text = time_m + ":" + time_s
//        var k:Int=dong + rp
        
        m=(Int(player.duration) - Int(myslide.value))/60
        s = (Int(player.duration)-Int(myslide.value))-m*60
        time_m="0\(m)"
        time_s = s<10 ? "0\(s)":"\(s)"
        nguoc.text = time_m + ":" + time_s
        let k:Int=dong + rp
        
        
        
if(m==0 && s==0)
{
    rp=rp+1
    if k<ten.count{
        myslide.value=0
        myImage.image=UIImage(named: hinhanh[k])
        playnhac(ten[k],type:"mp3")
        player.play()
        let index =
        IndexPath(row: k, section: 0)
        myTable.selectRow(at: index, animated: true, scrollPosition: UITableViewScrollPosition.none)
    }
        }
    }
    var rp:Int = 1
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ten.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text=ten[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        rp = 1
        dong = indexPath.row
        playnhac(ten[indexPath.row], type:"mp3")
        myImage.image=UIImage(named: hinhanh[indexPath.row])
        volume.maximumValue=0
        am=false
        volume.maximumValue=1
        volume.value=1
        player.volume=1
        myslide.alpha=1
        xuoi.alpha=1
        nguoc.alpha=1
        myslide.maximumValue=Float(player.duration)
        myslide.minimumValue=0
        myslide.value=0
        player.play()
        kiemtra=true
        let hinh1 = UIImage(named: "H.png")
        volume.setThumbImage(hinh1, for:UIControlState())
        if i==0{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
            i = i+1
        }else{
            timer.invalidate()
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Danh sach nhac"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func playnhac(_ ten:String,type:String){
        let duongdan = Bundle.main.path(forResource: ten, ofType: type)
        let url = URL(fileURLWithPath:duongdan!)
        do{
            player=try AVAudioPlayer (contentsOf: url)
            myslide.maximumValue = Float(player.duration)
        }
        catch{
            print("loi con may")
        }
    }
}

