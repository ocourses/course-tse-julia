function myshow_f(ex::Expr)::Expr
    # Recursively apply myshow to subexpressions
    if ex.head == :block
        for i in 1:length(ex.args)
            if ex.args[i] isa Expr
                ex.args[i] = myshow_f(ex.args[i])
            end
        end
    end

    # If the expression is a block, return it as is
    if ex.head == :block
        return ex

    # If it's an assignment, show the left-hand side value after the assignment
    elseif ex.head == :(=)
        return quote
            $ex       # Perform the assignment
            @show $(ex.args[1])  # Show the left-hand side (variable)
            nothing   # Return nothing for assignment (no value)
        end
    else
        # For non-assignment expressions, show the expression and its evaluated result
        return quote
            $ex  # Evaluate the expression and store the result
            @show $ex  # Show the expression and its result
        end
    end
end

# Define the macro
macro myshow(ex)
    return myshow_f(ex)  # Ensure expression is evaluated in the correct context
end

# Test the macro
@myshow begin
    d = 1
    d + 2
    d + 3
    f = 2
    f * 10
end;

@myshow begin
    d = 100
    d + 2
    d + 3
    f = 2
    f * 10
end;

dump(quote
    a = 3.14
    typeof(a)
    isconcretetype(typeof(a))
end)

myshow_f(quote
    a = 3.14
    typeof(a)
    isconcretetype(typeof(a))
end)

@myshow begin
    a = 3.14
    typeof(a)
    isconcretetype(typeof(a))
end;