//
//  An exercise file for iOS Development Tips Weekly
//  by Steven Lipton (C)2018, All rights reserved
//  For videos go to http://bit.ly/TipsLinkedInLearning
//  For code go to http://bit.ly/AppPieGithub
//
import UIKit

// We'll break apart a csv stream of dounut menu items
// data is An item number X0000XX(String), Description(String) and price(String).
// item number  has three parts.
//      X               0000            XX
//     /                 |               \
//  type                number          2 Toppings
//  H - HOLE            (unique)         X - none
//  F - FILLED                           C - Chocolate
//                                       G - glazed
//                                       S - Sprinkles
//

// Here's our data
var dataString = """
H0001XG,Plain,0.95
F0002XX,Lemon, 1.49
F0003CX,Boston Cream,X1.49X
F0004CS,Choco Nutella, 1.95se
H0005SX,Happy,$0.95.01
H0006SX,Strawberry Filled, $0.95-34
"""

enum DoughnutType:Int{
    case hole, filled
}

enum DoughnutTopping:String{
    case none
    case chocolate
    case glazed
    case sprinkles
}

DoughnutType.hole
DoughnutType.filled
DoughnutTopping.none
DoughnutTopping.chocolate



class MenuEntry{
    var itemNumber:String = ""
    var description:String = ""
    var price:Double = 0.00
   
    var type:DoughnutType{
        switch itemNumber.prefix(1) {
        case "H":
            return .hole
        default:
            return .hole
        }
    }
    var toppings:[DoughnutTopping]{
        var toppings = [DoughnutTopping]()
        for topping in itemNumber.suffix(2){
            switch topping {
            case "C":
                toppings += [.chocolate]
            default:
                toppings += [.none]
            }
        }
        return toppings
    }
    
    func toppingsString() -> String{
        var string = ""
        for topping in toppings{
            string += topping.rawValue
        }
        return string
    }

    init(csvRecord:String, separator:Character){
        let record = csvRecord.split(separator: separator)
        itemNumber = String(record[0])
        description = String(record[1])
        let filter = "0123456789-."
        var cleanedString = String(record[2])
        cleanedString.removeAll(where:{!filter.contains($0)})
        var dashes = cleanedString.suffix(cleanedString.count - 1)
        dashes.removeAll(where:{"-" == $0})
        cleanedString = String(cleanedString.prefix(1) + dashes)
        
        if let price = Double(cleanedString){
            self.price = price
        } else {
            self.price = 0
        }
    }
    
}

var menu = [MenuEntry]()
dataString.enumerateLines { (line, stop) in
    menu.append(MenuEntry(csvRecord: line, separator: ","))
}


for menuEntry in menu{
    var displayString = menuEntry.description
    if menuEntry.itemNumber.hasPrefix("F"){
        displayString += " filled"
    }
    displayString += " doughnut"
    if menuEntry.itemNumber.suffix(2).firstIndex(of: "S") != nil {
        displayString += " with sprinkles"
    }
    displayString += "\t \(menuEntry.price)"
    print(displayString)
}



