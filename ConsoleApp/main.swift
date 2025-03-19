//
//  main.swift
//  ConsoleApp
//
//  Created by Damian Jardim on 2/18/25.
//

import Foundation





func ex6(){
    
    let animals = ["Cat", "Dog", "Bird", "Goat", "Fish"]
    print("Enter animal name:")
    if let name = readLine() {
        let result = animals.contains(name) ? "Yes, it's in the list!" : "No, it's not here!"
        print(result)
    }
}
//ex6()


func ex7(){
    
    struct Product {
        var id:Int
        var name:String
        var isFavorite:Bool
        var price:Decimal
    }
    
    let productArray:[Product] = [
        Product(id: 1, name: "Cooler", isFavorite: true, price: 32.99),
        Product(id: 2, name: "Poncho", isFavorite: false, price: 0.99),
        Product(id: 3, name: "Sleeping Bag", isFavorite: true, price: 50.09),
        Product(id: 4, name: "Tent", isFavorite: false, price: 119.99)
    ]
    
    let result = productArray.filter{$0.isFavorite == true}
    
    for myProduct in result {
        print("myProduct: \(myProduct.name) - id: \(myProduct.id)")
    }
    
    print("*********")
    
    let result2 = productArray.filter{ myProduct in
        // return myProduct.isFavorite
        myProduct.isFavorite
    }
    
    for myProduct in result2 {
        print("myProduct: \(myProduct.name) - id: \(myProduct.id)")
    }
    
    
}
//ex7()


func ex8(){
    
    var stickerSet:Set<String> = ["Sticker1", "Sticker2", "Sticker3"]
    
    func displayAddOption(){
        print("\nAdd name: ", terminator: "")
        if let response = readLine(){
            if(!stickerSet.contains(response)){
                stickerSet.insert(response)
                print("\(response) added")
            } else {
                print("\(response) already exists")
            }
        }else{
            print("Add - Invalid user input")
        }
        
    }
    
    func displayRemoveOption(){
        print("\nRemove name: ", terminator: "")
        if let response = readLine(){
            if let removedElement = stickerSet.remove(response){
                print("\(removedElement) has been removed")
            }
        }else{
            print("Remove - Invalid user input")
        }
    }
    
    func printSetLoop(){
        print("\nLooping")
        for sticker in stickerSet.sorted(){
            print("sticker: \(sticker)")
        }
    }
    
    func printOptions(){
        var quit = false
        while !quit{
            print("\ncontents: \(stickerSet.sorted())\n")
            print("Press '1' to add")
            print("Press '2' to remove")
            print("Press '3' to loop through the set and print each sticker")
            print("Press any other key to quit")
            print("Input: ", terminator:"")
            
            if let response = readLine(){
                switch response{
                    case "1":
                        displayAddOption()
                    case "2":
                        displayRemoveOption()
                    case "3":
                        printSetLoop()
                    default:
                        quit = true
                        print("Exiting...")
                }
            }else{
                print("Invalid entry")
            }
        }
    }
    
    // begins execution
    printOptions()
}
//ex8()



