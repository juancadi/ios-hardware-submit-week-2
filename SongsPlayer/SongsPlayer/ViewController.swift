//
//  ViewController.swift
//  SongsPlayer
//
//  Created by JUAN ANDRÉS CÁRDENAS DIAZ on 12/04/16.
//  Copyright © 2016 JUAN ANDRÉS CÁRDENAS DIAZ. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var imgCover: UIImageView!
    
    @IBOutlet weak var imgVolumen: UIImageView!
    
    @IBOutlet weak var lblSongDescription: UILabel!
    
    @IBOutlet weak var sliderVolume: UISlider!
    
    var reproductor : AVAudioPlayer!
    
    let songs: [Song] = [
    
        Song(name: "Blurred Lines", artist: " Robin Thicke ft Pharrel", cover: "blurred-lines", audio: "blurred-lines", audioExtension: "mp3"),
        Song(name: "Could You Be Loved", artist: "Bob Marley", cover: "could-you-be-loved", audio: "could-you-be-loved", audioExtension: "mp3"),
        Song(name: "Counting Stars", artist: "One Republic", cover: "counting-stars", audio: "counting-stars", audioExtension: "mp3"),
        Song(name: "Locked Out Of Heaven", artist: "Bruno Mars", cover: "locked-out-of-heaven", audio: "locked-out-of-heaven", audioExtension: "mp3"),
        Song(name: "Paint It, Black", artist: "Rolling Stones", cover: "paint-it-black", audio: "paint-it-black", audioExtension: "mp3"),
        Song(name: "P.I.M.P", artist: "50 Cent", cover: "pimp", audio: "pimp", audioExtension: "mp3"),
        Song(name: "Repent", artist: "Shaggy", cover: "repent", audio: "repent", audioExtension: "mp3"),
        Song(name: "Shoop", artist: "Salt N Pepa", cover: "shoop", audio: "shoop", audioExtension: "mp3"),
        Song(name: "Titanium", artist: "David Guetta", cover: "titanium", audio: "titanium", audioExtension: "mp3"),
        Song(name: "Wiggle", artist: "Jason Derulo", cover: "wiggle", audio: "wiggle", audioExtension: "mp3")
        
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let soundUrl = NSBundle.mainBundle().URLForResource(songs[0].audio, withExtension: songs[0].audioExtension)
        
        do{
            
            try reproductor = AVAudioPlayer(contentsOfURL: soundUrl!)
            reproductor.volume = sliderVolume.value
            
        }catch{
            
            print("Error al cargar el archivo de sonido")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tapStop(sender: AnyObject) {
        
        if reproductor.playing {
            
            reproductor.stop()
            reproductor.currentTime = 0
            
            
        }
    }
    
    @IBAction func tapPlay(sender: AnyObject) {
        
        if !reproductor.playing {
            
            reproductor.play()
        }
    }
    
    @IBAction func tapPause(sender: AnyObject) {
        
        if reproductor.playing {
            
            reproductor.pause()
            
        }
    }
    
    @IBAction func tapShuffle(sender: AnyObject) {
        
        if reproductor.playing {
            
            reproductor.stop()
            reproductor.currentTime = 0
            
        }
        
        prepareAudioForPlay(songs[Int(arc4random_uniform(10))])
        reproductor.play()
        
        
    }

    @IBAction func changeVolume(sender: UISlider) {
        
        
        
        let selectedValue = Float(sender.value)
        
        if selectedValue != 0.0{
            imgVolumen.image = UIImage(named: "volume-gray")
        }else{
            imgVolumen.image = UIImage(named: "volume-mute")
        }
        
        reproductor.volume = selectedValue
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SongCell", forIndexPath: indexPath)
        cell.textLabel?.text = songs[indexPath.row].name
        cell.detailTextLabel?.text = songs[indexPath.row].artist
        cell.imageView?.image = UIImage(named: songs[indexPath.row].cover!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //print("SONG \(indexPath.row) selected: \(songs[indexPath.row].name)")
        
        if reproductor.playing {
            
            reproductor.stop()
            reproductor.currentTime = 0
            
        }
        
        prepareAudioForPlay(songs[indexPath.row])
        reproductor.play()
    }
    
    
    func prepareAudioForPlay(song : Song){
        
        imgCover.image = UIImage(named: song.cover!)
        lblSongDescription.text = "\(song.name!), by \(song.artist!)"
    
        let soundUrl = NSBundle.mainBundle().URLForResource(song.audio, withExtension: song.audioExtension)
        
        do{
            
            try reproductor = AVAudioPlayer(contentsOfURL: soundUrl!)
            
        }catch{
            
            print("Error al cargar el archivo de sonido")
            
        }
    
    
    }


}

