@testset "Ranges" begin
    @testset "UnitRange" begin
        for T in (halfinttypes..., halfuinttypes..., :BigHalfInt)
            @eval @test $T(1/2):$T(5) isa UnitRange{$T}
            @eval @test $T(1/2):big(5) isa UnitRange{BigHalfInt}
            @eval @test first($T(1/2):$T(5)) == $T(1/2)
            @eval @test last($T(1/2):$T(5)) == $T(9/2)
            @eval @test length($T(1/2):$T(5)) == 5
            @eval @test length($T(1/2):$T(0)) == 0
            @eval @test length($T(1/2):$T(1/2)) == 1
            @eval @test length($T(1/2):$T(1)) == 1
            @eval @test $T(5/2) ∉ $T(1):$T(5)
            @eval @test $T(5/2) ∈ $T(1/2):$T(5)
            @eval @test $T(2) ∈ $T(1):$T(5)
            @eval @test $T(2) ∉ $T(1/2):$T(5)
            @eval @test 2.5 ∉ $T(1):$T(5)
            @eval @test 2.5 ∈ $T(1/2):$T(5)
            @eval @test 5//2 ∉ $T(1):$T(5)
            @eval @test 5//2 ∈ $T(1/2):$T(5)
            @eval @test 2 ∈ $T(1):$T(5)
            @eval @test 2 ∉ $T(1/2):$T(5)

            @eval @test any(isinteger, $T(1):$T(5))
            @eval @test !any(isinteger, $T(1):$T(0))
            @eval @test !any(isinteger, $T(1/2):$T(5))
            @eval @test !any(isinteger, $T(3/2):$T(0))
            @eval @test !any(!isinteger, $T(1):$T(5))
            @eval @test !any(!isinteger, $T(1):$T(0))
            @eval @test any(!isinteger, $T(1/2):$T(5))
            @eval @test !any(!isinteger, $T(3/2):$T(0))

            @eval @test all(isinteger, $T(1):$T(5))
            @eval @test all(isinteger, $T(1):$T(0))
            @eval @test !all(isinteger, $T(1/2):$T(5))
            @eval @test all(isinteger, $T(3/2):$T(0))
            @eval @test !all(!isinteger, $T(1):$T(5))
            @eval @test all(!isinteger, $T(1):$T(0))
            @eval @test all(!isinteger, $T(1/2):$T(5))
            @eval @test all(!isinteger, $T(3/2):$T(0))
        end
        for T in (halfinttypes..., :BigHalfInt)
            @eval @test first($T(-1/2):$T(1)) == $T(-1/2)
            @eval @test last($T(-1/2):$T(1)) == $T(1/2)
            @eval @test length($T(-1/2):$T(1)) == 2
        end
    end

    @testset "StepRange" begin
        for T in (halfinttypes..., halfuinttypes..., :BigHalfInt)
            @eval @test $T(2):$T(1/2):$T(5) isa StepRange{$T}
            @eval @test $T(2):$T(2):$T(9/2) isa StepRange{$T}
            @eval @test $T(2):big(2):$T(9/2) isa StepRange{BigHalfInt}
            @eval @test big(2):2:$T(9/2) isa StepRange{BigHalfInt}

            @eval @test $T(2):$T(2):$T(9/2) == $T(2):$T(2):$T(4)
            @eval @test first($T(2):$T(2):$T(9/2)) == 2
            @eval @test step($T(2):$T(2):$T(9/2)) == 2
            @eval @test last($T(2):$T(2):$T(9/2)) == 4
            @eval @test length($T(2):$T(2):$T(9/2)) == 2

            @eval @test first($T(2):$T(1/2):$T(5)) == 2
            @eval @test step($T(2):$T(1/2):$T(5)) == $T(1/2)
            @eval @test last($T(2):$T(1/2):$T(5)) == 5
            @eval @test length($T(2):$T(1/2):$T(5)) == 7

            @eval @test $T(5/2) ∈ $T(1/2):$T(2):$T(7)
            @eval @test $T(5/2) ∉ $T(1/2):$T(5/2):$T(7)
            @eval @test $T(2) ∈ $T(0):$T(1):$T(5/2)
            @eval @test $T(2) ∉ $T(1/2):$T(1):$T(5/2)
            @eval @test 2.5 ∈ $T(1/2):$T(2):$T(7)
            @eval @test 2.5 ∉ $T(1/2):$T(5/2):$T(7)
            @eval @test 5//2 ∈ $T(1/2):$T(2):$T(7)
            @eval @test 5//2 ∈ $T(1/2):2:$T(7)
            @eval @test 5//2 ∈ $T(1/2):2:7
            @eval @test 5//2 ∉ $T(1/2):$T(5/2):$T(7)
            @eval @test 2 ∈ $T(0):$T(1):$T(5/2)
            @eval @test 2 ∉ $T(1/2):$T(1):$T(5/2)
        end
        for T in (halfinttypes..., :BigHalfInt)
            @eval @test $T(2):$T(-1):$T(1/2) == $T(2):$T(-1):$T(1)
            @eval @test first($T(2):$T(-1):$T(1/2)) == 2
            @eval @test step($T(2):$T(-1):$T(1/2)) == -1
            @eval @test last($T(2):$T(-1):$T(1/2)) == 1
            @eval @test length($T(2):$T(-1):$T(1/2)) == 2

            @eval @test $T(5/2) ∉ $T(1/2):$T(-1):$T(-1/2)
            @eval @test 2.5 ∉ $T(1/2):$T(-1):$T(-1/2)
            @eval @test 5//2 ∉ $T(1/2):$T(-1):$T(-1/2)
            @eval @test 5//2 ∉ $T(1/2):-1:$T(-1/2)
        end
    end

    @testset "reverse" begin
        for T in (halfinttypes..., :BigHalfInt)
            # There is currently a discussion on how to treat Unsigned types:
            # * https://github.com/JuliaLang/julia/issues/29576
            # * https://github.com/JuliaLang/julia/pull/29842
            @eval @test @inferred(reverse($T(1/2):$T(9/2))) isa StepRange{$T}
            @eval @test @inferred(reverse($T(9/2):$T(-1):$T(1/2))) isa StepRange{$T}
            @eval @test reverse($T(1/2):$T(9/2)) == $T(9/2):$T(-1):$T(1/2)
            @eval @test reverse($T(9/2):$T(-1):$T(1/2)) == $T(1/2):$T(1):$T(9/2)
            @eval @test reverse($T(1/2):$T(1/2):$T(3)) == $T(3):$T(-1/2):$T(1/2)
            @eval @test reverse($T(-1/2):$T(2):$T(3/2)) == $T(3/2):$T(-2):$T(-1/2)
            @eval @test isempty(reverse($T(3/2):$T(1/2)))
            @eval @test isempty(reverse($T(3/2):$T(1):$T(1/2)))
            @eval @test isempty(reverse($T(3/2):$T(1/2):$T(1)))
            @eval @test isempty(reverse($T(7/2):$T(-2):$T(11/2)))
        end
    end

    @testset "intersect" begin
        for T in (halfinttypes..., halfuinttypes..., :BigHalfInt)
            @eval @test @inferred(($T(1):$T(3)) ∩ ($T(1/2):$T(3))) isa UnitRange{$T}
            @eval @test @inferred((big(1):big(3)) ∩ ($T(1/2):$T(3))) isa UnitRange{BigHalfInt}
            @eval @test @inferred(($T(1/2):$T(3)) ∩ (big(1):big(3))) isa UnitRange{BigHalfInt}
            @eval @test @inferred(($T(3/2):$T(1):$T(5)) ∩ ($T(1):$T(3))) isa StepRange{$T}
            @eval @test @inferred(($T(3/2):$T(1):$T(5)) ∩ (big(1):big(3))) isa StepRange{BigHalfInt}
            @eval @test @inferred((big(1):big(3)) ∩ ($T(3/2):$T(1):$T(5))) isa StepRange{BigHalfInt}
            @eval @test @inferred((big(1):big(3):big(7)) ∩ ($T(3/2):$T(5))) isa StepRange{BigHalfInt}
            @eval @test @inferred(($T(3/2):$T(5)) ∩ (big(1):big(3):big(7))) isa StepRange{BigHalfInt}
            @eval @test @inferred(($T(3/2):$T(1/2):$T(5)) ∩ ($T(1):$T(3):$T(5))) isa StepRange{$T}
            @eval @test @inferred((big(-1):big(3):big(5)) ∩ ($T(3/2):$T(1/2):$T(5))) isa StepRange{BigHalfInt}
            @eval @test @inferred(($T(3/2):$T(1/2):$T(5)) ∩ (big(-1):big(3):big(5))) isa StepRange{BigHalfInt}
            @eval @test isempty(($T(1):$T(3)) ∩ ($T(1/2):$T(3)))
            @eval @test ($T(1/2):$T(2)) ∩ ($T(3/2):$T(3)) == $T(3/2):$T(3/2)
            @eval @test isempty(($T(1/2):$T(2)) ∩ (1:2))
            @eval @test isempty((1:2) ∩ ($T(1/2):$T(2)))
            @eval @test ($T(2):$T(5)) ∩ (1:3) == 2:3
            @eval @test (1:3) ∩ ($T(2):$T(5)) == 2:3
            @eval @test ($T(2):$T(1):$T(5)) ∩ (1:3) == 2:1:3
            @eval @test (1:3) ∩ ($T(2):$T(1):$T(5)) == 2:1:3
            @eval @test isempty(($T(3/2):$T(1):$T(5)) ∩ (1:3))
            @eval @test isempty((1:3) ∩ ($T(3/2):$T(1):$T(5)))
            @eval @test ($T(2):$T(1/2):$T(5)) ∩ (1:3) == 2:1:3
            @eval @test (1:3) ∩ ($T(2):$T(1/2):$T(5)) == 2:1:3
            @eval @test ($T(3/2):$T(1/2):$T(5)) ∩ (1:3) == 2:1:3
            @eval @test (1:3) ∩ ($T(3/2):$T(1/2):$T(5)) == 2:1:3
            @eval @test ($T(2):$T(1):$T(5)) ∩ ($T(1):$T(3)) == $T(2):$T(1):$T(3)
            @eval @test ($T(1):$T(3)) ∩ ($T(2):$T(1):$T(5)) == $T(2):$T(1):$T(3)
            @eval @test isempty(($T(3/2):$T(1):$T(5)) ∩ ($T(1):$T(3)))
            @eval @test isempty(($T(1):$T(3)) ∩ ($T(3/2):$T(1):$T(5)))
            @eval @test ($T(2):$T(1/2):$T(5)) ∩ ($T(1):$T(3)) == $T(2):$T(1):$T(3)
            @eval @test ($T(1):$T(3)) ∩ ($T(2):$T(1/2):$T(5)) == $T(2):$T(1):$T(3)
            @eval @test ($T(3/2):$T(1/2):$T(5)) ∩ ($T(1):$T(3)) == $T(2):$T(1):$T(3)
            @eval @test ($T(1):$T(3)) ∩ ($T(3/2):$T(1/2):$T(5)) == $T(2):$T(1):$T(3)
            @eval @test ($T(3/2):$T(1):$T(6)) ∩ ($T(1):$T(3/2):$T(6)) == $T(5/2):$T(3):$T(11/2)
        end
        for T in (halfinttypes..., :BigHalfInt)
            @eval @test ($T(3/2):$T(1/2):$T(5)) ∩ (-1:3:5) == 2:3:5
            @eval @test (-1:3:5) ∩ ($T(3/2):$T(1/2):$T(5)) == 2:3:5
            @eval @test ($T(2):$T(1):$T(5)) ∩ (-1:3:5) == 2:3:5
            @eval @test (-1:3:5) ∩ ($T(2):$T(1):$T(5)) == 2:3:5
            @eval @test isempty(($T(3/2):$T(1):$T(5)) ∩ (-1:3:5))
            @eval @test isempty((-1:3:5) ∩ ($T(3/2):$T(1):$T(5)))
            @eval @test isempty(($T(3/2):$T(1):$T(5)) ∩ ($T(-1):$T(3):$T(5)))
            @eval @test isempty(($T(-1):$T(3):$T(5)) ∩ ($T(3/2):$T(1):$T(5)))
            @eval @test ($T(3/2):$T(1):$T(5)) ∩ ($T(-1):$T(3/2):$T(5)) == $T(7/2):$T(3):$T(7/2)
            # These tests should in theory also work for Unsigned types, but due to some
            # bugs with ranges of Unsigned integers, they currently don’t (see below)
            @eval @test ($T(5/2):$T(3/2):$T(7)) ∩ ($T(1):$T(8)) == $T(4):$T(3):$T(7)
            @eval @test ($T(1):$T(8)) ∩ ($T(5/2):$T(3/2):$T(7)) == $T(4):$T(3):$T(7)
            @eval @test isempty((1:3:7) ∩ ($T(3/2):$T(5)))
            @eval @test isempty(($T(3/2):$T(5)) ∩ (1:3:7))
            @eval @test (1:3:7) ∩ ($T(3):$T(5)) == 4:3:4
            @eval @test ($T(3):$T(5)) ∩ (1:3:7) == 4:3:4
        end
        # Ranges of UInts are currently broken, cf. e.g.
        # * https://github.com/JuliaLang/julia/issues/29576
        # * https://github.com/JuliaLang/julia/issues/29801
        # * https://github.com/JuliaLang/julia/issues/29810
        # These (or other) bugs related to ranges of Unsigned integers prevent some of the
        # following tests from passing
        for T in halfuinttypes
            @eval @test_broken ($T(5/2):$T(3/2):$T(7)) ∩ ($T(1):$T(8)) == $T(4):$T(3):$T(7)
            @eval @test_broken ($T(1):$T(8)) ∩ ($T(5/2):$T(3/2):$T(7)) == $T(4):$T(3):$T(7)
        end
        for T in (:HalfUInt8, :HalfUInt16)
            @eval @test isempty((1:3:7) ∩ ($T(3/2):$T(5)))
            @eval @test isempty(($T(3/2):$T(5)) ∩ (1:3:7))
            @eval @test (1:3:7) ∩ ($T(3):$T(5)) == 4:3:4
            @eval @test ($T(3):$T(5)) ∩ (1:3:7) == 4:3:4
        end
        @static if Sys.WORD_SIZE == 64
            @test isempty((1:3:7) ∩ (HalfUInt32(3/2):HalfUInt32(5)))
            @test isempty((HalfUInt32(3/2):HalfUInt32(5)) ∩ (1:3:7))
            @test (1:3:7) ∩ (HalfUInt32(3):HalfUInt32(5)) == 4:3:4
            @test (HalfUInt32(3):HalfUInt32(5)) ∩ (1:3:7) == 4:3:4
        else
            @test_broken isempty((1:3:7) ∩ (HalfUInt32(3/2):HalfUInt32(5)))
            @test_broken isempty((HalfUInt32(3/2):HalfUInt32(5)) ∩ (1:3:7))
            @test_broken (1:3:7) ∩ (HalfUInt32(3):HalfUInt32(5)) == 4:3:4
            @test_broken (HalfUInt32(3):HalfUInt32(5)) ∩ (1:3:7) == 4:3:4
        end
        for T in (:HalfUInt64, :HalfUInt128)
            @eval @test_broken isempty((1:3:7) ∩ ($T(3/2):$T(5)))
            @eval @test_broken isempty(($T(3/2):$T(5)) ∩ (1:3:7))
            @eval @test_broken (1:3:7) ∩ ($T(3):$T(5)) == 4:3:4
            @eval @test_broken ($T(3):$T(5)) ∩ (1:3:7) == 4:3:4
        end
    end
end
