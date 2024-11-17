function myshow_f(ex::Union{Expr, Symbol}; functions=Symbol[], debug)::Tuple{Expr, Vector{Symbol}}

    #
    debug && println("myshow_f: ex = ", ex)
    debug && println("myshow_f: functions = ", functions)

    # Recursively apply myshow to subexpressions
    if ex isa Expr && ex.head == :block
        for i in 1:length(ex.args)
            if ex.args[i] isa Expr || ex.args[i] isa Symbol
                ex.args[i], functions = myshow_f(ex.args[i], functions=functions, debug=debug)
            end
        end
    end

    # If the expression is a block, return it as is
    if ex isa Expr && ex.head == :block
        return ex, functions

    # If it's an assignment, show the left-hand side value after the assignment
    elseif ex isa Expr && ex.head == :(=)
        if (
            length(ex.args)==2 && 
            ex.args[1] isa Expr &&
            ex.args[1].head == :call
        )
            push!(functions, ex.args[1].args[1])
            line = string(Base.remove_linenums!(ex))
            return quote
                $debug && println("Inlined function definition")
                println("julia> ", $line)
                esc($ex)
                nothing
            end, functions
        elseif ( # assignment calling a custom function
            length(ex.args)==2 && 
            ex.args[2] isa Expr &&
            ex.args[2].head == :call && 
            ex.args[2].args[1] in functions
        )
            line = string(Base.remove_linenums!(ex))
            return esc(quote
                $debug && println("Assignment calling a function")
                println("julia> ", $line)
                $ex
                nothing
            end), functions
        else
            line = string(Base.remove_linenums!(ex))
            return esc(quote
                $debug && println("Assignment")
                $(ex.args[1]) = try 
                    $(ex.args[2])  # Assign the right-hand side value to the left-hand side
                catch e 
                    $debug && println("Error in assignment")
                    print("julia> ", $line)
                    rethrow(e)
                end
                print("julia> "); @show $(ex.args[1])  # Show the left-hand side (variable)
                nothing   # Return nothing for assignment (no value)
            end), functions
        end

    elseif ex isa Expr && ex.head == :function
        push!(functions, ex.args[1].args[1])
        line = string(Base.remove_linenums!(ex))
        return esc(quote 
            $debug && println("Function definition")
            println("julia> ", $line)
            $ex
            nothing
        end), functions

    else
        # For non-assignment expressions, show the expression and its evaluated result
        line = string(Base.remove_linenums!(ex))
        return esc(quote
            try 
                $debug && println("Expression")
                #$ex # Evaluate the expression: throws an error if it's not a valid expression
                print("julia> ")
                @show $ex  # Show the expression and its result
            catch e
                $debug && println("Error in expression")
                print($line)
                rethrow(e)
            end
        end), functions

    end
end

# Define the macro
macro myshow(ex, debug=false)
    return Expr(:block, myshow_f(ex; debug=debug)[1], :(nothing))
end
