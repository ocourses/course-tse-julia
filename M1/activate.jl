using Suppressor
@suppress begin
    using Pkg
    Pkg.activate(".")
    include("../assets/julia/myshow.jl")
    using Markdown
    using QuizQuestions
end
nothing