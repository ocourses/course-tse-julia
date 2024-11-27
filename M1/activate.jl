using Suppressor
@suppress begin
    using Pkg
    Pkg.activate(".")
#    Pkg.instantiate()
    include("../assets/julia/myshow.jl")
    using Markdown
    using QuizQuestions
end
nothing