func ex9(){
    
    /*
     
     1. when flourAvailable is false the bakesCookies func will throw BakingError.noFlour - "Oops! No flour.  Can't bake cookies" will print
     2. prints
     "cookies are baking"
     "Yay, we have cookies!"
     3. code changed below
     
     ----------------------
     
     What if the oven is broken and there's no flour?
     - the .noFlour catch block runs printing "Oops! No flour.  Can't bake cookies!" - B
     Should it check the oven first?
     - it could, but I would look at the bakeCookies func to make that decision.  If flourAvailable is checked first, I would place 'noFlour' catch first as well.
     How might this impact debugging?
     - We can reduce the amount checks on the catch blocks if the most likely throw occurs first.
     
     (flourAvailable: false, ovenBroken: true)
     Oops! No flour.  Can't bake cookies!
     
     (flourAvailable: true, ovenBroken: true)
     Grrrr. The oven is broken!
     
     (flourAvailable: false, ovenBroken: true)
     Oops! No flour.  Can't bake cookies!
     
     -----------------------------------------------
     
     💡 New Idea: What if we check both conditions before throwing so we can report both issues at once?
     Try modifying bakeCookies so it collects multiple errors instead of stopping at the first one.
     Hint: Use an array of errors and throw them together. Something like:
     var errors: [BakingError] = []
     Then, throw all errors if any exist after checking both conditions.
     
     ------------------------------------------------
     
     
     What happens if flourAvailable = true and ovenBroken = true?
     
     the errors array created in bakeCookies will be thrown with an Errors enum.
     the catch block for Errors.multiple will be run printing 1 ovenBroken error -
     "Error: ovenBroken"
     
     
     Try printing error.localizedDescription inside the for loop. What do you see?
     
     Error: The operation couldn’t be completed. (ConsoleApp.(unknown context at $100007d40).(unknown context at $100007d4c).BakingError error 1.)
     
     
     Can you modify BakingError to include custom error messages when printing them?
     i can give the enum BakingError a string
     - what is this technique called
     
     issues i've noticed
     1.   issue with apostrpophe when printing the error.  It will print as : Can\'t
     - swift issue - ignored
     2.  how can i access the .message directly from the for loop
     currently this prints:
     Error: ovenBroken(message: "Grrr. The oven is broken!")
     - fixed using computed property
     
     ----------------------------------------------------------
     
     Try adding a third error case (e.g., case powerOutage(message: String)).
     Update bakeCookies to throw this error when powerAvailable = false.
     Modify the do-catch block to handle this new error.
     
     -----------------------------------------------------------
     
     What if you wanted to recover from errors instead of just printing them?
     For example, if flour is missing, you might buy more flour instead of failing.
     Modify bakeCookies to handle some errors and retry baking if possible!
     
     */
    
    enum BakingError: Error{
        case noFlour(message:String)
        case ovenBroken(message:String)
        case powerOutage(message:String)
        
        // computed property within an enum
        var message: String{
            switch self{
                case .noFlour(let msg): return msg
                case .ovenBroken(let msg): return msg
                case .powerOutage(let msg): return msg
            }
        }
        
        var tryFix: Bool{
            switch self{
                case .noFlour(_): return true
                case .ovenBroken(_): return false
                case .powerOutage(_): return false
            }
        }
        
        
        
        
        // swift only allows throwing objects conforming to 'Error'
        enum Errors: Error{
            case multiple([BakingError])
            
        }
        
        
        func bakeCookies(flourAvailable: Bool, ovenBroken: Bool, powerAvailable: Bool) throws {
            var errors:[BakingError] = []
            
            if(!flourAvailable){
                errors.append(BakingError.noFlour(message:"Oops! No flour. Can't bake cookies!"))
            }
            
            if(ovenBroken){
                errors.append(BakingError.ovenBroken(message:"Grrr. The oven is broken!"))
            }
            
            if(!powerAvailable){
                errors.append(BakingError.powerOutage(message: "I feel powerless"))
            }
            
            if(!errors.isEmpty){
                throw Errors.multiple(errors)
            }
            print("Cookies are baking")
            
            
            do{
                try bakeCookies(flourAvailable: flourAvailable, ovenBroken: ovenBroken, powerAvailable: powerAvailable)
                print("Yay, we have cookies!")
            }catch Errors.multiple(let errorList){
                
                
                //
                for error in errorList{
                    print("Error: \(error.message)")
                    
                    
                }
                
            }catch{
                print("An unknown error occured.")
            }
        }
    }
}
//    ex9()
    
    func ex10(){
        /*
         async await
         
         Print "Preheating oven..." before waiting.
         Print "Enjoy your cookies!" after they are ready.
         Give it a shot and tell me what happens!
         
         ~~~~~
         
         preheating oven and mixing ingredients display at same time
         waits for 2 seconds
         prints cookies are read and enjoy your cookies at the same time
         
         -----------------
         Add a cooling time before eating the cookies! 😆
         Simulate a burnt batch if baking takes too long.

         -----------------------
         
         */
        
        
        
        func bakeCookies() async {

            let randomBakingDuration = UInt64.random(in: 0...5_000_000_000)
            print("randomBakingDuration: \(randomBakingDuration)")

            
            print("Preheating oven... 🔥")
            
            try? await Task.sleep(nanoseconds: 1_500_000_000) // Simulate oven preheating
            
            print("Oven is ready! Now mixing ingredients... 🍪")
            
            try? await Task.sleep(nanoseconds: randomBakingDuration) // Simulate baking time
            
            var isBurnt:Bool{
                get{
                    return randomBakingDuration >= 3_000_000_000
                }
            }
            // burnt cookies
            var bakingResult:String
            
            switch randomBakingDuration{
                case 0..<2_000_000_000:
                    bakingResult = "undercooked"
                case 2_000_000_000 ..< 3_000_000_000:
                    bakingResult = "perfectly baked"
                default:
                    bakingResult = "burnt"
            }
            
            print("Cookies are ready! 🎉")
            
            // add cooling time
            print("Cooling cookies")
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            print("Enjoy your \(bakingResult) cookies! 🍪")
        }
        
        Task {
            await bakeCookies()
        }

        
    }
