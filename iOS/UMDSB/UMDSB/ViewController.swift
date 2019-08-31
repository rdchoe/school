//
//  ViewController.swift
//  UMDSB
//
//  Created by Robert Choe on 3/17/18.
//  Copyright © 2018 Robert Choe. All rights reserved.
//
/*We may need to take on a divde and conquer approach using multiple threads*/
import UIKit
import SwiftSoup

class Course {
    private var courseCode: String = String()
    private var section: String = String()
    private var teacher: String = String()
    private var openSeats: String = String()
    private var monday = [String]()
    private var tuesday = [String]()
    private var wednesday = [String]()
    private var thursday = [String]()
    private var friday = [String]()
    private var buildingCode = [String]()
    private var roomNumber = [String]()
    
    init() {
        
    }
    func getCourseCode() -> String {
        return courseCode
    }
    func getSection() -> String {
        return section
    }
        
    func setName(code: String) {
        courseCode = code
    }
    func getMon() -> Array<String> {
        
        return monday
    }
    func getTues() -> Array<String>{
        
        return tuesday
    }
    func getWed() -> Array<String>{
      
        return wednesday
    }
    func getThurs() -> Array<String>{
        
        return thursday
    }
    func getFri() -> Array<String>{
       
        return friday
    }
    
    func getTeacher() -> String {
        return teacher
    }
    
    func getBuildingCode() -> Array<String> {
        return buildingCode
    }
    
    func getRoomNumber() -> Array<String>{
        return roomNumber
    }
    func toString() {
        print(courseCode)
        print("Section: \(section)")
        print("Teacher: \(teacher)")
        print("Monday: \(monday)")
        print("Tuesday: \(tuesday)")
        print("Wednesday: \(wednesday)")
        print("Thursday: \(thursday)")
        print("Friday: \(friday)")
        print("Building Codes: \(buildingCode)")
        print("Room Numbers: \(roomNumber)")
    }
    
