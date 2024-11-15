# Define abstract type
abstract type Shape end

shape = Shape()

# Define concrete subtypes
struct Circle <: Shape
    radius::Float64
end

struct Rectangle <: Shape
    width::Float64
    height::Float64
end

struct Triangle <: Shape
end

# Create instances
circle = Circle(5.0)
rectangle = Rectangle(3.0, 4.0)

# Check if they are subtypes of Shape
circle isa Shape
rectangle isa Shape

area(circle::Circle) = π * circle.radius
area(rect::Rectangle) = rect.height * rect.width

area(shape::Shape) = error("Not possible to compute the area!")

area(circle)
area(rectangle)

tri = Triangle()
area(tri)