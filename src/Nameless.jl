module Nameless

function __init__()
    print("""
        메뉴얼을 참고하여 경로를 다음의 함수를 실행해 주세요
        setup!("내경로")
    """)
end

function setup!(repo)
    if !isdir(repo) 
        throw(AssertionError("\"$repo\" 경로가 올바르지 않습니다\n올바른 경로를 입력해 주세요"))
    else
        p2 = joinpath(repo, "submodules")
        @assert isdir(p2) "\"$repo\" 경로가 우리 경로가 아닙니다\n정확한 저장소 경로를 확인해 주세요"
    end
            
    startup = joinpath(DEPOT_PATH[1], "config/startup.jl")
    write(startup, """
    push!(LOAD_PATH, $p2)""")

    @info "startup.jl을 생성하였습니다"
        

    juno_startup = joinpath(DEPOT_PATH[1], "config/juno_startup.jl")
    write(juno_startup, """using GameDataManager""")

    @info "juno_startup.jl을 생성하였습니다"
end

export setup!

end # module
