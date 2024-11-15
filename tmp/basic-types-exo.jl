# Exercise 1

#1
struct Point
    x::Float64
    y::Float64
end

#2
struct Rectangle
    length::Float64
    width::Float64
    blanchor::Point
end

#3
struct Circle
    radius::Float64
    center::Point
end

#
function area(rect::Rectangle)
    return rect.length*rect.width
end

function area(circle::Circle)
    return π*(circle.radius)^2
end

# Example usage
p1 = Point(0.0, 0.0)
r1 = Rectangle(3.0, 4.0, p1)
c1 = Circle(1.0/√(π), p1)

println("Area of rectangle: ", area(r1))  # Should print 12.0
println("Area of circle: ", area(c1))     # Should print 78.53981633974483

# Exercise 2

z1 = 1.0+2.0im
z2 = 1.0im

add_complex(z1::ComplexF64, z2::ComplexF64) = z1 + z2

N = 10
arr = randn(N) + im * randn(N)

map(e -> e + 2.0 + 0.0im, arr)

function max_real_part(arr::Vector{ComplexF64})
    # we assume length(array) > 0
    z_sol = arr[1]
    for z ∈ arr
        # if real(z) > real(z_sol) 
        #     z_sol = z
        # end
        z_sol = real(z) > real(z_sol) ? z : z_sol
    end
    return z_sol
end

arr 

max_real_part(arr)

# Exercise 3

arr = [i for i ∈ 1:10]

typeof(arr)

arr .= arr .* 2

t = ("coucou", 12, -2.0)

typeof(t)

try
    t[1] = "babaille"
catch error 
    println(error)
    println("type of error: ", typeof(error))
end

nt = (name="Olivier", age=38, height=1.70)

typeof(nt)