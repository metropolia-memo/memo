func z3(x: Int?) -> Int {
    if let z = x {
        return 2 * z
    }
    return 666
}

z3(x: 5)

let z = [(3,2), (1,2), (2,4), (0,3)]


let z1 = z.filter { $0.0 > 0 && $0.1 > 0}
let z2 = z1.map { $0.0 + $0.1 }
let z3 = z2.reduce(10) { acc, e in acc + e }
print(z1)
print(z2)
print(z3)