//    ex10()

func ex11(){
    
    protocol Superhero {
        var name:String {get}
        func attack() -> String
    }
    
    //struct SpiderMan: Superhero{
    //    var name:String = "SpiderMan"
    //    func attach()->String{
    //        return "abc"
    //    }
    //}
    
    struct SpiderMan: Superhero{
        var name: String = "SpiderMan"
        
        func attack() -> String {
            return "help"
        }
        
        
    }
    
    protocol Villain{
        var name:String{get}
        func evilLaugh()->String
    }
    
    struct GreenGoblin: Villain{
        
        var name:String
        
        init(){
            self.name = ""
        }
        
        init(name:String){
            self.name = name
        }
        
        init(_ name:String){
            self.name = name
        }
        
        func evilLaugh() -> String {
            return "ha ha ha haaaaaaaaa"
        }
    }
    
    let newInstance = GreenGoblin()
    print(newInstance)
    
}
//ex11()

func ex12(){
    
}
//ex12()

func ex13(){

//    let weapon = (name: "Longbow", damage: 40, isOneHanded: false)
//    print("The \(weapon.name) does \(weapon.damage) damage and \(weapon.isOneHanded ? "is" : "is not") one-handed.")


    /*
     1. yes is not a Bool
     2. the axe.isEnchanted expects a Boolean
     */
    let axe = (name: "Battle Axe", damage: 55, isEnchanted: true)
    if axe.isEnchanted {
        print("The \(axe.name) glows with magical energy!")
    }

}
//ex13()

func ex14(){
    
    enum HeroPower: CaseIterable{
        case strength
        case speed
        case invisibility
    }
    
    let myHeroPower = HeroPower.strength
    
    print("myHeroPower: \(myHeroPower)")
    
    // need exercises on using map and joined and other commonly used array methods
    // exercises on arrays - adding, removing, updating, finding, filtering, searching,
    // iterating, and other commonly used operations and methods on arrays
    let powers = HeroPower.allCases
        .map({ "\($0)" })
        .joined(separator: ", ")
    
    print(powers)
}
//ex14()

func ex15(){
    
    enum HeroPower: CaseIterable{
        case strength
        case speed
        case invisibility
    }
    
    let myHeroPower = HeroPower.strength
    
    print("myHeroPower: \(myHeroPower)")
}
//ex15()

func ex16(){
    // added raw values
    enum HeroPower: String, CaseIterable{
        case strength = "Strength 💪"
        case speed = "Speed ⚡"
        case invisibility = "Invisibility 👻"
    }
    
    if let myRandomHeroPower = HeroPower.allCases.randomElement(){
        print("Your hero's power is: \(myRandomHeroPower.rawValue)")
    }
}

//for _ in 1...10 {
//    ex16()
//}


func ex17(){
    enum HeroPower: String, CaseIterable{

        case complaining = "Complaining"
        case bingeEating = "Binge Eating"
        case watchingTV = "Watching TV"
    }
    
    var heroPowers:[HeroPower] = HeroPower.allCases.shuffled()
    let heroNames = ["Superman", "Batman", "The Flash", "Deadpool"]
    
    for heroName in heroNames{
        
        if(heroPowers.isEmpty){
            heroPowers = HeroPower.allCases.shuffled()
        }
        
        print(
            "\(heroName) has the power of \(heroPowers.removeFirst().rawValue)"
        )
    }
    
}
//
//for num in 1...10 {
//    print("------------ \(num) ------------")
//    ex17()
//}


func ex18() {
    enum HeroPower: String, CaseIterable {
        case complaining = "Complaining 🗣️"
        case bingeEating = "Binge Eating 🍕"
        case watchingTV = "Watching TV 📺"
    }
    
    var heroPowers = HeroPower.allCases.shuffled()
    let heroNames = ["Superman", "Batman", "The Flash", "Deadpool"]
    
    for heroName in heroNames {
        if heroPowers.isEmpty {
            heroPowers = HeroPower.allCases.shuffled()
        }
        
        let power = heroPowers.removeFirst()
        print("\(heroName) has the power of \(power.rawValue)! What a hero! ⭐")
    }
}

//for num in 1...10 {
//    print("------------ Round \(num) ------------")
//    ex18()
//}

// no more enums