    func parse(sourceCode: String) {
/*
 1 : 0102 (Section)
 2 : Alan Sussman (Teacher)
 3 : 13 (Open Seats)
 4 : 0 (Waitlist)
 5 : TuTh (Lecture Day)
 6 : 5:00pm (Begin Time)
 7 : 6:15pm (End Time)
 8 : CSI (Building Code)
 9 : 3117 (Room Number)
 10 : MW (Disc Day)
 11 : 9:00am (Begin Time)
 12 : 9:50am (End Time)
 13 : CSI (Building Code)
 14 : 1122 (Room Number)
*/
        /* MTH on engl246 i think doesnt work*/
        let pattern = "(?:(.*) (.* .*) Seats \\(Total:.*, Open: (.*), Waitlist: (.*) \\) (.*) (.*) - (.*) (.*) (.*) (.*) (.*) - (.*) (.*) (.*)) |(.*) (.* .*) Seats \\(Total:.*, Open: (.*), Waitlist: (.*) \\) (.*) (.*) - (.*) (.*) (.*)"
        let matched = matches(for: pattern, in: sourceCode)
        section = matched[1]
        teacher = matched[2]
        openSeats = matched[3]
        switch matched[5] {
        case "M":
            monday.append(matched[6])
            monday.append(matched[7])
        case "Tu":
            tuesday.append(matched[6])
            tuesday.append(matched[7])
        case "W":
            wednesday.append(matched[6])
            wednesday.append(matched[7])
        case "Th":
            thursday.append(matched[6])
            thursday.append(matched[7])
        case "F":
            friday.append(matched[6])
            friday.append(matched[7])
        case "MW":
            monday.append(matched[6])
            monday.append(matched[7])
            wednesday.append(matched[6])
            wednesday.append(matched[7])
        case "MF":
            monday.append(matched[6])
            monday.append(matched[7])
            friday.append(matched[6])
            friday.append(matched[7])
        case "MWF":
            monday.append(matched[6])
            monday.append(matched[7])
            wednesday.append(matched[6])
            wednesday.append(matched[7])
            friday.append(matched[6])
            friday.append(matched[7])
        case "TuW":
            tuesday.append(matched[6])
            tuesday.append(matched[7])
            wednesday.append(matched[6])
            wednesday.append(matched[7])
        case "TuTh":
            tuesday.append(matched[6])
            tuesday.append(matched[7])
            thursday.append(matched[6])
            thursday.append(matched[7])
        case "TuF":
            tuesday.append(matched[6])
            tuesday.append(matched[7])
            friday.append(matched[6])
            friday.append(matched[7])
        case "TuThF":
            tuesday.append(matched[6])
            tuesday.append(matched[7])
            thursday.append(matched[6])
            thursday.append(matched[7])
            friday.append(matched[6])
            friday.append(matched[7])
        case "WF":
            wednesday.append(matched[6])
            wednesday.append(matched[7])
            friday.append(matched[6])
            friday.append(matched[7])
        default:
            print("There was an error in getting the days. One possible combination is not switch possibly. \(matched[5])")
        }
        buildingCode.append(matched[8])
        roomNumber.append(matched[9])
        if(matched.count > 10) {
        switch matched[10] {
        case "M":
            monday.append(matched[11])
            monday.append(matched[12])
        case "Tu":
            tuesday.append(matched[11])
            tuesday.append(matched[12])
        case "W":
            wednesday.append(matched[11])
            wednesday.append(matched[12])
        case "Th":
            thursday.append(matched[11])
            thursday.append(matched[12])
        case "F":
            friday.append(matched[11])
            friday.append(matched[12])
        case "MW":
            monday.append(matched[11])
            monday.append(matched[12])
            wednesday.append(matched[11])
            wednesday.append(matched[12])
        case "MF":
            monday.append(matched[11])
            monday.append(matched[12])
            friday.append(matched[11])
            friday.append(matched[12])
        case "MWF":
            monday.append(matched[11])
            monday.append(matched[12])
            wednesday.append(matched[11])
            wednesday.append(matched[12])
            friday.append(matched[11])
            friday.append(matched[12])
        case "TuW":
            tuesday.append(matched[11])
            tuesday.append(matched[12])
            wednesday.append(matched[11])
            wednesday.append(matched[12])
        case "TuTh":
            tuesday.append(matched[11])
            tuesday.append(matched[12])
            thursday.append(matched[11])
            thursday.append(matched[12])
        case "TuF":
            tuesday.append(matched[11])
            tuesday.append(matched[12])
            friday.append(matched[11])
            friday.append(matched[12])
        case "TuThF":
            tuesday.append(matched[11])
            tuesday.append(matched[12])
            thursday.append(matched[11])
            thursday.append(matched[12])
            friday.append(matched[11])
            friday.append(matched[12])
        case "WF":
            wednesday.append(matched[11])
            wednesday.append(matched[12])
            friday.append(matched[11])
            friday.append(matched[12])
        default:
            print("There was an error in getting the days. One possible combination is not switch possibly")
        }
        buildingCode.append(matched[13])
        roomNumber.append(matched[14])
        }
        
    }
    

    func matches(for regex: String, in text: String) -> [String] {
     do {
     let regex = try NSRegularExpression(pattern: regex, options: [])
     let nsString = text as NSString
     let results = regex.matches(in: text, range: NSMakeRange(0, nsString.length))
     var match = [String]()
     for result in results {
     for i in 0..<result.numberOfRanges {
        if(result.range(at: i).length != 0) {
            match.append(nsString.substring(with: result.range(at: i)))
        }
     }
     }
     return match
     } catch let error {
     print("invalid regex: \(error.localizedDescription)")
     return []
     }
     }
    
}
    
class Schedule {
    var scheduleArr = [[String]]()
    init() {
        scheduleArr = [[String]](repeating: [String](repeating: "", count: 180), count: 5)
    }
    
    private func convert(time: String) -> Int {
        var c = 0
        var num = 0
        var hour = 0
        var temp = ""
        
        for i in 0..<time.count {
            let index = time.index(time.startIndex, offsetBy: i)
            let index_plus = time.index(time.startIndex, offsetBy: i+1)
            if(time[index] == ":") {
                hour = Int(atoi(temp))
                num = num + (Int(atoi(temp)*12)-84)
                num = num + Int(atoi(String((time[index_plus]))))
                c = 0
                continue
            }
            if(time[index] == "p" && hour != 12){
                num=num+144;
                break;
            }
            let c_index = temp.index(temp.startIndex, offsetBy: c)
            temp.insert(time[index], at: c_index)
            c = c + 1
        }
        return num
    }
    
