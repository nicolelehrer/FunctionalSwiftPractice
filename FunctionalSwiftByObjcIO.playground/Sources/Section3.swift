import UIKit

//wrapping core image - which uses a lot of key value coding that can be error prone, here we'll try to wrap that stuff up

typealias Filter = CIImage -> CIImage //our base type to design around

func blur (radius: Double) -> Filter {
    return { image in
        let parameters = [kCIInputRadiusKey: radius, kCIInputImageKey: image]
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else {fatalError()}
        guard let outputImage = filter.outputImage else { fatalError()}
        return outputImage
    }
}

//how do you get to the output you want, the filtered image?

/*
guard let image = UIImage(named:"cactus.JPG"), let myCIImage = CIImage(image: image) else { fatalError() }

let outputImage = blur(20)(myCIImage)
*/

//uncomment and paste all of the code above in the main file, mouse over the gutter where it shows the image dimensions, press on the eye icon, and the filtered image is visible