import Foundation


//BattleShip - determine if a point is ok to fire on given some constraints

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func minus(p:Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    var length: Double {
        return sqrt( x * x + y * y)
    }
}


typealias Distance = Double
typealias Region = Position -> Bool //crucial design decision - this type guided the rest of development process

    //I'm thinking, why can't we call this function type IsInRegion? Isn't that more clear given we're returning a bool, not an "area"? Authors point out that naming conventions like this denote a function type, whereas we should instead think of functions as a value, like structs, ints, booleans etc, and thus follow a similar naming convention

    //could also have used a struct called Region with property, let lookup: Position -> Bool

func circle(radius:Distance) -> Region{
    return {point in point.length <= radius}
}

func shift(region: Region, offset: Position) -> Region {
    return { point in region(point.minus(offset)) }
}


func invert(region: Region) -> Region {
    return { point in !region(point) }
}


func intersection(region1: Region, region2: Region) -> Region {
    return { point in region1(point) && region2(point) }
}

func union(region1: Region, region2: Region) -> Region {
    return { point in region1(point) || region2(point) }
}

func difference(region: Region, minus: Region) -> Region {
    return intersection(region, region2: invert(minus))
    //imagine having a region called minus, finding every point outside of it, then finding the intersection of that outside are with input "region"
}

//these are examples of "higher order functions", they either take a function(s) as an argument(s) and/or they return a function 


