struct MyPair{T, S}
    first::T
    second::S
end

pair1 = MyPair(1, "apple")  # Pair of Int and String
pair2 = MyPair(3.14, true)  # Pair of Float64 and Bool

@show pair1
@show pair2

isconcretetype(MyPair)

p = MyPair{Int64, String}(3, "a")

isconcretetype(MyPair{Int64, String})

abstract type MyAbstractPair end

struct MyConcretePair <: MyAbstractPair end

struct MyOtherConcretePair <: MyPair end