func ex19() {
    
//    @property
    struct PizzaOrder: Codable {
        var size: String
        var toppings: [String]
        var quantity: Int {1}
    }
    
    let order = PizzaOrder(size: "medium", toppings: ["mushrooms", "olives"])
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    
    if let jsonData = try? encoder.encode(order),
       let jsonString = String(data: jsonData, encoding: .utf8) {
        print("Encoded JSON:", jsonString)
    }
    
    let jsonString = """
{
    "size": "medium",
    "toppings": ["mushrooms", "olives"],
    "quantity": 2
}
"""
    
    
    let jsonData = jsonString.data(using: .utf8)!
    let decoder = JSONDecoder()
    
    do {
        let decodedOrder = try decoder.decode(PizzaOrder.self, from: jsonData)
        print("Decoded Order:", decodedOrder)
    } catch {
        print("Decoding failed:", error.localizedDescription)
    }

}

//ex19()

// lets go simple
// create a grid
// all the user toggle the grid to turn in on or off
// save this information to users defaults
// save and load from json
import SwiftUI


//func ex20(){
//    
//    // start simple with just 1 cell
//    // TODO: add array of values
//    let jsonString = """
//    {
//        "x":0,
//        "y":0,
//        "name": "origin"
//    }
//    """
//    
//    struct Coordinate: Codable{
//        var x:Int
//        var y:Int
//        var name:String
//        
//        enum CodingKeys: String, CodingKey{
//            case name = "title"
//            case foundingYear = "founding_date"
//            
//            case location
//            case vantagePoints
//        }
//    }
//    
//    struct Cell : Codable{
//        var coordinate:Coordinate
//        
//        // what should be displayed in the cell
//        var isOn:Bool
//        var colorCode:Int
//    }
//    
//    
//    
//}
import Foundation


// single record from json

/*
 Right now, if the JSON misses a key, decoding fails.
 Modify the PizzaOrder struct to give quantity a default value of 1 so that decoding still works even if "quantity" is missing.
 
 Now that we've handled missing keys, what if the JSON has an invalid type (e.g., "quantity": "two" instead of 2)?
 👉 Modify the code to catch type mismatches and provide a better error message!
 
 */
func decodeExample(){
    
    struct BlogPost: Codable{
        
        var id:Int
        var title:String
        var url:String
        var views:Int
        
        //
        init(from decoder: Decoder) throws{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decode(Int.self, forKey:.id)
            title = try container.decode(String.self, forKey:.title)
            url = try container.decode(String.self, forKey:.url)
            views = try container.decodeIfPresent(Int.self, forKey:.views) ?? 1 // Default value if views is missing
            
        }
        
        // adding the init above method - we need to write out  new initializer
        init(id:Int, title:String, url:String, views:Int){
            self.id = id
            self.title = title
            self.url = url
            self.views = views
        }
    }
    
    let JSON = """
        {
            "id": 1
            "title": "https://www.avanderlee.com/swift/optionals-in-swift-explained-5-things-you-should-know/"
            "url": "swift",
            "views": 100
        }
        """
    
    let jsonData = JSON.data(using: .utf8)!
    let decoder = JSONDecoder()

    do{
        let blogPostDecoded = try decoder.decode(BlogPost.self, from: jsonData)
        print("Decoding Suceeded:", blogPostDecoded)
    }catch{
        print("Decoding Failed: ", error.localizedDescription)
    }
}
//print("begin")
//decodeExample()
//print("end")

/*
 Now that we've handled missing keys, what if the JSON has an invalid type (e.g., "quantity": "two" instead of 2)?
👉 Modify the code to catch type mismatches and provide a better error message!
 */

func decodeExample2(){
    
    struct BlogPost: Codable{
        
        var id:Int
        var title:String
        var url:String
        var views:Int
        
        //
        init(from decoder: Decoder) throws{
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decode(Int.self, forKey:.id)
            title = try container.decode(String.self, forKey:.title)
            url = try container.decode(String.self, forKey:.url)
            views = try container.decodeIfPresent(Int.self, forKey:.views) ?? 1 // Default value if views is missing
        }
        
        // adding the init above method - we need to write out  new initializer
        init(id:Int, title:String, url:String, views:Int){
            self.id = id
            self.title = title
            self.url = url
            self.views = views
        }
    }
    
    let JSON = """
        {
            "id": 1
            "title": "https://www.avanderlee.com/swift/optionals-in-swift-explained-5-things-you-should-know/"
            "url": "swift",
            "views": 100
        }
        """
    
    let jsonData = JSON.data(using: .utf8)!
    let decoder = JSONDecoder()
    
    do{
        let blogPostDecoded = try decoder.decode(BlogPost.self, from: jsonData)
        print("Decoding Suceeded:", blogPostDecoded)
    }catch{
        print("Decoding Failed: ", error.localizedDescription)
    }
}
//decodeExample2()