    private func check_space(scheduleArr: Array<String>, dayArr: Array<String>) -> Bool {
        
        for j in 0..<(dayArr.count/2) {
            
            for i in convert(time: dayArr[j*2])..<(convert(time: dayArr[(j*2)+1])+1) {
                if(scheduleArr[i] != "") {
                    return false
                }
                
            }
        }
        return true
    }
    
    private func insert_space( scheduleArr: inout Array<String>, dayArr: Array<String>, classObj: Course) {
        for j in 0..<(dayArr.count/2) {
            
            for i in convert(time: dayArr[j*2])..<(convert(time: dayArr[(j*2)+1])+1) {
                scheduleArr[i] = "\(classObj.getCourseCode()) , \(classObj.getSection())"
                
                
            }
        }
    }
    
    func print_arr() {
        for i in 0..<self.scheduleArr.count {
            switch i {
            case 0:
                print("monday")
            case 1:
                print("Tuesday")
            case 2:
                print("Wednesday")
            case 3:
                print("Thursday")
            case 4:
                print("Friday")
            default:
                print("ERROR")
            }
            for j in 0..<self.scheduleArr[i].count {
                if(self.scheduleArr[i][j] == "") {
                    
                } else {
                    print(self.scheduleArr[i][j])
                }
            }
            print("--------------------------------------------------------------------------------------")
        }
        
    }
    
    func all_good(classArr: [Course]) -> Bool {
        var counter = 0
       var temp_scheduleArr = [[String]](repeating: [String](repeating: "", count: 180), count: 5)
        for i in 0..<classArr.count {
            if(check_space(scheduleArr: temp_scheduleArr[0], dayArr: classArr[i].getMon()) &&
                check_space(scheduleArr: temp_scheduleArr[1], dayArr: classArr[i].getTues()) &&
                check_space(scheduleArr: temp_scheduleArr[2], dayArr: classArr[i].getWed()) &&
                check_space(scheduleArr: temp_scheduleArr[3], dayArr: classArr[i].getThurs()) &&
                check_space(scheduleArr: temp_scheduleArr[4], dayArr: classArr[i].getFri())) {
                counter = counter + 1
                
                insert_space(scheduleArr: &temp_scheduleArr[0], dayArr: classArr[i].getMon(), classObj: classArr[i])
                insert_space(scheduleArr: &temp_scheduleArr[1], dayArr: classArr[i].getTues(), classObj: classArr[i])
                insert_space(scheduleArr: &temp_scheduleArr[2], dayArr: classArr[i].getWed(), classObj: classArr[i])
                insert_space(scheduleArr: &temp_scheduleArr[3], dayArr: classArr[i].getThurs(), classObj: classArr[i])
                insert_space(scheduleArr: &temp_scheduleArr[4], dayArr: classArr[i].getFri(), classObj: classArr[i])
                continue
            } else {
                return false
            }
        }
        
        return true
    }
    
    func create_schedule(classArr: [Course]) -> Bool {
        var counter = 0
        for i in 0..<classArr.count {
            if(check_space(scheduleArr: self.scheduleArr[0], dayArr: classArr[i].getMon()) &&
                check_space(scheduleArr: self.scheduleArr[1], dayArr: classArr[i].getTues()) &&
                check_space(scheduleArr: self.scheduleArr[2], dayArr: classArr[i].getWed()) &&
                check_space(scheduleArr: self.scheduleArr[3], dayArr: classArr[i].getThurs()) &&
                check_space(scheduleArr: self.scheduleArr[4], dayArr: classArr[i].getFri())) {
                counter = counter + 1
                continue
            } else {
                return false
            }
        }
        
        if (counter == classArr.count) {
            for i in 0..<classArr.count {
                insert_space(scheduleArr: &self.scheduleArr[0], dayArr: classArr[i].getMon(), classObj: classArr[i])
                insert_space(scheduleArr: &self.scheduleArr[1], dayArr: classArr[i].getTues(), classObj: classArr[i])
                insert_space(scheduleArr: &self.scheduleArr[2], dayArr: classArr[i].getWed(), classObj: classArr[i])
                insert_space(scheduleArr: &self.scheduleArr[3], dayArr: classArr[i].getThurs(), classObj: classArr[i])
                insert_space(scheduleArr: &self.scheduleArr[4], dayArr: classArr[i].getFri(), classObj: classArr[i])
            }
            
        }
        return true
    }
    
}


