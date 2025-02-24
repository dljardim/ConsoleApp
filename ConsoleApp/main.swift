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

/// improvements made into a terminal app
/// TODO: prompt for input on the same line as the print cmd
/// additions:
/// - It checks if a sticker is already in the set before adding it.

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

     */
    
    enum BakingError: Error{
        case noFlour
        case ovenBroken
    }
    
    func bakeCookies(flourAvailable: Bool, ovenBroken: Bool) throws {
        if(!flourAvailable){
            throw BakingError.noFlour
        }
        
        if(ovenBroken){
            throw BakingError.ovenBroken
        }
        
        print("Cookies are baking")
    }
    
    do{
        try bakeCookies(flourAvailable: true, ovenBroken: true)
        print("Yay, we have cookies!")
    }catch BakingError.noFlour{
        print("Oops! No flour.  Can't bake cookies!")
    }catch BakingError.ovenBroken{
        print("Grrrr. The oven is broken!")
    }catch{
        print("No cookies today :(")
    }
    
}
ex9()