func decodeExample3() {
    
    struct PizzaOrder: Codable {
        var size: String
        var toppings: [String]
        var quantity: Int
        
        // 👇 Custom Decoder to Provide a Default Value
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            size = try container.decode(String.self, forKey: .size)
            toppings = try container.decode([String].self, forKey: .toppings)
            quantity = try container.decodeIfPresent(Int.self, forKey: .quantity) ?? 1  // Default value 1 if missing
        }
        
        // 👇 This is needed for encoding to work
        init(size: String, toppings: [String], quantity: Int = 1) {
            self.size = size
            self.toppings = toppings
            self.quantity = quantity
        }
    }
    
    let jsonString = """
{
    "size": "medium",
    "toppings": ["mushrooms", "olives"]
}
""" // 👈 Missing "quantity" key!
    
    let jsonData = jsonString.data(using: .utf8)!
    let decoder = JSONDecoder()
    
    do {
        let decodedOrder = try decoder.decode(PizzaOrder.self, from: jsonData)
        print("Decoded Order:", decodedOrder)
    } catch {
        print("Decoding failed:", error.localizedDescription)
    }
}



// having trouble dealing with different use cases when decoding objects
// missing fields
// renaming fields
// type conversion errors

func ex21(){
 
    struct Person: Codable {
        let name: String
        let age: Int
        let hobbies: [String]
    }
    
    let jsonString =
    """
    {
        "name": "Alice",
        "age": 25,
        "hobbies": ["reading", "gaming", "cooking"]
    }
    """
    
    if let jsonData = jsonString.data(using: .utf8){
        let decoder = JSONDecoder()
        
        do {
            let person = try decoder.decode(Person.self, from:jsonData)
            print("Decoded Person:", person)
            
        } catch {
            print("Decoding failed: ", error.localizedDescription)
        }
    } // if let
    
}
//ex21()

func ex22(){
    
    /*
     map differences using CodingKeys
     */
    struct Animal: Codable {
        let species: String
        let legs: Int
        
        enum CodingKeys: String, CodingKey {
            case species
            case legs = "limbs"
        }
    }
    
    let jsonString = """
    {
        "species": "Dog",
        "limbs": 4
    }
    """
    // "legs": 4
    
    
    if let jsonData = jsonString.data(using: .utf8) {
        let decoder = JSONDecoder()
        
        do {
            let animal = try decoder.decode(Animal.self, from: jsonData)
            print("Decoded Animal:", animal)
        } catch {
            print("Decoding failed:", error.localizedDescription)
        }
    }

}
//ex22()

func ex23(){
    struct Car: Codable {
        let brand: String
        let modelName: String
        
        enum CodingKeys: String, CodingKey {
            case brand
            case modelName = "model"
        }
    }
    
    let jsonString = """
{
    "brand": "Tesla",
    "model": "Model 3"
}
"""
    
    if let jsonData = jsonString.data(using: .utf8) {
        let decoder = JSONDecoder()
        
        do {
            let car = try decoder.decode(Car.self, from: jsonData)
            print("Decoded Car:", car)
        } catch {
            print("Decoding failed:", error.localizedDescription)
        }
    }
}
//ex23()


func ex24(){
    struct Book: Codable {
        let title: String
        let author: String
        let pages: Int
        
        enum CodingKeys: String, CodingKey {
            case title
            case author = "writer"
            case pages = "pageCount"
        }
    }
    
    let jsonString = """
{
    "title": "Swift for Beginners",
    "writer": "John Doe",
    "pageCount": 300
}
"""
    
    if let jsonData = jsonString.data(using: .utf8) {
        let decoder = JSONDecoder()
        
        do {
            let book = try decoder.decode(Book.self, from: jsonData)
            print("Decoded Book:", book)
        } catch {
            print("Decoding failed:", error.localizedDescription)
        }
    }
}
//ex24()

func ex25(){
    struct Event: Codable {
        let name: String
        let date: Date
    }
    
    let jsonString = """
    {
        "name": "Swift Conference",
        "date": "2024-03-14"
    }
    """
    
    if let jsonData = jsonString.data(using: .utf8) {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let event = try decoder.decode(Event.self, from: jsonData)
            print("Decoded Event:", event)
        } catch {
            print("Decoding failed:", error.localizedDescription)
        }
    }
}
ex25()
RunLoop.main.run()

/*
 
T
Explain when tuples are a good choice.
Explain when a struct would be better.

*/