class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var classCode: UITextField!
    var classes = [[Course]]()
    var sectionsArr = [Course]()
    var classCodes: Array<String> = Array()
    var coursesArr: Array<Course> = Array()
    var secArr: Array<String> = Array()
    var schedules = [Schedule]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    @IBAction func add() {
        // We need to check if the courses in our arr have duplicate codes, this way we don't make duplicate scheudles
        classCodes.append(classCode.text!)
        //loadURL(code: classCode.text!)
        classCode.text = nil
        //might have to check if what they added was a valid course code, or else the parser might be trying to parse an invalid code

        
    }
    
    @IBAction func createTapped() {
        /* possible error: create is tapped more than once*/
       
        for code in classCodes {
            let myURLString = "https://app.testudo.umd.edu/soc/search?courseId=\(code)&sectionId=&termId=201801&openSectionsOnly=true&_openSectionsOnly=on&creditCompare=&credits=&courseLevelFilter=ALL&instructor=&_facetoface=on&_blended=on&_online=on&courseStartCompare=&courseSartHour=&courseStartMin=&courseStartAM=&courseEndHour=&courseEndMin=&courseEndAM=&teachingCenter=ALL&_classDay1=on&_classDay2=on&_classDay3=on&_classDay4=on&_classDay5=on"
            guard let myURL = URL(string: myURLString) else {
                print("Error: \(myURLString) doesn't seem to be a valid URL")
                return
            }
            
            do {
                sectionsArr.removeAll()
                secArr.removeAll()
                let sourceCode = try String(contentsOf: myURL, encoding: .ascii)
                    secParser(sourceCode: sourceCode)
               
                for section in secArr {
                    let thisCourse = Course()
                    thisCourse.setName(code: code)
                    thisCourse.parse(sourceCode: section)
                    //coursesArr.append(thisCourse)
                    sectionsArr.append(thisCourse)
                    
                }
                
                
            } catch let error {
                print("Error: \(error)")
            }
            classes.append(sectionsArr)
            
        }
        
        schedules = comboMambo(classes: classes)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let schedVC = segue.destination as? schedulesVC else { return }
        schedVC.schedules = schedules
        
    }
    func comboMambo(classes: [[Course]]) -> [Schedule]{
        var length = [Int]()
        var counter = [Int]()
        var total = 1
        var schedArr = [Schedule]()
        var c = 0
        
        for i in 0..<classes.count {
            length.append(classes[i].count)
          
            counter.append(0)
        }
        for i in 0..<length.count {
            total = total*length[i]
        }
        
        for _ in 0..<total {
            var tempArr = [Course]()
            for j in 0..<counter.count {
                tempArr.append(classes[j][counter[j]])
            }
            let sched = Schedule()
            if(sched.all_good(classArr: tempArr)) {
                sched.create_schedule(classArr: tempArr)
                 schedArr.append(sched)
                //print("\(c)th schedule created")
                c = c + 1
            } else {
            
            }
    
            
            for index in stride(from: counter.count-1, to: 0, by: -1) {
                if ((counter[index] + 1) < length[index]) {
                    counter[index] = counter[index] + 1
                    break
                }
                counter[index] = 0
            }
        }
        print("\(c) schedules possible")
        return schedArr
        
    }

    func secParser(sourceCode: String) {
        do {
            let doc = try SwiftSoup.parse(sourceCode)
            do {
                let sections = try doc.getElementsByClass("section delivery-f2f")
                for section in sections {
                    secArr.append(try section.text())
                }
            } catch {
            
            }
        } catch {
            
        }
    }

    
}


